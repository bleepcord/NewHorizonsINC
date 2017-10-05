import std.stdio : writeln;
import std.container : SList;
import std.random : uniform;
import std.json;
import std.file : readText;

import weapons;
import rooms;

/*
 * Entity class declaration. Most stat handling is done through this class.
 * Player and enemy classes inherit from this class.
 *
 * Default player and enemy stats as well as default weapons
 * are detailed in their respective classes.
 *
 * Players and enemies are to be constructed as Entity types.
 */
abstract class Entity
{
private:
    /* Entity stats */
    string name;
    int health;
    int strength;
    int constitution;
    int dexterity;
    bool alive = true;
    /* SList of weapons in bag of holding */

    auto weapons = SList!Weapon();
    Weapon equippedWeapon;
    Room currentLocation;

    bool ableToAttack() {
        if (this.isAlive() == false) {
            return false;
        }
        if (this.equippedWeapon is null) {
            writeln("With what weapon dummy?");
            return false;
        }
        if (this.equippedWeapon.getAmmo() <= 0) {
            writeln("*click*");
            return false;
        }
        return true;
    }
protected:
    this(string name, int health, int strength, int constitution, int dexterity)
    {
        this.name = name;
        this.health = health;
        this.strength = strength;
        this.constitution = constitution;
        this.dexterity = dexterity;
    }

public:
    /*
     * Self expanatory accessors and mutators.
     */
    string getName() { return this.name; }
    int getHealth() { return this.health; }
    void decreaseHealth(int amountToDecrease) { this.health = this.health - amountToDecrease; }
    int getStrength() { return this.strength; }
    int getConstitution() { return this.constitution; }
    int getDexterity() { return this.dexterity; }
    Weapon getEquippedWeapon() { return this.equippedWeapon; }
    bool isAlive() { return this.alive; }
    Room getLocation() { return this.currentLocation; }
    int getUnitSizeHigh() { return 0; }
    int getUnitSizeLow() { return 0; }
    int getMemberIndex() { return 0; }

    void addWeapon(Weapon newWeapon) {
        weapons.stableInsert(newWeapon);
    }

    void destroySelf() {
        this.alive = false;
    }

    void equipWeapon(string weaponName) {
        /* Iterate over list of weapons and equip weapon with requested name */
        foreach(weapon; weapons) {
            if (weapon.getName() == weaponName) {
                this.equippedWeapon = weapon;
                return;
            } else {
                writeln("There does not appear to be a ", weaponName,
                        " in your inventory.");
            }
        }
    }

    void printInventory() {
        foreach (weapon; weapons) {
            writeln(weapon.getName());
        }
    }

    void attack(string opponentStr, string opponentIndex) {
        Entity opponent = this.currentLocation.getEnemy(opponentStr, opponentIndex);
        if (opponent is null) { writeln("Err in referencing opponent."); }
        if (!ableToAttack()) {
            return;
        }
        int damage;
        int random;

        random = uniform(0, 21);
        if (random == 20) {
            damage = this.equippedWeapon.getDamageHigh();
            damage *= 2;
            writeln("Critical hit!");
        } else {
            for (int i = 0; i < this.equippedWeapon.getNumberOfAttacks(); i++) {
                damage += uniform( this.equippedWeapon.getDamageLow(),
                                   this.equippedWeapon.getDamageHigh() );
            }
        }
        this.equippedWeapon.useAmmo();
        opponent.decreaseHealth(damage);

        if (opponent.getHealth() <= 0) {
            opponent.destroySelf();
        }

        writeln(this.getName(), " attacks ", opponent.getName(), " ",
                opponent.getMemberIndex(), " with ",
                this.equippedWeapon.getName(), " ",
                this.equippedWeapon.getNumberOfAttacks(), " time(s) for ",
                damage, " damage!");

        if (!opponent.isAlive()) {
            writeln(opponent.getName(), " ", opponent.getMemberIndex(), " is dead.");
        }
    }

    void setLocation(Room location) {
        this.currentLocation = location;
    }

    /*
     * Move entity.
     */
    void move(string direction) {

        /* If adjacent room does not exist already, create it. */
        if (this.currentLocation.getAdjacent(direction) is null) {
            string mapContent = readText("source/map.json");
            JSONValue map = parseJSON(mapContent);

            /* If there is no room in that direction, report back to player and do nothing. */
            if (map[this.currentLocation.getName()][direction].str == "nothing") {
                writeln("There is nothing in that direction.");
                return;
            }

            Room nextLocation = new Room(map[this.currentLocation.getName()][direction].str);
            this.currentLocation.setAdjacent(nextLocation, direction);
        }

        /* Set currentLocation to proper adjacent room. */
        this.currentLocation = this.currentLocation.getAdjacent(direction);
    }
}
