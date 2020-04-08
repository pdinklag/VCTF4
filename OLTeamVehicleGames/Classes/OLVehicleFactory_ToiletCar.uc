class OLVehicleFactory_ToiletCar extends OLVehicleFactory placeable;

defaultproperties
{
	Mesh=Mesh'GenericSD.TC'
	VehicleClass=class'OLGenericSD'
	TeamBuildEffectClass(0)=class'ONSRVBuildEffectRed'
	TeamBuildEffectClass(1)=class'ONSRVBuildEffectBlue'
	TeamBuildEffectClass(2)=class'OLRVBuildEffectGreen'
	TeamBuildEffectClass(3)=class'OLRVBuildEffectGold'
	NeutralBuildEffectClass=class'OLRVBuildEffectWhite'
}
