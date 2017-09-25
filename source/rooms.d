import std.stdio;
import std.container : SList;
import std.json;
import std.file : readText;
import std.conv : to;
import std.random : uniform;

import entity;

class Room
{
private:
    string name;
    Room north;
    Room east;
    Room west;
    Room south;
    string description;
    long size;
    long rebelSpawnChance;
    long infectedSpawnChance;
    long xenosSpawnChance;
    /*
     * TODO: Populate each room based on probablity of specific entity
     *       existing in the room.
     */
    auto enemies = SList!Entity();

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
    }

    string getName() {
        return this.name;
    }

    string getDescription() {
        return this.description;
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
     * Differs from getAdjacent function.
     * Allows player to look around and see adjacent rooms.
     * TODO: implement
     */
    string observeAdjacentRooms() {
        return "test";
    }

    void spawnEnemies() {
        
    }
}
