import std.stdio;
import player;

void main()
{
    Player mainPlayer = new Player();
    assert(mainPlayer.getHealth() == 100);
}
