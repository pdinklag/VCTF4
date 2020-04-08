//Fixing bugs concerning CTF4 flags and vehicles
class OLFixedFakeFlag extends OLFakeCTFFlag;

function Drop(vector newVel)
{
    local OLTeamsPlayerReplicationInfo OLPRI;

    OLPRI = OLTeamsPlayerReplicationInfo(HolderPRI);

    while(OLPRI.HasFlags.Length > 0)
        OLPRI.HasFlags[0].Drop(newVel);
}

function SetHolder(Controller C)
{
    Super.SetHolder(C);
	HolderPRI = TeamPlayerReplicationInfo(C.PlayerReplicationInfo);
}

defaultproperties
{
}
