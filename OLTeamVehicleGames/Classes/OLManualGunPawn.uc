class OLManualGunPawn extends ONSManualGunPawn placeable;

var() float RespawnDelay;
var() byte TeamNum;
var() bool bVehicleTeamLocked;

simulated event PostBeginPlay()
{
	local int OldTeamNum;

	Super.PostBeginPlay();
	
	if(Role == ROLE_Authority)
	{
		RespawnTime = RespawnDelay;
		bTeamLocked = bVehicleTeamLocked;
		
		OldTeamNum = Team;
		SetTeamNum(TeamNum);
		
		if(Team == OldTeamNum)
			TeamChanged(); //force event to occur
	}
}

defaultproperties
{
	RespawnDelay=15.00
	bVehicleTeamLocked=True
	bPowered=True
	GunClass=class'OLManualGun'
}
