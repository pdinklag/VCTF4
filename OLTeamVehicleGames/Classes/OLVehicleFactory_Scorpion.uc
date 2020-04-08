class OLVehicleFactory_Scorpion extends OLVehicleFactory placeable;

defaultproperties
{
	Mesh=Mesh'ONSVehicles-A.RV'
	VehicleClass=class'OLRV'
	TeamBuildEffectClass(0)=class'ONSRVBuildEffectRed'
	TeamBuildEffectClass(1)=class'ONSRVBuildEffectBlue'
	TeamBuildEffectClass(2)=class'OLRVBuildEffectGreen'
	TeamBuildEffectClass(3)=class'OLRVBuildEffectGold'
	NeutralBuildEffectClass=class'OLRVBuildEffectWhite'
}
