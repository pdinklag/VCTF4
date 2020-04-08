class OLRVWebLauncher extends ONSRVWebLauncher;

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

state ProjectileFireMode
{
	function CeaseFire(Controller C)
	{
		local vector GunDir, RightDir, FireDir;
		local int i, NumProjectiles;
		local float SpreadAngleRad, FireAngleRad; // Radians
		local OLRVWebProjectileLeader Leader;
		local OLRVWebProjectile P;

		if (!bHoldingFire)
			return;

		ClientPlayForceFeedback("BioRifleFire");

		AmbientSound = None;

		CalcWeaponFire();

		if (bCorrectAim)
			WeaponFireRotation = AdjustAim(false);

		// Defines plane in which projectiles will start travelling in.
		GunDir = vector(WeaponFireRotation);
		RightDir = normal( GunDir Cross vect(0,0,1) );

		NumProjectiles = MinProjectiles + (MaxProjectiles - MinProjectiles) * (FMin(Level.TimeSeconds - StartHoldTime, MaxHoldTime) / MaxHoldTime);
		bHoldingFire = false;

		SpreadAngleRad = SpreadAngle * (Pi/180.0);

		// Spawn all the projectiles
		for(i=0; i<NumProjectiles; i++)
		{
			FireAngleRad = (-0.5 * SpreadAngleRad * (NumProjectiles - 1)) + (i * SpreadAngleRad); // So shots are centered around FireAngle of zero.
			FireDir = (Cos(FireAngleRad) * GunDir) + (Sin(FireAngleRad) * RightDir);

			if(i == 0)
			{
				Leader = spawn(class'OLRVWebProjectileLeader', self, , WeaponFireLocation, rotator(FireDir));

				if(Leader != None)
				{
					Leader.Velocity += InheritVelocityScale * Instigator.Velocity;

					Leader.Projectiles.Length = NumProjectiles;
					Leader.ProjTeam = C.GetTeamNum();

					Leader.Projectiles[0] = Leader;
					Leader.ProjNumber = 0;
					Leader.Leader = Leader;
				}
			}
			else
			{
				P = spawn(class'OLRVWebProjectile', self, , WeaponFireLocation, rotator(FireDir));
				
				if(P != None && Leader != None)
				{
					Leader.Projectiles[i] = P;
					P.ProjNumber = i;
					P.Leader = Leader;
				}
			}
		}

		ShakeView();
		FlashMuzzleFlash();

		// Play firing noise
		if (bAmbientFireSound)
			AmbientSound = FireSoundClass;
		else
			PlayOwnedSound(FireSoundClass, SLOT_None, FireSoundVolume/255.0,, FireSoundRadius,, false);

		FireCountdown = FireInterval;
	}
}

defaultproperties
{
	TeamFlashEmitterClass(0)=class'OLRVWebLauncherMuzzleFlashRed'
	TeamFlashEmitterClass(1)=class'OLRVWebLauncherMuzzleFlashBlue'
	TeamFlashEmitterClass(2)=class'ONSRVWebLauncherMuzzleFlash'
	TeamFlashEmitterClass(3)=class'OLRVWebLauncherMuzzleFlashGold'
	TeamSkins(0)=Texture'VMWeaponsTX.RVgunGroup.RVnewGUNtex'
	TeamSkins(1)=Texture'VMWeaponsTX.RVgunGroup.RVnewGUNtex'
	TeamSkins(2)=Texture'VMWeaponsTX.RVgunGroup.RVnewGUNtex'
	TeamSkins(3)=Texture'VMWeaponsTX.RVgunGroup.RVnewGUNtex'
	NeutralSkin=Texture'VMWeaponsTX.RVgunGroup.RVnewGUNtex'
}
