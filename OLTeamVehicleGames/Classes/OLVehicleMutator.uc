class OLVehicleMutator extends OLTeamGamesMutator
    HideDropDown
    CacheExempt;

event PreBeginPlay()
{
	//make sure these get transfered to clients even if not listed in the ServerPackages
	AddToPackageMap("OLTeamGames");
	AddToPackageMap("OLTeamSkins");
	AddToPackageMap("OLTeamGamesAnnouncer");

	Super.PreBeginPlay();
}

function class<Weapon> GetWeaponReplacement(class<Weapon> W)
{
	local int i;

	for(i = 0; i < ReplaceArray.Length; i++)
	{
		if(W == ReplaceArray[i].OriginalWeapon)
		{
			if(class'OLTeamGame'.default.bUseColoredWeapons || ReplaceArray[i].bAlwaysReplace)
				return ReplaceArray[i].ReplacementWeapon;
		}
	}
	
	return W;
}

function bool CheckReplacement(Actor Other, out byte bSuperRelevant)
{
	local int i;
	local WeaponLocker Locker;
	
	//Unfortunately CTF4 doesn't care about weapon lockers
	Locker = WeaponLocker(Other);
	if(Locker != None)
	{
		for(i = 0; i < Locker.Weapons.length; i++)
			Locker.Weapons[i].WeaponClass = GetWeaponReplacement(Locker.Weapons[i].WeaponClass);
		
		return true;
	}
	
	//Fixed flags
	if(Other.IsA('OLRedFlagBase'))
		CTFBase(Other).FlagType = class'OLFixedRedFlag';
	else if(Other.IsA('OLBlueFlagBase'))
		CTFBase(Other).FlagType = class'OLFixedBlueFlag';
	else if(Other.IsA('OLGreenFlagBase'))
		CTFBase(Other).FlagType = class'OLFixedGreenFlag';
	else if(Other.IsA('OLGoldFlagBase'))
		CTFBase(Other).FlagType = class'OLFixedGoldFlag';

	return Super.CheckReplacement(Other, bSuperRelevant);
}

defaultproperties
{
	bAddToServerPackages=True
}
