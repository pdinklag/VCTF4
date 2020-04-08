class OLPRVSideGun extends ONSPRVSideGun;

#EXEC OBJ LOAD FILE=Resources/OLVehicleSkins.utx PACKAGE=OLTeamVehicleGames

var() class<ShockBeamEffect> OLBeamEffectClass[4];

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

function SpawnBeamEffect(Vector Start, Rotator Dir, Vector HitLocation, Vector HitNormal, int ReflectNum)
{
    local ShockBeamEffect Beam;

	if(Team >= 0 && Team < 4)
	{
		Beam = Spawn(OLBeamEffectClass[Team],,, Start, Dir);
		Beam.Instigator = None; // prevents client side repositioning of beam start
		Beam.AimAt(HitLocation, HitNormal);
	}
	else
	{
		Super.SpawnBeamEffect(Start, Dir, HitLocation, HitNormal, ReflectNum);
	}
}

defaultproperties
{
    ProjectileClass=class'OLSkyMine'
	OLBeamEffectClass(0)=Class'OLTeamsRedShockBeamEffect'
	OLBeamEffectClass(1)=Class'OLTeamsBlueShockBeamEffect'
	OLBeamEffectClass(2)=Class'OLTeamsGreenShockBeamEffect'
	OLBeamEffectClass(3)=Class'OLTeamsGoldShockBeamEffect'
	TeamFlashEmitterClass(0)=Class'OLPRVSideGunMuzFlashRed'
	TeamFlashEmitterClass(1)=Class'OLPRVSideGunMuzFlashBlue'
	TeamFlashEmitterClass(2)=Class'OLPRVSideGunMuzFlashGreen'
	TeamFlashEmitterClass(3)=Class'OLPRVSideGunMuzFlashGold'
	TeamSkins(0)=Shader'OLTeamVehicleGames.PRV.newPRVredSHAD'
	TeamSkins(1)=Shader'OLTeamVehicleGames.PRV.newPRVshad'
	TeamSkins(2)=Shader'OLTeamVehicleGames.PRV.newPRVgreenSHAD'
	TeamSkins(3)=Shader'OLTeamVehicleGames.PRV.newPRVgoldSHAD'
	NeutralSkin=Texture'VMVehicles-TX.NEWprvGroup.newPRVnoColor'
}
