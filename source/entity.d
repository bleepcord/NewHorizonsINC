abstract class Entity
{
private:
    int health;
    int strength;
    int constitution;
    int dexterity;
    bool alive = true;
protected:
    this(int health, int strength, int constitution, int dexterity)
    {
        this.health = health;
        this.strength = strength;
        this.constitution = constitution;
        this.dexterity = dexterity;
    }
public:
    int getHealth() { return this.health; }
    int getStrength() { return this.strength; }
    int getConstitution() { return this.constitution; }
    int getDexterity() { return this.dexterity; }
    bool isAlive() { return this.alive; }
}

