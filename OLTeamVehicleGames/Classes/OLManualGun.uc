class OLManualGun extends ONSManualGun;

#EXEC OBJ LOAD FILE=Resources/OLVehicleSkins.utx PACKAGE=OLTeamVehicleGames

var class<ONSTurretBeamEffect> OLBeamEffectClass[4];

/*
    BEGIN: Needed by all vehicle weapons.
*/

var() Material TeamSkins[4];
var() Material NeutralSkin;
var() class<Emitter> TeamFlashEmitterClass[4];

var bool bEffectsInitialized;

simulated function InitEffects()
{
    // don't even spawn on server
    if (Level.NetMode == NM_DedicatedServer)
		return;
	
	bEffectsInitialized = true;
	
	// insert pre init effect code here

    if (FlashEmitter == None)
    {
		if(Team >= 0 && Team < 4 && TeamFlashEmitterClass[Team] != None)
			FlashEmitter = Spawn(TeamFlashEmitterClass[Team]);
		else
			FlashEmitter = Spawn(FlashEmitterClass);

		if(FlashEmitter != None)
		{
			FlashEmitter.SetDrawScale(DrawScale);
			if (WeaponFireAttachmentBone == '')
				FlashEmitter.SetBase(self);
			else
				AttachToBone(FlashEmitter, WeaponFireAttachmentBone);

			FlashEmitter.SetRelativeLocation(WeaponFireOffset * vect(1,0,0));
		}
    }

    if (AmbientEffectEmitterClass != none && AmbientEffectEmitter == None)
    {
        AmbientEffectEmitter = spawn(AmbientEffectEmitterClass, self,, WeaponFireLocation, WeaponFireRotation);
        if (WeaponFireAttachmentBone == '')
            AmbientEffectEmitter.SetBase(self);
        else
            AttachToBone(AmbientEffectEmitter, WeaponFireAttachmentBone);

        AmbientEffectEmitter.SetRelativeLocation(WeaponFireOffset * vect(1,0,0));
    }
	
	// insert post init effect code here
}

simulated function SetTeam(byte T)
{
    Team = T;
    if(T >= 0 && T < 4)
        Skins[0] = TeamSkins[T];
	else if(T == 255)
		Skins[0] = NeutralSkin;
	else
		Super.SetTeam(T);
	
	RepSkin = Skins[0];
	
	if(bEffectsInitialized && T >= 0 && T < 4 && TeamFlashEmitterClass[T] != None)
	{
		//re-initialize effects
		DestroyEffects();
		InitEffects();
	}
}

/*
    END: Needed by all vehicle weapons.
*/

state InstantFireMode
{
	simulated function SpawnHitEffects(actor HitActor, vector HitLocation, vector HitNormal)
	{
		local ONSTurretBeamEffect Beam;

		if (Level.NetMode != NM_DedicatedServer)
		{
			if (Role < ROLE_Authority)
			{
				CalcWeaponFire();
				DualFireOffset *= -1;
			}

            if (!Level.bDropDetail && Level.DetailMode != DM_Low)
            {
    			if (DualFireOffset < 0)
    				PlayAnim('RightFire');
    			else
    				PlayAnim('LeftFire');
    		}

			Beam = Spawn(OLBeamEffectClass[Team],,, WeaponFireLocation, rotator(HitLocation - WeaponFireLocation));
			BeamEmitter(Beam.Emitters[0]).BeamDistanceRange.Min = VSize(WeaponFireLocation - HitLocation);
			BeamEmitter(Beam.Emitters[0]).BeamDistanceRange.Max = VSize(WeaponFireLocation - HitLocation);
			BeamEmitter(Beam.Emitters[1]).BeamDistanceRange.Min = VSize(WeaponFireLocation - HitLocation);
			BeamEmitter(Beam.Emitters[1]).BeamDistanceRange.Max = VSize(WeaponFireLocation - HitLocation);
			Beam.SpawnEffects(HitLocation, HitNormal);
		}
	}
}

defaultproperties
{
    OLBeamEffectClass(0)=class'OLTurretBeamEffectRed'
    OLBeamEffectClass(1)=class'OLTurretBeamEffectBlue'
    OLBeamEffectClass(2)=class'OLTurretBeamEffectGreen'
    OLBeamEffectClass(3)=class'OLTurretBeamEffectGold'
	TeamSkins(0)=Shader'OLTeamVehicleGames.ManualGun.ManBaseGunShadRed'
	TeamSkins(1)=Shader'OLTeamVehicleGames.ManualGun.ManBaseGunShadBlue'
	TeamSkins(2)=Shader'OLTeamVehicleGames.ManualGun.ManBaseGunShadGreen'
	TeamSkins(3)=Shader'OLTeamVehicleGames.ManualGun.ManBaseGunShadGold'
	NeutralSkin=Shader'VMWeaponsTX.ManualBaseGun.ManBaseGunShad'
}
