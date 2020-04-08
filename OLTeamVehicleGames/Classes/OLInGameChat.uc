class OLInGameChat extends UT2K4InGameChat;

var() editinlinenotify Color OLTextColor[5];

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
	local int i;
	local PlayerController PC;
	local ExtendedConsole MyConsole;

	Super(FloatingWindow).InitComponent(MyController, MyOwner);
	
	OLTextColor[0] = class'OLTeamsSayMessagePlus'.default.RedTeamColor;
	OLTextColor[1] = class'OLTeamsSayMessagePlus'.default.BlueTeamColor;
	//OLTextColor[2] = class'OLTeamsSayMessagePlus'.default.GreenTeamColor;
	OLTextColor[2] = class'OLTeamsSayMessagePlus'.default.BlueTeamColor;
	OLTextColor[3] = class'OLTeamsSayMessagePlus'.default.GoldTeamColor;
	OLTextColor[4] = class'OLTeamsSayMessagePlus'.default.DrawColor;
	
	sb_Main.ManageComponent(lb_Chat);
    eb_Send.MyEditBox.OnKeyEvent = InternalOnKeyEvent;
    lb_Chat.MyScrollText.bNeverFocus=true;
	
	PC = PlayerOwner();
	MyConsole = ExtendedConsole(PlayerOwner().Player.Console);
	if(MyConsole == None)
		return;
	
	MyConsole.OnChat = OLHandleChat;
	for(i = 0; i < MyConsole.ChatMessages.Length; i++)
	{
		if(
			!MyConsole.bTeamChatOnly ||
			PC.PlayerReplicationInfo == None ||
			PC.PlayerReplicationInfo.Team == None ||
			MyConsole.ChatMessages[i].Team == PC.PlayerReplicationInfo.Team.TeamIndex
		)
		{
			OLHandleChat(MyConsole.ChatMessages[i].Message, MyConsole.ChatMessages[i].Team);
		}
	}
}

function OLHandleChat(string Msg, int TeamIndex)
{
	local int i;
	local string str;

	i = InStr( Msg, ":" );
	if(TeamIndex < 4 && i != -1)
	{
		str = MakeColorCode(OLTextColor[TeamIndex]) $ Left(Msg, i) $
			MakeColorCode(OLTextColor[4]) $ ":" $ Mid(Msg, i+1);
	}
	else
	{
		str = MakeColorCode(OLTextColor[4]) $ Msg;
	}
	
	lb_chat.AddText( Msg );
}

defaultproperties
{
	Begin Object Class=GUIScrollTextBox Name=lbChat
		WinWidth=1.000000
		WinHeight=0.558333
		WinLeft=0.000000
		WinTop=0.441667
		CharDelay=0.0025
		EOLDelay=0
		StyleName="NoBackground"
        bNoTeletype=true
        bNeverFocus=true
        TextAlign=TXTA_Left
        bBoundToParent=true
        bScaleToParent=true
        FontScale=FNS_Small
        Separator="`"
	End Object
	lb_Chat=lbChat
}
