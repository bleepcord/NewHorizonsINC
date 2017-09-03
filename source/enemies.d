import entity;

/*
 * Base enemy class.
 */
abstract class Enemy : Entity
{
protected:
    this(string name, int health, int strength, int constitution, int dexterity)
    {
        super(name, health, strength, constitution, dexterity);
    }
}

/*
 * Enemy class definitions.
 */
class Rebel : Enemy
{
private:
    string name = "rebel";
    int health = 100;
    int strength = 20;
    int constitution = 20;
    int dexterity = 20;
public:
    this()
    {
        super(name, health, strength, constitution, dexterity);
    }
}
