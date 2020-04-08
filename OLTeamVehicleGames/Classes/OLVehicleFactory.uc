class OLVehicleFactory extends ONSVehicleFactory
	abstract
	placeable;

var() class<Emitter> TeamBuildEffectClass[4];
var() class<Emitter> NeutralBuildEffectClass;
var() bool bTeamLocked;
var() bool bNeutral;

event PostNetBeginPlay()
{
	if(bNeutral)
		Activate(255);
	else
		Super.PostNetBeginPlay();
}

function SpawnBuildEffect()
{
    local rotator YawRot;
	
    YawRot = Rotation;
    YawRot.Roll = 0;
    YawRot.Pitch = 0;
	
	if(bNeutral)
		BuildEffect = Spawn(NeutralBuildEffectClass,,, Location, YawRot);
	else
		BuildEffect = Spawn(TeamBuildEffectClass[Max(0, Min(TeamNum, 3))],,, Location, YawRot);
}

function SpawnVehicle()
{
	Super.SpawnVehicle();
	
	if(LastSpawned != None)
	{
		if(bNeutral)
			LastSpawned.bTeamLocked = false;
		else
			LastSpawned.bTeamLocked = bTeamLocked;
	}
}

defaultproperties
{
	bTeamLocked=True
}
