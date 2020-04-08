class OLArtilleryCannon extends ONSArtilleryCannon;

#EXEC OBJ LOAD FILE=Resources/OLVehicleSkins.utx PACKAGE=OLTeamVehicleGames

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

defaultproperties
{
	AltFireProjectileClass=class'OLMortarCamera'
	TeamSkins(0)=Shader'OLTeamVehicleGames.SPMA.SPMARedShader'
	TeamSkins(1)=Shader'OLTeamVehicleGames.SPMA.SPMABlueShader'
	TeamSkins(2)=Shader'OLTeamVehicleGames.SPMA.SPMAGreenShader'
	TeamSkins(3)=Shader'OLTeamVehicleGames.SPMA.SPMAGoldShader'
	NeutralSkin=Texture'OLTeamVehicleGames.SPMA.SPMANoColor'
}
