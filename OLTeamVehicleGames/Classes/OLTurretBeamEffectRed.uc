class OLTurretBeamEffectRed extends ONSTurretBeamEffect;

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
		Spawn(class'OLTeamsShockImpactFlareRed',,, HitLocation, HitRotation);
		Spawn(class'OLTeamsShockExplosionCoreRed',,, HitLocation+HitNormal*8, HitRotation);
	}
		
	if ( (PC.ViewTarget == None) || (VSize(PC.ViewTarget.Location - Location) > 4000) )
	{
		Emitters[2].Disabled = true;
		Emitters[3].Disabled = true;
		Emitters[4].Disabled = true;
	}
	if ( bFogDist && !PC.BeyondViewDistance(HitLocation, 4000) )
	{
		Spawn(class'OLTeamsShockImpactRingRed',,, HitLocation, HitRotation);
		Spawn(class'OLTeamsShockImpactScorchRed',,, HitLocation, rotator(-HitNormal));
	}	
}
