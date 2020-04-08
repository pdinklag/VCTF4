class OLGenericSD extends ONSGenericSD;

#EXEC OBJ LOAD FILE=Resources/OLVehicleSkins.utx PACKAGE=OLTeamVehicleGames

/*
    BEGIN: Needed by all vehicles
*/

var() Material TeamSkins[4];
var() Material NeutralSkin;
var() Material NewSpawnOverlay[4];

simulated function PostNetBeginPlay()
{
	local int i;
	local bool bUseHeadlights;
	
	if(Level.NetMode != NM_DedicatedServer && Level.bUseHeadlights && !(Level.bDropDetail || (Level.DetailMode == DM_Low)))
	{
		bUseHeadlights = true;
		Level.bUseHeadlights = false; //HACK going to create these ourselves
	}
	
	Super.PostNetBeginPlay();
	
	if(bUseHeadlights)
	{
		Level.bUseHeadlights = true; //set back
		HeadlightCorona.Length = HeadlightCoronaOffset.Length;

		for(i=0; i<HeadlightCoronaOffset.Length; i++)
		{
			HeadlightCorona[i] = spawn( class'OLHeadlightCorona', self,, Location + (HeadlightCoronaOffset[i] >> Rotation) );
			HeadlightCorona[i].SetBase(self);
			HeadlightCorona[i].SetRelativeRotation(rot(0,0,0));
			HeadlightCorona[i].Skins[0] = HeadlightCoronaMaterial;
			HeadlightCorona[i].ChangeTeamTint(Team);
			HeadlightCorona[i].MaxCoronaSize = HeadlightCoronaMaxSize * Level.HeadlightScaling;
		}

		if(HeadlightProjectorMaterial != None && Level.DetailMode == DM_SuperHigh)
		{
			HeadlightProjector = spawn( class'ONSHeadlightProjector', self,, Location + (HeadlightProjectorOffset >> Rotation) );
			HeadlightProjector.SetBase(self);
			HeadlightProjector.SetRelativeRotation( HeadlightProjectorRotation );
			HeadlightProjector.ProjTexture = HeadlightProjectorMaterial;
			HeadlightProjector.SetDrawScale(HeadlightProjectorScale);
			HeadlightProjector.CullDistance	= ShadowCullDistance;
		}
	}
}

/*
	BEGIN: Needed by all weapon pawns and vehicles
*/
event KDriverEnter(Pawn P)
{
	local int i;
	local OLTeamsPlayerReplicationInfo PRI;

	Super.KDriverEnter(P);
	
	PRI = OLTeamsPlayerReplicationInfo(PlayerReplicationInfo);
	if(PRI != None)
	{
		for(i = 0; i < PRI.HasFlags.Length; i++)
			AttachFlag(PRI.HasFlags[i]);
	}
}

event bool KDriverLeave(bool bForceLeave)
{
	local int i;
	local OLTeamsPlayerReplicationInfo PRI;
	local Pawn FormerDriver;
	local bool bResult;

	FormerDriver = Driver;
	bResult = Super.KDriverLeave(bForceLeave);
	
	if(FormerDriver != None)
	{
		PRI = OLTeamsPlayerReplicationInfo(FormerDriver.PlayerReplicationInfo);
		if(PRI != None)
		{
			for(i = 0; i < PRI.HasFlags.Length; i++)
				FormerDriver.HoldFlag(PRI.HasFlags[i]);
		}
	}
	
	return bResult;
}

/*
	END: Needed by all weapon pawns and vehicles
*/

function AttachFlag(Actor FlagActor)
{
    local rotator MoreGameObjRot;

	if(!bDriverHoldsFlag && (FlagActor != None))
	{
        MoreGameObjRot.Roll = -1 * rand(3500);
        MoreGameObjRot.Pitch = -1 * rand(4000);
	
		AttachToBone(FlagActor,FlagBone);
		FlagActor.SetRelativeRotation(FlagRotation + MoreGameObjRot);
		FlagActor.SetRelativeLocation(FlagOffset);
	}
}

simulated event TeamChanged()
{
	local int i;

	Super(Vehicle).TeamChanged();

	if(Team >= 0 && Team < 4)
		Skins[0] = TeamSkins[Team];
	else if(Team == 255)
		Skins[0] = NeutralSkin;

	if(Level.NetMode != NM_DedicatedServer && Team >= 0 && Team < 4)
		SetOverlayMaterial(NewSpawnOverlay[Team], 1.5, True);

	for(i = 0; i < Weapons.Length; i++)
		Weapons[i].SetTeam(Team);

	if (Level.NetMode != NM_DedicatedServer)
	{
		for(i = 0; i < HeadlightCorona.Length; i++)
			HeadlightCorona[i].ChangeTeamTint(Team);
	}
}

/*
    END: Needed by all vehicles
*/

defaultproperties
{
    NewSpawnOverlay(0)=Material'XGameShaders.PlayerShaders.VehicleSpawnShaderRed'
    NewSpawnOverlay(1)=Material'XGameShaders.PlayerShaders.VehicleSpawnShaderBlue'
    NewSpawnOverlay(2)=Material'OLTeamGamesTex.Weapons.VehicleSpawnShaderGreen'
    NewSpawnOverlay(3)=Material'OLTeamGamesTex.Weapons.VehicleSpawnShaderGold'
	TeamSkins(0)=Texture'GenericSD.ToiletCar'
	TeamSkins(1)=Texture'GenericSD.ToiletCarBlue'
	TeamSkins(2)=Texture'OLTeamVehicleGames.ToiletCar.ToiletCarGreen'
	TeamSkins(3)=Texture'OLTeamVehicleGames.ToiletCar.ToiletCarGold'
	NeutralSkin=Texture'GenericSD.ToiletCar'
}
