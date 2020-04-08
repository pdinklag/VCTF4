class OLClientInfo extends ReplicationInfo;

var Interaction Interaction;

var string OldChatMenuClass;

simulated function ClientSetup(PlayerController PC)
{
	Interaction = PC.Player.InteractionMaster.AddInteraction(
		string(class'OLVehicleInteraction'), PC.Player);
	
	if(PC.Player.Console.IsA('ExtendedConsole'))
	{
		OldChatMenuClass = ExtendedConsole(PC.Player.Console).ChatMenuClass;
		ExtendedConsole(PC.Player.Console).ChatMenuClass = string(class'OLInGameChat');
	}
}

simulated event PostNetBeginPlay()
{
	Super.PostNetBeginPlay();
	
	if(Role < ROLE_Authority)
	{
		ClientSetup(Level.GetLocalPlayerController());
		Disable('Tick');
	}
}

simulated event Tick(float dt)
{
	local PlayerController PC;

	if(Level.NetMode == NM_Standalone && Interaction == None)
	{
		PC = Level.GetLocalPlayerController();
		if(PC != None)
		{
			ClientSetup(PC);
			Disable('Tick');
		}
	}
	else
	{
		Disable('Tick');
	}
}

simulated event Destroyed()
{
	local PlayerController PC;

	if(Interaction != None)
		Interaction.Master.RemoveInteraction(Interaction);
	
	Interaction = None;
	
	if(Level.NetMode != NM_DedicatedServer)
	{
		PC = Level.GetLocalPlayerController();
		if(PC != None)
		{
			if(PC.Player.Console.IsA('ExtendedConsole'))
				ExtendedConsole(PC.Player.Console).ChatMenuClass = OldChatMenuClass;
		}
	}
	
	Super.Destroyed();
}

defaultproperties
{
	NetUpdateFrequency=0.1
}
