class OLMinigunTurret extends ASTurret_Minigun;

#EXEC OBJ LOAD FILE=Resources/OLVehicleSkins.utx PACKAGE=OLTeamVehicleGames

var Material TeamSkinA[4], TeamSkinB[4];
var Material NeutralSkinA, NeutralSkinB;
var Material RepSkins[2];

replication
{
	reliable if(Role == ROLE_Authority)
		RepSkins;
}

function KDriverEnter(Pawn P)
{
	Super.KDriverEnter(P);
	bTeamLocked = false;
}

function SetTeamNum(byte T)
{
	Super.SetTeamNum(T);
	
	if(T >= 0 && T < 4)
	{
		Skins[0] = TeamSkinB[T];
		Skins[1] = TeamSkinA[T];
	}
	else if(T == 255)
	{
		Skins[0] = NeutralSkinB;
		Skins[1] = NeutralSkinA;
	}
	
	RepSkins[0] = Skins[0];
	RepSkins[1] = Skins[1];
}

simulated event PostNetReceive()
{
	Super.PostNetReceive();

	if(Role < ROLE_Authority)
	{
		if(RepSkins[0] != None)
			Skins[0] = RepSkins[0];
		
		if(RepSkins[1] != None)
			Skins[1] = RepSkins[1];
	}
}

defaultproperties
{
	bNetNotify = true;
	TeamSkinA(0)=Combiner'OLTeamVehicleGames.MinigunTurret.ASMinigun1Red_C'
	TeamSkinA(1)=Combiner'OLTeamVehicleGames.MinigunTurret.ASMinigun1Blue_C'
	TeamSkinA(2)=Combiner'OLTeamVehicleGames.MinigunTurret.ASMinigun1Green_C'
	TeamSkinA(3)=Combiner'OLTeamVehicleGames.MinigunTurret.ASMinigun1Gold_C'
	TeamSkinB(0)=Combiner'OLTeamVehicleGames.MinigunTurret.ASMinigun2Red_C'
	TeamSkinB(1)=Combiner'OLTeamVehicleGames.MinigunTurret.ASMinigun2Blue_C'
	TeamSkinB(2)=Combiner'OLTeamVehicleGames.MinigunTurret.ASMinigun2Green_C'
	TeamSkinB(3)=Combiner'OLTeamVehicleGames.MinigunTurret.ASMinigun2Gold_C'
	NeutralSkinA=Combiner'AS_Weapons_TX.Minigun.ASMinigun1_C'
	NeutralSkinB=Combiner'AS_Weapons_TX.Minigun.ASMinigun2_C'
}
