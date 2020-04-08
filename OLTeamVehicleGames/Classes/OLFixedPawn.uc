class OLFixedPawn extends OLTeamPawn;

simulated function Setup(xUtil.PlayerRecord rec, optional bool bLoadNow)
{
	//when a Pawn becomes relevant while sitting in an open vehicle, CTF4 fails to setup the correct skin
	if(PlayerReplicationInfo == None && DrivenVehicle != None && DrivenVehicle.PlayerReplicationInfo != None)
		PlayerReplicationInfo = DrivenVehicle.PlayerReplicationInfo;
	
	Super.Setup(rec, bLoadNow);
}

//this override is just me being careful - I believe the original code can cause trouble with VCTF4 and forced characters
simulated event PostNetReceive()
{
	local string CharacterName;
	
	if(PlayerReplicationInfo == None && DrivenVehicle != None && DrivenVehicle.PlayerReplicationInfo != None)
		PlayerReplicationInfo = DrivenVehicle.PlayerReplicationInfo;
	
	if(PlayerReplicationInfo != None)
	{
		if(ForceDefaultCharacter())
			CharacterName = GetDefaultCharacter();
		else
			CharacterName = PlayerReplicationInfo.CharacterName;
		
		Setup(class'xUtil'.static.FindPlayerRecord(CharacterName));
		bNetNotify = false;
	}
}

defaultproperties
{
}
