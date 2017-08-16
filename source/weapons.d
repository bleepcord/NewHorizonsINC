abstract class Weapon
{
private:
    string name;
    int damageLow;
    int damageHigh;
    int numberOfAttacks;
protected:
    this(string name, int damageLow, int damageHigh, int numberOfAttacks)
    {
        this.name = name;
        this.damageLow = damageLow;
        this.damageHigh = damageHigh;
        this.numberOfAttacks = numberOfAttacks;
    }
public:
    string getName { return this.name; }
    int getDamageLow { return this.damageLow; }
    int getDamageHigh { return this.damageHigh; }
    int getNumberOfAttacks { return this.numberOfAttacks; }
}

abstract class RangedWeapon : Weapon
{
private:
    int ammo;
protected:
    this(string name, int damageLow, int damageHigh, int numberOfAttacks)
    {
        super(name, damageLow, damageHigh, numberOfAttacks);
        this.ammo = ammo;
    }
public:
    int getAmmo { return this.ammo; }
}

class Pistol : RangedWeapon
{
private:
    string name = "pistol";
    int damageLow = 3;
    int damageHigh = 7;
    int numberOfAttacks = 1;
    int ammo = 7;
public:
    this()
    {
        super(name, damageLow, damageHigh, numberOfAttacks, ammo);
    }
}
