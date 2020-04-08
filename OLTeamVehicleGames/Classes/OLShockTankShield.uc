class OLShockTankShield extends ONSShockTankShield;

var class<Emitter> TeamShieldEffect[4];
var class<Emitter> TeamShieldHitEffect[4];

simulated function SpawnHitEffect(byte TeamNum)
{
    if (Level.NetMode != NM_DedicatedServer)
    {
        if (ShockShieldEffect != None)
        {
            if (TeamNum >= 0 && TeamNum < 4)
                ShockShieldHitEffect = spawn(TeamShieldHitEffect[TeamNum], self);
            else
                ShockShieldHitEffect = spawn(class'ONSShockTankShieldHitEffectRed', self);
        }

        if (ShockShieldHitEffect != None && Owner != None && ONSShockTankCannon(Owner) != None)
            Owner.AttachToBone(ShockShieldEffect, 'ElectroGun');
    }
}

simulated function ActivateShield(byte TeamNum)
{
    SetCollision(True, False, False);

    if (Level.NetMode != NM_DedicatedServer)
    {
        if (ShockShieldEffect == None)
        {
            if (TeamNum >= 0 && TeamNum < 4)
                ShockShieldEffect = spawn(TeamShieldEffect[TeamNum], self);
            else
                ShockShieldEffect = spawn(class'ONSShockTankShieldEffectRed', self);

            PlaySound(sound'ONSBPSounds.ShockTank.ShieldActivate', SLOT_None, 2.0);
        }

        if (ShockShieldEffect != None && Owner != None && ONSShockTankCannon(Owner) != None)
            Owner.AttachToBone(ShockShieldEffect, 'ElectroGun');
    }
}

defaultproperties
{
	TeamShieldEffect(0)=class'OLShockTankShieldEffectRed'
	TeamShieldEffect(1)=class'OLShockTankShieldEffectBlue'
	TeamShieldEffect(2)=class'OLShockTankShieldEffectGreen'
	TeamShieldEffect(3)=class'OLShockTankShieldEffectGold'
	TeamShieldHitEffect(0)=class'ONSShockTankShieldHitEffectRed'
	TeamShieldHitEffect(1)=class'ONSShockTankShieldHitEffectBlue'
	TeamShieldHitEffect(2)=class'OLShockTankShieldHitEffectGreen'
	TeamShieldHitEffect(3)=class'OLShockTankShieldHitEffectGold'
}
