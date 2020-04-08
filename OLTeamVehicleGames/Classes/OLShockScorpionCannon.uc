class OLShockScorpionCannon extends ONSWeapon;

#EXEC OBJ LOAD FILE=Resources/OLVehicleSkins.utx PACKAGE=OLTeamVehicleGames

var class<Emitter> TeamMuzzleFlash[4];

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

simulated event FlashMuzzleFlash()
{
    if (Role == ROLE_Authority)
    {
    	FlashCount++;
    	NetUpdateTime = Level.TimeSeconds - 1;
    }
    else
        CalcWeaponFire();

    if (FlashEmitter != None)
        FlashEmitter.Trigger(Self, Instigator);

    if ( EffectIsRelevant(Location,false) )
	{
		if(Team >= 0 && Team < 4)
			EffectEmitter = spawn(TeamMuzzleFlash[Team], self,, WeaponFireLocation, WeaponFireRotation);
		else
			EffectEmitter = spawn(EffectEmitterClass, self,, WeaponFireLocation, WeaponFireRotation);
	}
}

defaultproperties
{
	YawBone="rvGUNTurret"
	PitchBone="rvGUNbody"
	WeaponFireAttachmentBone="RVfirePoint"
	CullDistance=7500.000000
	FireSoundVolume=360.000000
	Mesh=SkeletalMesh'ONSWeapons-A.RVnewGun'
	bSelected=True
	PitchUpLimit=7500
	TeamSkins(0)=Texture'OLTeamVehicleGames.ShockScorpion.GunSkinRed'
	TeamSkins(1)=Texture'OLTeamVehicleGames.ShockScorpion.GunSkinBlue'
	TeamSkins(2)=Texture'OLTeamVehicleGames.ShockScorpion.GunSkinGreen'
	TeamSkins(3)=Texture'OLTeamVehicleGames.ShockScorpion.GunSkinGold'
	NeutralSkin=Texture'OLTeamVehicleGames.ShockScorpion.GunSkin'
	TeamMuzzleFlash(0)=class'OLShockTankMuzzleFlashRed'
	TeamMuzzleFlash(1)=class'OLShockTankMuzzleFlashBlue'
	TeamMuzzleFlash(2)=class'OLShockTankMuzzleFlashGreen'
	TeamMuzzleFlash(3)=class'OLShockTankMuzzleFlashGold'
	FireInterval=2.000000
	EffectEmitterClass=Class'ONSShockTankMuzzleFlash'
	FireSoundClass=Sound'ONSBPSounds.ShockTank.ShockBallFire'
	DamageType=Class'DamTypeShockScorpionShockBall'
	ProjectileClass=Class'OLShockTankProjectile'
	DrawScale=1.200000
}
