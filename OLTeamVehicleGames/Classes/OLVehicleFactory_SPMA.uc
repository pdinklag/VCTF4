class OLVehicleFactory_SPMA extends OLVehicleFactory placeable;

defaultproperties
{
	Mesh=Mesh'ONSBPAnimations.ArtilleryMesh'
	VehicleClass=class'OLArtillery'
	TeamBuildEffectClass(0)=class'ONSPRVBuildEffectRed'
	TeamBuildEffectClass(1)=class'ONSPRVBuildEffectBlue'
	TeamBuildEffectClass(2)=class'OLPRVBuildEffectGreen'
	TeamBuildEffectClass(3)=class'OLPRVBuildEffectGold'
	NeutralBuildEffectClass=class'OLPRVBuildEffectWhite'
}
