class OLVehicleFactory_MinigunTurret extends ASVehicleFactory_MinigunTurret placeable;

var() class<Emitter> TeamBuildEffectClass[4];
var() bool bNeutral;

function byte SetVehicleTeam()
{
	if(bNeutral)
		return 255;
	else
		return VehicleTeam;
}

function VehicleSpawned()
{
	Super.VehicleSpawned();
	
	if(bNeutral)
		Child.bTeamLocked = false;
}

function SpawnBuildEffect()
{
    local rotator	YawRot;
	local int		TeamNum;

	TeamNum			= SetVehicleTeam();
    YawRot			= Rotation;
    YawRot.Roll		= 0;
    YawRot.Pitch	= 0;

	if(TeamNum >= 0 && TeamNum < 4)
		BuildEffect = Spawn(TeamBuildEffectClass[TeamNum],,, Location, YawRot);
	else
		BuildEffect = Spawn(BuildEffectClass,,, Location, YawRot);
}

defaultproperties
{
	RespawnDelay=10.000000
	bRespawnWhenDestroyed=True
	bSpawnBuildEffect=True
	VehicleClass=class'OLMinigunTurret'
	TeamBuildEffectClass(0)=class'ONSRVBuildEffectRed'
	TeamBuildEffectClass(1)=class'ONSRVBuildEffectBlue'
	TeamBuildEffectClass(2)=class'OLRVBuildEffectGreen'
	TeamBuildEffectClass(3)=class'OLRVBuildEffectGold'
}
