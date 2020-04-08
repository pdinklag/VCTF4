class OLMortarCamera extends ONSMortarCamera;

var class<Emitter> TeamThrusterClass[4];

simulated function SpawnThrusters()
{
	local int i;

	if ( Level.NetMode == NM_DedicatedServer || TeamNum < 0 || TeamNum >= 4 )
		return;
	
	for(i = 0; i < 4; i++)
		Thruster[i] = spawn(TeamThrusterClass[TeamNum]);
	
    AttachToBone(Thruster[0], 'BoosterRight');
    AttachToBone(Thruster[1], 'BoosterLeft');
    AttachToBone(Thruster[2], 'BoosterTop');
    AttachToBone(Thruster[3], 'BoosterBottom');
}

defaultproperties
{
	TeamThrusterClass(0)=class'ONSArtilleryCamThrusterRed'
	TeamThrusterClass(1)=class'ONSArtilleryCamThrusterBlue'
	TeamThrusterClass(2)=class'OLArtilleryCamThrusterGreen'
	TeamThrusterClass(3)=class'OLArtilleryCamThrusterGold'
}
