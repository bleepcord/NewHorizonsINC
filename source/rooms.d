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
    //auto enemies = SList!Entity();
public:
    this(string name)
    {
        this.name = name;
        this.north = null;
        this.east = null;
        this.west = null;
        this.south = null;
    }

    string getName() {
        return this.name;
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
}
