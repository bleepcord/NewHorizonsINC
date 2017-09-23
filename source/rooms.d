import std.stdio;
import std.container : SList;
import std.json;

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
    int size;
    /*
     * TODO: Populate each room based on probablity of specific entity
     *       existing in the room.
     */
    auto enemies = SList!Entity();

    void spawnEnemies() {
    }

    /*
     * Set enemy locations based on the size of the room. Randomize distances.
     * Simple number to represent amount of turns before enemies reach player.
     * TODO: like enemies should have tendency to stick together.
     */
    void setEnemyLocations(){
    }
public:
    this(string name, string description)
    {
        this.name = name;
        this.north = null;
        this.east = null;
        this.west = null;
        this.south = null;
        this.description = description;
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
}
