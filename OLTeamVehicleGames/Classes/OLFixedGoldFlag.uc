class OLFixedGoldFlag extends OLFixedCTFFlag;

#exec OBJ LOAD FILE=OLTeamGamesTex.utx
#exec OBJ LOAD FILE=TeamSymbols_UT2003.utx

simulated function PostBeginPlay()
{
	Super.PostBeginPlay();

	LoopAnim('flag',0.8);
	SimAnim.bAnimLoop = true;
}

defaultproperties
{
	TeamNum=3
	LightHue=39
	Mesh=VertMesh'XGame_rc.FlagMesh'
	DrawScale=0.900000
	Skins(0)=FinalBlend'OLTeamGamesTex.CTFTextures.GoldFlagShader_F'
}
