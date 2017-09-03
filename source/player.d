import entity;
import weapons;
import rooms;

class Player : Entity
{
private:
    int health = 100;
    int strength = 20;
    int constitution = 20;
    int dexterity = 20;
public:
    this(string name)
    {
        super(name, health, strength, constitution, dexterity);
        super.setLocation(new Room("Main Hall"));
        super.addWeapon(new Pistol());
    }
}
