//Fixing bugs concerning CTF4 flags and vehicles
class OLFixedCTFFlag extends OLCTFFlag abstract;

function SetHolder(Controller C)
{
    local OLCTFSquadAI S;
    local int i;
	local bool bAddFlag;
    local OLFakeCTFFlag FakeFlag;
    local OLTeamsTranslauncher TransLauncher;

    // AI Related
    if ( Bot(C) != None )
        S = OLCTFSquadAI(Bot(C).Squad);
    else if ( PlayerController(C) != None )
        S = OLCTFSquadAI(UnrealTeamInfo(C.PlayerReplicationInfo.Team).AI.FindHumanSquad());
    if ( S != None )
        S.OLEnemyFlagTakenBy(C, Team.TeamIndex);

    // If this is the player's first flag, we need to spawn the "fake" flag
    // This is for forward compatability with mutators not specifically coded
    // for CTF4.
    if(OLTeamsPlayerReplicationInfo(C.PlayerReplicationInfo).HasFlag == None)
    {
        FakeFlag = spawn(class'OLFixedFakeFlag');
        FakeFlag.SetHolder(C);
        OLTeamsPlayerReplicationInfo(C.PlayerReplicationInfo).HasFlag = FakeFlag;
    }

    // If "translocate with flags" is turned on, then be sure to destroy the current beacon.
    if( OLCTFGame(Level.Game).bTranslocateWithFlags )
    {
        TransLauncher = OLTeamsTranslauncher(UnrealPawn(C.Pawn).FindInventoryType(class'OLTeamsTranslauncher'));
        if(Translauncher != none && Translauncher.TransBeacon != none)
        {
            TransLauncher.TransBeacon.Destroy();
            TransLauncher.TransBeacon = none;
            TransLauncher.ViewPlayer();
        }
    }

    //log(self$" setholder c="$c, 'GameObject');
    LogTaken(c);
    Holder = UnrealPawn(C.Pawn);
    ReplicatedHolder = UnrealPawn(C.Pawn);
    Holder.DeactivateSpawnProtection();
    HolderPRI = TeamPlayerReplicationInfo(Holder.PlayerReplicationInfo);
	
	//HOTFIX: sometimes people capped a flag multiple times, this should prevent it ~pd
	bAddFlag = true;
	for(i = 0; i < OLTeamsPlayerReplicationInfo(C.PlayerReplicationInfo).HasFlags.Length; i++)
	{
		if(OLTeamsPlayerReplicationInfo(C.PlayerReplicationInfo).HasFlags[i] == Self)
		{
			bAddFlag = false;
			break;
		}
	}
	
	if(bAddFlag)
		OLTeamsPlayerReplicationInfo(C.PlayerReplicationInfo).HasFlags[OLTeamsPlayerReplicationInfo(C.PlayerReplicationInfo).HasFlags.Length] = self;
	
    OLTeamsGameReplicationInfo(GRI).OLFlagHolder[TeamNum] = C.PlayerReplicationInfo;
    C.PlayerReplicationInfo.NetUpdateTime = Level.TimeSeconds - 1;

    if(C.PlayerReplicationInfo.Team.TeamIndex == TeamNum)
        GotoState('HeldFriendly');
    else
        GotoState('Held');

    // AI Related
    C.MoveTimer = -1;
    Holder.MakeNoise(2.0);

    // Track First Touch

    if (FirstTouch == None)
        FirstTouch = C;

    // Track Assists

    for (i=0;i<Assists.Length;i++)
        if (Assists[i] == C)
          return;

    Assists.Length = Assists.Length+1;
    Assists[Assists.Length-1] = C;


    if(C.PlayerReplicationInfo.Team.TeamIndex == Team.TeamIndex)
        C.SendMessage(None, 'OTHER', C.GetMessageIndex('GOTOURFLAG'), 10, 'TEAM');
    else
        C.SendMessage(None, 'OTHER', C.GetMessageIndex('GOTENEMYFLAG'), 10, 'TEAM');
}

function ClearHolder()
{
	local int i;
	local OLTeamsPlayerReplicationInfo OLHolder;

	OLTeamsGameReplicationInfo(GRI).OLFlagHolder[TeamNum] = None;
	ReplicatedHolder = None;
	
	OLHolder = OLTeamsPlayerReplicationInfo(HolderPRI);
	if(OLHolder != None)
	{
		i = 0;
		while(i < OLHolder.HasFlags.Length)
		{
			if(OLHolder.HasFlags[i] == Self)
			{
				OLHolder.HasFlags.Remove(i, 1);
				OLHolder.NetUpdateTime = Level.TimeSeconds - 1;
			}
			else
			{
				i++;
			}
		}
		
		if(OLHolder.HasFlags.Length == 0 && OLHolder.HasFlag != None) //Fake flag
		{
			OLHolder.HasFlag.Destroy();
			OLHolder.HasFlag = None;
		}
	}

	Holder = None;
	HolderPRI = None;
}

defaultproperties
{
}
