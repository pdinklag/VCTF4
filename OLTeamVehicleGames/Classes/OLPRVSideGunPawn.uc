class OLPRVSideGunPawn extends ONSPRVSideGunPawn HideDropDown CacheExempt;

/*
	BEGIN: Needed by all weapon pawns and vehicles
*/
event KDriverEnter(Pawn P)
{
	local int i;
	local OLTeamsPlayerReplicationInfo PRI;

	Super.KDriverEnter(P);
	
	PRI = OLTeamsPlayerReplicationInfo(PlayerReplicationInfo);
	if(PRI != None)
	{
		for(i = 0; i < PRI.HasFlags.Length; i++)
			AttachFlag(PRI.HasFlags[i]);
	}
}

event bool KDriverLeave(bool bForceLeave)
{
	local int i;
	local OLTeamsPlayerReplicationInfo PRI;
	local Pawn FormerDriver;
	local bool bResult;

	FormerDriver = Driver;
	bResult = Super.KDriverLeave(bForceLeave);
	
	if(FormerDriver != None)
	{
		PRI = OLTeamsPlayerReplicationInfo(FormerDriver.PlayerReplicationInfo);
		if(PRI != None)
		{
			for(i = 0; i < PRI.HasFlags.Length; i++)
				FormerDriver.HoldFlag(PRI.HasFlags[i]);
		}
	}
	
	return bResult;
}

/*
	END: Needed by all weapon pawns and vehicles
*/

defaultproperties
{
	GunClass=class'OLPRVSideGun'
}
