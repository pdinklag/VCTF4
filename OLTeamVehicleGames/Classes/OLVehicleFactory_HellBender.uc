class OLVehicleFactory_HellBender extends OLVehicleFactory placeable;

defaultproperties
{
	Mesh=Mesh'ONSVehicles-A.PRVchassis'
	VehicleClass=class'OLPRV'
	TeamBuildEffectClass(0)=class'ONSPRVBuildEffectRed'
	TeamBuildEffectClass(1)=class'ONSPRVBuildEffectBlue'
	TeamBuildEffectClass(2)=class'OLPRVBuildEffectGreen'
	TeamBuildEffectClass(3)=class'OLPRVBuildEffectGold'
	NeutralBuildEffectClass=class'OLPRVBuildEffectWhite'
}
