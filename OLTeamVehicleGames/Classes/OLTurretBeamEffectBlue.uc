class OLTurretBeamEffectBlue extends ONSTurretBeamEffectBlue;

simulated function SpawnEffects(vector HitLocation, vector HitNormal)
{
	local rotator HitRotation;
	local PlayerController PC;
	local bool bFogDist;
	
	HitRotation = rotator(HitNormal);

	PC = Level.GetLocalPlayerController();
	if ( !PC.BeyondViewDistance(HitLocation, 0) )
	{
		bFogDist = true;
		Spawn(class'OLTeamsShockImpactFlareBlue',,, HitLocation, HitRotation);
		Spawn(class'OLTeamsShockExplosionCoreBlue',,, HitLocation+HitNormal*8, HitRotation);
	}
		
	if ( (PC.ViewTarget == None) || (VSize(PC.ViewTarget.Location - Location) > 4000) )
	{
		Emitters[2].Disabled = true;
		Emitters[3].Disabled = true;
		Emitters[4].Disabled = true;
	}
	if ( bFogDist && !PC.BeyondViewDistance(HitLocation, 4000) )
	{
		Spawn(class'OLTeamsShockImpactRingBlue',,, HitLocation, HitRotation);
		Spawn(class'OLTeamsShockImpactScorchBlue',,, HitLocation, rotator(-HitNormal));
	}	
}
