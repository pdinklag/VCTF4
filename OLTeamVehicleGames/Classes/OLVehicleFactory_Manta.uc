class OLVehicleFactory_Manta extends OLVehicleFactory placeable;

defaultproperties
{
	Mesh=Mesh'ONSVehicles-A.HoverBike'
	VehicleClass=class'OLHoverBike'
	TeamBuildEffectClass(0)=class'ONSHoverBikeBuildEffectRed'
	TeamBuildEffectClass(1)=class'ONSHoverBikeBuildEffectBlue'
	TeamBuildEffectClass(2)=class'OLHoverBikeBuildEffectGreen'
	TeamBuildEffectClass(3)=class'OLHoverBikeBuildEffectGold'
	NeutralBuildEffectClass=class'OLHoverBikeBuildEffectWhite'
}
