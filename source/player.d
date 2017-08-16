import entity;

class Player : Entity {
private:
    int health = 100;
    int strength = 20;
    int constitution = 20;
    int dexterity = 20;
public:
    this()
    {
        super(health, strength, constitution, dexterity);
    }
}
