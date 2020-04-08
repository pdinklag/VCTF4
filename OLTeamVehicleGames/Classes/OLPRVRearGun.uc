class OLPRVRearGun extends ONSPRVRearGun;

#EXEC OBJ LOAD FILE=Resources/OLVehicleSkins.utx PACKAGE=OLTeamVehicleGames

var class<OLChargeBeamEffect> TeamBeamEffectClass[4];

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
	
	// post init effect
    if (FlashEmitter != None) FlashEmitter.Trigger(self, Instigator);
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
	local OLChargeBeamEffect Beam;

	if(Team < 0 || Team >= 4)
	{
		Super.SpawnBeamEffect(Start, Dir, HitLocation, HitNormal, ReflectNum);
		return;
	}

	if (ReflectNum == 0)
		Start = WeaponFireLocation;

	Beam = spawn(TeamBeamEffectClass[Team],,, Start, Dir);
	Beam.SetDrawScale(DamageScale);
	Beam.HitLocation = HitLocation;

	if (Level.NetMode != NM_DedicatedServer)
		Beam.SetupBeam();
}

defaultproperties
{
	TeamSkins(0)=Shader'OLTeamVehicleGames.PRV.newPRVredSHAD'
	TeamSkins(1)=Shader'OLTeamVehicleGames.PRV.newPRVshad'
	TeamSkins(2)=Shader'OLTeamVehicleGames.PRV.newPRVgreenSHAD'
	TeamSkins(3)=Shader'OLTeamVehicleGames.PRV.newPRVgoldSHAD'
	NeutralSkin=Texture'VMVehicles-TX.NEWprvGroup.newPRVnoColor'
	TeamBeamEffectClass(0)=class'OLChargeBeamEffectRed'
	TeamBeamEffectClass(1)=class'OLChargeBeamEffectBlue'
	TeamBeamEffectClass(2)=class'OLChargeBeamEffectGreen'
	TeamBeamEffectClass(3)=class'OLChargeBeamEffectGold'
	TeamFlashEmitterClass(0)=class'OLPRVRearGunChargeRed'
	TeamFlashEmitterClass(1)=class'OLPRVRearGunChargeBlue'
	TeamFlashEmitterClass(2)=class'OLPRVRearGunChargeGreen'
	TeamFlashEmitterClass(3)=class'OLPRVRearGunChargeGold'
}
