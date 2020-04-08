class OLShockTankCannon extends ONSShockTankCannon;

#EXEC OBJ LOAD FILE=Resources/OLVehicleSkins.utx PACKAGE=OLTeamVehicleGames

var class<Emitter> TeamMuzzleFlash[4];
var class<Emitter> TeamShieldComboHit[4];
var class<Emitter> TeamShieldProximityExplosion[4];

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

simulated function PostNetBeginPlay()
{
    Super(ONSWeapon).PostNetBeginPlay();

    ShockShield = spawn(class'OLShockTankShield', self);

    if (ShockShield != None)
        AttachToBone(ShockShield, 'ElectroGun');
}

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

function ProximityExplosion()
{
    local Emitter ComboHit;

	if(Team >= 0 && Team < 4)
		ComboHit = Spawn(TeamShieldComboHit[Team], self);
	else
		ComboHit = Spawn(class'ONSShockTankShieldComboHit', self);
	
	if ( Level.NetMode == NM_DedicatedServer )
	{
		ComboHit.LifeSpan = 0.6;
	}
    AttachToBone(ComboHit, 'BigGun');
    ComboHit.SetRelativeLocation(vect(300,0,0));
    SetTimer(0.5, false);
}

function Timer()
{
    PlaySound(sound'ONSBPSounds.ShockTank.ShockBallExplosion', SLOT_None,1.0,,800);
	
	if(Team >= 0 && Team < 4)
		Spawn(TeamShieldProximityExplosion[Team], self,, Location + vect(0,0,-70));
    else
		Spawn(class'ONSShockTankProximityExplosion', self,, Location + vect(0,0,-70));
	
	
    HurtRadius(200, 900, class'DamTypeShockTankProximityExplosion', 150000, Location);
}

defaultproperties
{
	ProjectileClass=class'OLShockTankProjectile'
	TeamSkins(0)=Shader'OLTeamVehicleGames.ShockTank.PaladinRedShader'
	TeamSkins(1)=Shader'OLTeamVehicleGames.ShockTank.PaladinBlueShader'
	TeamSkins(2)=Shader'OLTeamVehicleGames.ShockTank.PaladinGreenShader'
	TeamSkins(3)=Shader'OLTeamVehicleGames.ShockTank.PaladinGoldShader'
	NeutralSkin=Texture'OLTeamVehicleGames.ShockTank.PaladinNoColor'
	TeamMuzzleFlash(0)=class'OLShockTankMuzzleFlashRed'
	TeamMuzzleFlash(1)=class'OLShockTankMuzzleFlashBlue'
	TeamMuzzleFlash(2)=class'OLShockTankMuzzleFlashGreen'
	TeamMuzzleFlash(3)=class'OLShockTankMuzzleFlashGold'
	TeamShieldComboHit(0)=class'OLShockTankShieldComboHitRed'
	TeamShieldComboHit(1)=class'OLShockTankShieldComboHitBlue'
	TeamShieldComboHit(2)=class'OLShockTankShieldComboHitGreen'
	TeamShieldComboHit(3)=class'OLShockTankShieldComboHitGold'
	TeamShieldProximityExplosion(0)=class'OLShockTankProximityExplosionRed'
	TeamShieldProximityExplosion(1)=class'OLShockTankProximityExplosionBlue'
	TeamShieldProximityExplosion(2)=class'OLShockTankProximityExplosionGreen'
	TeamShieldProximityExplosion(3)=class'OLShockTankProximityExplosionGold'
}
