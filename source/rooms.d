import std.stdio;
import std.container : SList;
import std.json;
import std.file : readText;
import std.conv : to;
import std.random : uniform;
import std.algorithm : each;

import entity;
import enemies;

class Room
{
private:
    string name;
    Room north, east, west, south;
    string description;
    long size;
    long rebelSpawnChance, infectedSpawnChance, xenosSpawnChance;
    /*
     * TODO: Populate each room based on probablity of specific entity
     *       existing in the room.
     */
    auto enemies = SList!Entity();

    void spawnEnemies() {
        /* boolean vals of whether to spawn unit or not. Randomize these as
         * successes or failures based on the spawn chance of each enemy type for
         * the room. Then build if necessary.
         */
        enum enemyType { REBEL, INFECTED, XENOS }
        bool[3] spawns = false;
        UnitBuilder unitBuilder = new UnitBuilder();

        // TODO: I hate this and would like to change it
        if (uniform(0, 101) < rebelSpawnChance) {
            spawns[enemyType.REBEL] = true;
        }
        if (uniform(0, 101) < infectedSpawnChance) {
            spawns[enemyType.INFECTED] = true;
        }
        if (uniform(0, 101) < xenosSpawnChance) {
            spawns[enemyType.XENOS] = true;
        }

        /* Appears to work properly */
        for (int i = 0; i < spawns.length; i++) {
            if (spawns[i] is true) {
                enemies.stableInsert(unitBuilder.buildUnit(i));
            }
        }
    }

    /*
     * Set enemy locations based on the size of the room. Randomize distances.
     * Simple number to represent amount of turns before enemies reach player.
     * TODO: like enemies should have tendency to stick together.
     */
    void setEnemyLocations(){
    }
public:
    this(string name)
    {
        string mapContent = readText("source/map.json");
        JSONValue map = parseJSON(mapContent);

        this.name = name;
        this.north = null;
        this.east = null;
        this.west = null;
        this.south = null;
        this.description = map[this.name]["description"].str;
        this.size = map[this.name]["size"].integer;
        this.rebelSpawnChance = map[this.name]["rebelSpawnChance"].integer;
        this.infectedSpawnChance = map[this.name]["infectedSpawnChance"].integer;
        this.xenosSpawnChance = map[this.name]["xenosSpawnChance"].integer;
        if (name == "Main Hall") {
            return;
        }
        this.spawnEnemies();
    }

    string getName() {
        return this.name;
    }

    string getDescription() {
        return this.description;
    }

    void listEnemies() {
        foreach (enemy; enemies) {
            writeln(enemy.getName());
        }
    }

    void setAdjacent (Room adjacentRoom, string direction)
    {
        switch (direction)
        {
            case "north":
                this.north = adjacentRoom;
                adjacentRoom.south = this;
                break;
            case "east":
                this.east = adjacentRoom;
                adjacentRoom.west = this;
                break;
            case "west":
                this.west = adjacentRoom;
                adjacentRoom.east = this;
                break;
            case "south":
                this.south = adjacentRoom;
                adjacentRoom.north = this;
                break;
            default:
                break;
        }
    }

    Room getAdjacent(string direction) {
        switch (direction)
        {
            case "north":
                return this.north;
            case "east":
                return this.east;
            case "west":
                return this.west;
            case "south":
                return this.south;
            default:
                return null;
        }
    }

    /*
     * Allows player to look around and see adjacent rooms.
     */
    void observeAdjacentRooms() {
        string mapContent = readText("source/map.json");
        JSONValue map = parseJSON(mapContent);

        writeln("North: ", map[this.name]["north"],
                "\nEast: ", map[this.name]["east"],
                "\nWest: ", map[this.name]["west"],
                "\nSouth: ", map[this.name]["south"]);

    }
}
