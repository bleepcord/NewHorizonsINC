import std.stdio;
import std.string;
import std.array;

import entity;
import player;
import enemies;

void main()
{
    string name;
    writeln();
    writeln("Welcome to HorizonINC, what type of detective are you?\n" ~
            "Rogue\n" ~
            "Fighter\n" ~
            "Psyker\n");
    string command;
    bool validInput;
    string playerClass;

    /* Read input to set proper playerClass */
    do {
        command = stdin.readln();
        playerClass = command.split[0];
        switch(playerClass) {
        case "rogue":
            validInput = true;
            break;
        case "fighter":
            validInput = true;
            break;
        case "psyker":
            validInput = true;
            break;
        default:
            writeln("That is not a valid class.");
            break;
        }
    } while(!validInput);

    Entity player = new Player(name, playerClass);
    writeln("Base Stats");
    writeln("Health: ",       player.getHealth());
    writeln("Strength: ",     player.getStrength());
    writeln("Constitution: ", player.getConstitution());
    writeln("Dexterity: ",    player.getDexterity());
    writeln();



    /* Commands are issued with three levels from stdin.
     * levelOne is a basic action (e.g. move, attack, equip)
     * levelTwo is an instruction for levelOne (e.g. north, rebel, pistol)
     * levelThree is a modifier for levelOne (e.g. carefully, hastely)
     *
     * Not all levelOne commands have levelTwo and levelThree commands.
     * Some levelOne commands require a levelTwo command, but levelThree
     * commands are NEVER required.
     */
    string levelOne, levelTwo, levelThree, lastCommand;
    do {
        writeln();
        write("Action: ");
        command = stdin.readln();
        levelOne = command.split[0];
        switch(levelOne) {
        case "!!": // this must be at the top for the fallthrough to work properly
            command = lastCommand;
            goto case;
        case "help":
            write("Valid commands: command {required modifier} [optional modifier]\n",
                    "move {direction} [\"carefully\",\"hastely\"]\n",
                    "equip\n",
                    "inventory\n",
                    "quit\n",
                    "!!\n"
                    );
            break;
        case "move":
            levelTwo = command.split[1];
            player.move(levelTwo);
            writeln("Location: ", player.getLocation().getName(), "\n",
                    player.getLocation().getDescription());
            break;
        case "equip":
            levelTwo = command.split[1];
            player.equipWeapon(levelTwo);
            writeln("You equipped your ", player.getEquippedWeapon().getName());
            break;
        case "inventory":
            player.printInventory();
            break;
        case "quit":
            writeln("Thanks for playing.");
            return;
        default:
            writeln("Invalid command.");
            break;
        }
        lastCommand = command;
    } while (true); // may be unnecessary
}
