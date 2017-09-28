import std.random : uniform;

import entity;

/*
 * Base enemy class.
 */
abstract class Enemy : Entity
{
protected:
    /*
     * distanceInRoom to simulate location in a specific room.
     * main player always assumed to enter at the door, enemies
     * distanceInRoom var represents number of turns player has
     * before enemy reaches them. (can be adjustd with dexterity)
     */
    int distanceInRoom;
    int unitSizeLow;
    int unitSizeHigh;
    this(string name, int health, int strength, int constitution, int dexterity, int unitSizeLow, int unitSizeHigh)
    {
        super(name, health, strength, constitution, dexterity);
        this.unitSizeLow = unitSizeLow;
        this.unitSizeHigh = unitSizeHigh;
    }
public:
    override int getUnitSizeHigh() { return this.unitSizeHigh; }
    override int getUnitSizeLow() { return this.unitSizeLow; }
}

/*
 * Enemy class definitions.
 */
class Rebel : Enemy
{
private:
    string name = "rebel";
    int health = 100;
    int strength = 20;
    int constitution = 20;
    int dexterity = 20;
    int unitSizeLow = 1;
    int unitSizeHigh = 5;
public:
    this()
    {
        super(name, health, strength, constitution, dexterity, unitSizeLow, unitSizeHigh);
    }
}

class Infected : Enemy
{
private:
    string name = "infected";
    int health = 200;
    int strength = 30;
    int constitution = 30;
    int dexterity = 15;
    int unitSizeLow = 1;
    int unitSizeHigh = 10;
public:
    this()
    {
        super(name, health, strength, constitution, dexterity, unitSizeLow, unitSizeHigh);
    }
}

class Xenos : Enemy
{
private:
    string name = "xenos";
    int health = 300;
    int strength = 50;
    int constitution = 50;
    int dexterity = 35;
    int unitSizeLow = 1;
    int unitSizeHigh = 2;
public:
    this()
    {
        super(name, health, strength, constitution, dexterity, unitSizeLow, unitSizeHigh);
    }
}

class UnitBuilder
{
private:
    Entity rebelBase = new Rebel();
    Entity infectedBase = new Infected();
    Entity xenosBase = new Xenos();
    enum enemyType { REBEL, INFECTED, XENOS }
public:
    Entity[] buildUnit(int enemyTypeToBuild) {
        int randomUnitSize;
        Entity[] returnUnit;
        switch(enemyTypeToBuild) {
        case this.enemyType.REBEL:
            randomUnitSize = uniform(rebelBase.getUnitSizeLow(), rebelBase.getUnitSizeHigh());
            returnUnit = new Entity[randomUnitSize];
            for (int i = 0; i < randomUnitSize; i++) {
                returnUnit[i] = new Rebel();
            }
            break;
        case this.enemyType.INFECTED:
            randomUnitSize = uniform(infectedBase.getUnitSizeLow(), infectedBase.getUnitSizeHigh());
            returnUnit = new Entity[randomUnitSize];
            for (int i = 0; i < randomUnitSize; i++) {
                returnUnit[i] = new Infected();
            }
            break;
        case this.enemyType.XENOS:
            randomUnitSize = uniform(xenosBase.getUnitSizeLow(), xenosBase.getUnitSizeHigh());
            returnUnit = new Entity[randomUnitSize];
            for (int i = 0; i < randomUnitSize; i++) {
                returnUnit[i] = new Xenos();
            }
            break;
        default:
            return null;
        }
    return returnUnit;
    }
}
