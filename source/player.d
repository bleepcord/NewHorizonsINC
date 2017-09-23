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
    this(string name, string playerClass)
    {

        /* apply class modifiers */
        switch (playerClass) {
        case "rogue":
            this.health -= 20;
            this.strength += 2;
            this.constitution -= 2;
            this.dexterity += 8;
            break;
        case "fighter":
            this.health += 50;
            this.strength += 5;
            this.constitution += 8;
            this.dexterity += 2;
            break;
        case "psyker":
            this.health -= 40;
            this.strength -= 6;
            this.constitution -= 2;
            this.dexterity -= 2;
            break;
        default:
            break;
        }

        /* initialize player object as entity, apply default weapon and location. */
        super(name, health, strength, constitution, dexterity);
        super.setLocation(new Room("Main Hall", "Welcome to New Horizons INC"));
        super.addWeapon(new Pistol());
    }
}
