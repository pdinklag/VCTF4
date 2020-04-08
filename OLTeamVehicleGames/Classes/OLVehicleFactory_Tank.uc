class OLVehicleFactory_Tank extends OLVehicleFactory placeable;

defaultproperties
{
	Mesh=Mesh'ONSVehicles-A.HoverTank'
	VehicleClass=class'OLHoverTank'
	RespawnTime=30.0
	TeamBuildEffectClass(0)=class'ONSTankBuildEffectRed'
	TeamBuildEffectClass(1)=class'ONSTankBuildEffectBlue'
	TeamBuildEffectClass(2)=class'OLTankBuildEffectGreen'
	TeamBuildEffectClass(3)=class'OLTankBuildEffectGold'
	NeutralBuildEffectClass=class'OLTankBuildEffectWhite'
}
