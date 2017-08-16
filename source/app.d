import std.stdio;
import player;

void main()
{
    Player mainPlayer = new Player();
    writeln("health ", mainPlayer.getHealth());
    writeln("strength ", mainPlayer.getStrength());
    writeln("constitution: ", mainPlayer.getConstitution());
    writeln("dexterity ", mainPlayer.getDexterity());
}
