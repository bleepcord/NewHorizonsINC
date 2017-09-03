import std.stdio;
/*
 * Weapon class, ranged and melee weapon classes inherit from this.
 */
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
    string getName() { return this.name; }
    int getDamageLow() { return this.damageLow; }
    int getDamageHigh() { return this.damageHigh; }
    int getNumberOfAttacks() { return this.numberOfAttacks; }
    int getAmmo() {
        writeln("You cannot reload this weapon.");
        return 0;
    }
    void useAmmo() {
        return;
    }
    void reload() {
        writeln("This weapon cannot be reloaded.");
    }
}

/*
 * Ranged weapon class.
 * All ranged weapons inherit from this class.
 */

abstract class RangedWeapon : Weapon
{
private:
    int magazineSize;
    int ammo;
    int getMagazineSize() { return this.magazineSize; }
protected:
    this(string name, int damageLow, int damageHigh, int numberOfAttacks, int magazineSize, int ammo)
    {
        super(name, damageLow, damageHigh, numberOfAttacks);
        this.magazineSize = magazineSize;
        this.ammo = ammo;
    }
public:
    override int getAmmo() { return this.ammo; }
    override void useAmmo() { this.ammo--;}
    override void reload() {
        this.ammo = this.magazineSize;
        writeln("You reloaded your ", this.getName(), ".");
    }
}

/*
 * Ranged weapon classes.
 */

class Pistol : RangedWeapon
{
private:
    string name = "pistol";
    int damageLow = 10;
    int damageHigh = 50;
    int numberOfAttacks = 1;
    int magazineSize = 7;
    int ammo = 7;
public:
    this()
    {
        super(name, damageLow, damageHigh, numberOfAttacks, magazineSize, ammo);
    }
}
class Shotgun : RangedWeapon
{
private:
    string name = "shotgun";
    int damageLow = 6;
    int damageHigh = 12;
    int numberOfAttacks = 12;
    int magazineSize = 5;
    int ammo = 5;
public:
    this()
    {
        super(name, damageLow, damageHigh, numberOfAttacks, magazineSize, ammo);
    }
}

/*
 * Melee weapon class.
 * All melee weapons inherit from this class.
 */

abstract class MeleeWeapon : Weapon
{
private:
    int weight;
    int length;
protected:
    this(string name, int damageLow, int damageHigh, int numberOfAttacks, int weight, int length)
    {
        super(name, damageLow, damageHigh, numberOfAttacks);
        this.weight = weight;
        this.length = length;
    }
}

/*
 * Melee weapon classes.
 */

class Dagger : MeleeWeapon
{
private:
    string name = "dagger";
    int damageLow = 1;
    int damageHigh = 5;
    int numberOfAttacks = 2;
    int weight = 1;
    int length = 1;
public:
    this()
    {
        super(name, damageLow, damageHigh, numberOfAttacks, weight, length);
    }
}
