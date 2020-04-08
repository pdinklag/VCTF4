class OLHeadlightCorona extends ONSHeadlightCorona;

var byte TeamHue[4];

simulated function ChangeTeamTint(byte T)
{
	if(T >= 0 && T < 4)
		LightHue = TeamHue[T];
	
	LightSaturation=192;
}

defaultproperties
{
	TeamHue(0)=0
	TeamHue(1)=128
	TeamHue(2)=64
	TeamHue(3)=32
}
