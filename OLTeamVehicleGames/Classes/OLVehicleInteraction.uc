/*
	Epic is a bunch of assholes...
	The "no entry" icon on locked vehicles is drawn *only* if the player who is looking at it is team 0 or 1...
	at least they did provide that piece of native code so I can replicate it.
	
	For this, I'm gonna need an interaction.
*/
class OLVehicleInteraction extends Interaction;

var Color WhiteColor;

function PostRender(Canvas C)
{
	local PlayerController PC;
	local vector CameraLocation, CamDir, ScreenPos;
	local rotator CameraRotation;
	local Vehicle V;
	local float Dist, ScaledDist, XScale, YScale;
	local int Team;
	local Actor RefActor;
	local float MaxDist;
	
	if(ViewportOwner.GUIController.bActive)
		return;
	
	PC = ViewportOwner.Actor;
	if(PC == None || PC.PlayerReplicationInfo == None || PC.PlayerReplicationInfo.bOnlySpectator)
		return;
	
	Team = PC.GetTeamNum();
	if(Team < 0 || Team >= 4)
		return;
	
	C.GetCameraLocation(CameraLocation, CameraRotation);
	CamDir = vector(CameraRotation);
	
	if(PC.IsA('OLTeamPlayerController'))
		MaxDist = OLTeamPlayerController(PC).OLTeamBeaconPlayerInfoMaxDist;
	else
		MaxDist = PC.TeamBeaconPlayerInfoMaxDist;
	
	RefActor = PC.Pawn;
	
	if(RefActor == None)
		RefActor = PC.ViewTarget;
	
	foreach RefActor.DynamicActors(class'Vehicle', V)
	{
		if(V == PC.Pawn) //currently driving it
			continue;
	
		if(V.Team != Team && !V.bTeamLocked)
			continue;

		if((V.Location - CameraLocation) dot CamDir < 0)
			continue;

		if(!PC.FastTrace(CameraLocation, V.Location))
			continue;
		
		//Health bar (source: UnVehicle.cpp)
		if(V.Team == Team && V.TeamBeaconTexture != None)
		{
			Dist = PC.FOVBias * VSize(V.Location - CameraLocation);
			ScaledDist = MaxDist * FClamp(0.04f * V.CollisionRadius, 1.0f, 3.0f);
		
			if(Dist > ScaledDist)
				continue;
		
			C.Style = 5;
			
			XScale = FClamp((MaxDist - Dist) / MaxDist, 0.7f, 1.0f);
			XScale = XScale * XScale * 0.5f;
			
			/*
			The C++ code contains this, but it causes weird effects when getting close to the vehicle... thus, removed.
			
			if(Dist < 10.0f * V.CollisionRadius)
				XScale *= 3.0f * FMax(0.333f, (10.0f * V.CollisionRadius - Dist) / (10.0f * V.CollisionRadius));
			else
			*/
				XScale *= FMax(0.5f, (ScaledDist - Dist) / (ScaledDist - 1.5f * MaxDist));
			
			YScale = 0.25f * XScale;
			
			ScreenPos = C.WorldToScreen(V.Location + V.CollisionHeight * vect(0, 0, 1.75f));
			ScreenPos.X -= V.TeamBeaconTexture.MaterialUSize() * XScale * 0.5f;
			ScreenPos.Y -= V.TeamBeaconTexture.MaterialVSize() * XScale * 0.5f;
			
			if(V.TeamBeaconBorderMaterial != None)
			{
				C.DrawColor = WhiteColor;
				C.SetPos(ScreenPos.X, ScreenPos.Y);
				C.DrawTile(
					V.TeamBeaconBorderMaterial,
					V.TeamBeaconBorderMaterial.MaterialUSize() * XScale,
					V.TeamBeaconBorderMaterial.MaterialVSize() * YScale,
					0, 0, V.TeamBeaconBorderMaterial.MaterialUSize(), V.TeamBeaconBorderMaterial.MaterialVSize());
			}
			
			if(V.Health / V.HealthMax > 0.5f)
			{
				C.DrawColor.R = byte(255.0f * FClamp(1.0f - (V.HealthMax - (V.HealthMax - V.Health) * 2.0f) / V.HealthMax, 0.0f, 1.0f));
				C.DrawColor.G = 255;
				C.DrawColor.B = 0;
				C.DrawColor.A = 255;
			}
			else
			{
				C.DrawColor.R = 255;
				C.DrawColor.G = byte(255.0f * FClamp(2.0f * V.Health / V.HealthMax, 0.0f, 1.0f));
				C.DrawColor.B = 0;
				C.DrawColor.A = 255;
			}
			
			C.SetPos(ScreenPos.X, ScreenPos.Y);
			C.DrawTile(
				V.TeamBeaconTexture,
				V.TeamBeaconTexture.MaterialUSize() * XScale * (V.Health / V.HealthMax),
				V.TeamBeaconTexture.MaterialVSize() * YScale,
				0, 0, V.TeamBeaconTexture.MaterialUSize(), V.TeamBeaconTexture.MaterialVSize());
		}
	
		//No entry sign (source: UnVehicle.cpp)
		if(V.Team != Team && V.bTeamLocked)
		{
			Dist = VSize(V.Location - CameraLocation);
			if(Dist < MaxDist * 2.0f)
			{
				XScale = FClamp((2.0f * MaxDist - Dist) / (2.0f * MaxDist), 0.55f, 1.0f);
				XScale = XScale * XScale;
				
				ScreenPos = C.WorldToScreen(V.Location);
				ScreenPos.X -= V.NoEntryTexture.MaterialUSize() * XScale * 0.5f;
				ScreenPos.Y -= V.NoEntryTexture.MaterialVSize() * XScale * 0.5f;
				
				C.DrawColor = WhiteColor;
				C.SetPos(ScreenPos.X, ScreenPos.Y);
				C.DrawTile(
					V.NoEntryTexture,
					V.NoEntryTexture.MaterialUSize() * XScale,
					V.NoEntryTexture.MaterialVSize() * XScale,
					0, 0, V.NoEntryTexture.MaterialUSize(), V.NoEntryTexture.MaterialVSize());
			}
		}
	}
}

event NotifyLevelChange()
{
	Master.RemoveInteraction(Self);
}

defaultproperties
{
	WhiteColor=(R=255,G=255,B=255,A=255)
	bVisible=True
}
