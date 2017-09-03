import std.stdio;
import std.string;
import std.array;

import entity;
import player;
import enemies;

bool processInput(string command) {
    command.split;
    foreach (element; command) {
        writeln(element);
    }
    return true;
}

void main()
{
    string name = "player";
    writeln();
    writeln("Welcome to HorizonINC, what type of detective are you?\n" ~
            "Rogue\n" ~
            "Fighter\n" ~
            "Psyker\n");
    Entity player = new Player(name);
    Entity enemy = new Rebel();

    string input;
    input = stdin.readln();
    processInput(input);
}
