import std.stdio;
import std.string;
import std.array;
import std.algorithm.comparison : cmp;

import entity;
import player;

/* validate number of arguments
 *
 * inputLine and required argument count
 */
bool validArgs(string inputLine, int rargc)
{
    rargc--;
    if (inputLine.split.length > rargc) {
        return true;
    }
    else {
        writeln("This command requires at least ", rargc, " arguments");
        return false;
    }
}

void main()
{
    string name = "Player";
    writeln();
    writeln("Welcome to HorizonINC, what type of detective are you?\n" ~
            "Rogue\n" ~
            "Fighter\n" ~
            "Psyker\n");
    string command;
    string lastCommand;
    string playerClass;
    bool validInput;

    /* Read input to set proper playerClass */
    string levelOne, levelTwo, levelThree;
    do {
        command = stdin.readln();
        playerClass = command.split[0].toLower();
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

    /*
     * Commands are issued in up to three levels.
     * levelOne is a basic action (e.g. move, attack, equip)
     * levelTwo is an instruction for levelOne (e.g. north, rebel, pistol)
     * levelThree is a modifier for levelOne (e.g. carefully, hastely)
     *
     * Not all levelOne commands have levelTwo and levelThree commands.
     * Some levelOne commands require a levelTwo command, but levelThree
     * commands are NEVER required.
     */
    do {
        writeln();
        write("Action: ");
        command = stdin.readln();
        if (command.length == 1) { continue; }
        /* repeat last command */
        if (cmp(command.strip(), "!!") == 0) {
            command = lastCommand;
        }

        levelOne = command.split[0];
        switch(levelOne) {
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
            if (!validArgs(command, 2)) { break; }
            levelTwo = command.split[1];
            player.move(levelTwo);
            writeln("Location: ", player.getLocation().getName(), "\n",
                    player.getLocation().getDescription());
            player.getLocation().listEnemies();
            break;
        case "equip":
            if (!validArgs(command, 2)) { break; }
            levelTwo = command.split[1];
            player.equipWeapon(levelTwo);
            writeln("You equipped your ", player.getEquippedWeapon().getName());
            break;
        case "attack":
            if (!validArgs(command, 3)) { break; }
            levelTwo = command.split[1];
            levelThree = command.split[2];
            try {
                player.attack(levelTwo, levelThree);
            }
            catch (Throwable ex) {
                writeln("Unable to attack that enemy. Are you sure that enemy exists?");
                break;
            }
            break;
        case "fight":
            if (!validArgs(command, 3)) { break; }
            levelTwo = command.split[1];
            levelThree = command.split[2];
            try {
                player.fight(levelTwo, levelThree);
            }
            catch (Throwable ex) {
                writeln("Unable to attack that enemy. Are you sure that enemy exists?");
                break;
            }
            break;
        case "inventory":
            player.printInventory();
            break;
        case "observe":
            player.getLocation().observeAdjacentRooms();
            player.getLocation().listEnemies();
            break;
        case "ammo":
            if (player.getEquippedWeapon() is null) {
                writeln("No weapon equipped.");
                break;
            }
            writeln(player.getEquippedWeapon().getAmmo(), "/",
                    player.getEquippedWeapon().getMagSize());
            break;
        case "quit":
            writeln("Thanks for playing.");
            return;
        default:
            writeln("Invalid command.");
            break;
        }
        player.getLocation().enemyTurn();
        lastCommand = command;
    } while (true);
}
