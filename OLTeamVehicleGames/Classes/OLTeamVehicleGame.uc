//Base class for other vehicle based multi-team games, e.g. ONS4
class OLTeamVehicleGame extends OLTeamGame abstract;

event PostBeginPlay()
{
	Super.PostBeginPlay();
	Spawn(class'OLClientInfo');
}

/*
    BEGIN: Needed by all 4-team game classes.
*/

//Set pawn class for players
event PlayerController Login( string Portal, string Options, out string Error )
{
    local PlayerController PC;

    PC = Super.Login(Portal, Options, Error);
    if(PC != None)
        PC.PawnClass = class'OLFixedPawn';

    return PC;
}

//Set pawn class for bots
function Bot SpawnBot(optional string botName)
{
    local Bot B;

    B = Super.SpawnBot(botName);

    if(B != None)
        B.PawnClass = class'OLFixedPawn';

    return B;
}

//respawn player or kick him out if he's a bot and his team is too large
function RestartPlayer(Controller aPlayer)
{
	local TeamInfo BotTeam, SmallestTeam;

	if(
		(!bPlayersVsBots || (Level.NetMode == NM_Standalone)) &&
		bBalanceTeams && aPlayer.IsA('Bot') &&
		(!bCustomBots || (Level.NetMode != NM_Standalone))
	)
    {
        BotTeam = aPlayer.PlayerReplicationInfo.Team;

        SmallestTeam = GetSmallestTeam();
        if(SmallestTeam.Size < BotTeam.Size - 1)
        {
			aPlayer.Destroy();
			return;
        }
    }

	Super(DeathMatch).RestartPlayer(aPlayer);
}

//pick what team to go to when joining or changing
function byte PickTeam(byte N, Controller C)
{
	local UnrealTeamInfo NewTeam;
	local Controller B;
	local int i, Smallest, SmallestNumPlayers, TeamPlayers[4];

	//Players vs bots
	if(bPlayersVsBots && Level.NetMode != NM_Standalone)
	{
		if(C.IsA('PlayerController'))
			return 0;
		else
			return GetSmallestBotTeam();
	}

	if(N < 4)
		NewTeam = Teams[N];

	if(NewTeam == None)
	{
		NewTeam = GetSmallestTeam();
	}
	else if(bPlayersBalanceTeams && Level.NetMode != NM_Standalone && C.IsA('PlayerController'))
	{
		//get team sizes for all teams
		for(i = 0; i < NumTeams; i++)
			TeamPlayers[i] = Teams[i].Size;
		
		//subtract all bots from the team sizes
		for(B = Level.ControllerList; B != None; B = B.NextController)
		{
			if(B.PlayerReplicationInfo != None && B.PlayerReplicationInfo.bBot && B.PlayerReplicationInfo.Team != None)
				TeamPlayers[B.PlayerReplicationInfo.Team.TeamIndex]--;
		}
		
		//find team with least amount of non-bot players
		Smallest = -1;
		for(i = 0; i < NumTeams; i++)
		{
			if(Smallest == -1 || TeamPlayers[i] < TeamPlayers[Smallest])
			{
				Smallest = i;
				SmallestNumPlayers = TeamPlayers[Smallest];
			}
		}
		
		if(TeamPlayers[NewTeam.TeamIndex] > SmallestNumPlayers)
			NewTeam = Teams[Smallest];
	}
	
	return NewTeam.TeamIndex;
}

//find out whether or not to remove this bot
function bool TooManyBots(Controller Bot)
{
	if(Level.NetMode != NM_Standalone && bPlayersVsBots)
	{
        return (NumBots > Min(16, BotRatio * NumPlayers));
	}
	
	if(Bot.PlayerReplicationInfo != None && Bot.PlayerReplicationInfo.Team != None)
	{
		if(Bot.PlayerReplicationInfo.Team.Size < GetSmallestTeam().Size)
			return false;

		if(Level.NetMode != NM_Standalone && NumBots + NumPlayers > MinPlayers)
			return (Bot.PlayerReplicationInfo.Team == GetBiggestTeam());
	}
	
	return false;
}

//find currently smallest team
function UnrealTeamInfo GetSmallestTeam()
{
    local int Smallest, i;

    Smallest = -1;
    for(i = 0; i < NumTeams; i++)
    {
		if(OLTeamsGameReplicationInfo(GameReplicationInfo).TeamEliminated[i] == 1)
			continue;

        if(Smallest == -1 || Teams[i].Size < Teams[Smallest].Size)
            Smallest = i;
    }

    return Teams[Smallest];
}

//find currently biggest team
function UnrealTeamInfo GetBiggestTeam()
{
    local int Biggest, i;

    Biggest = -1;
    for(i = 0; i < NumTeams; i++)
    {
		if(OLTeamsGameReplicationInfo(GameReplicationInfo).TeamEliminated[i] == 1)
			continue;

        if(Biggest == -1 || Teams[i].Size > Teams[Biggest].Size)
            Biggest = i;
    }

    return Teams[Biggest];
}

//find currently smallest bot team for players vs bots
function int GetSmallestBotTeam()
{
    local int Smallest, i;

    Smallest = -1;
    for(i = 1; i < NumTeams; i++)
    {
		if(OLTeamsGameReplicationInfo(GameReplicationInfo).TeamEliminated[i] == 1)
			continue;

        if(Smallest == -1 || Teams[i].Size < Teams[Smallest].Size)
            Smallest = i;
    }

    return Smallest;
}

//find team for bot
function UnrealTeamInfo FindTeamFor(Controller C)
{
	local int i;
	
	for(i = 0; i < NumTeams; i++)
	{
		if(OLTeamsGameReplicationInfo(GameReplicationInfo).TeamEliminated[i] == 1)
			continue;
	
		if(Teams[i].BelongsOnTeam(C.Pawn.class))
			return Teams[i];
	}

	return GetBotTeam();
}

//find team for bot
function UnrealTeamInfo GetBotTeam(optional int TeamBots)
{
	local int i, k;
	
	if(bPlayersVsBots && Level.NetMode != NM_Standalone)
		return Teams[GetSmallestBotTeam()];
	
	if(Level.NetMode == NM_Standalone || !bBalanceTeams)
	{
		for(i = 0; i < NumTeams; i++)
		{
			if(Teams[i].AllBotsSpawned())
			{
				for(k = 0; k < NumTeams; k++)
				{
					if(k != i && !Teams[k].AllBotsSpawned())
						return Teams[k];
				}
			}
		}
	}

	return GetSmallestTeam();
}

//check if the team was eliminated
function bool CheckForElimination(int TeamIndex)
{
	local Controller C;
	local bool bEliminated;
	
	bEliminated = Super.CheckForElimination(TeamIndex);
	
	if(bEliminated)
	{
		//Distribute all players of the eliminated team among the remaining teams
		for(C = Level.ControllerList; C != None; C = C.NextController)
		{
			if(
				C.bIsPlayer &&
				C.PlayerReplicationInfo != None &&
				C.PlayerReplicationInfo.Team != None && 
				C.PlayerReplicationInfo.Team.TeamIndex == TeamIndex
			)
			{
				if(C.Pawn != None)
					C.Pawn.Suicide();
			
				if(!ChangeTeam(C, TeamIndex, true))
					Warn("Failed to switch" @ C.GetHumanReadableName() @ "to another team!");
			}
		}
	}
	
	return bEliminated;
}

//perform a team change and return whether it happened
function bool ChangeTeam(Controller Other, int N, bool bNewTeam)
{
	local UnrealTeamInfo NewTeam;

	if(bMustJoinBeforeStart && GameReplicationInfo.bMatchHasBegun)
		return false;

    if(Other.IsA('PlayerController') && Other.PlayerReplicationInfo.bOnlySpectator)
    {
        Other.PlayerReplicationInfo.Team = None;
        return true;
    }

	NewTeam = Teams[PickTeam(N, Other)];

	if(Other.PlayerReplicationInfo.Team == NewTeam)
		return false;

	if(Other.PlayerReplicationInfo.Team != None)
		Other.PlayerReplicationInfo.Team.RemoveFromTeam(Other);

	if(NewTeam.AddToTeam(Other))
	{
		BroadcastLocalizedMessage(GameMessageClass, 3, Other.PlayerReplicationInfo, None, NewTeam);

		if(bNewTeam && PlayerController(Other) != None)
			GameEvent("TeamChange", string(N), Other.PlayerReplicationInfo);
	}
	return true;
}

/*
    END: Needed by all 4-team game classes.
*/

defaultproperties
{
	MutatorClass="OLTeamVehicleGames.OLVehicleMutator"
}
