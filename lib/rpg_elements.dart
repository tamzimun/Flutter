abstract class Fightable {
  void attack();
}

mixin Flyable {
  void fly() {
    print('Flying...');
  }
}

mixin Magical {
  void castSpell() {
    print('Casting a spell...');
  }
}

class Item {
  String name;

  Item(this.name);
}

class Character implements Fightable {
  int health;
  int strength;

  Character(this.health, this.strength);

  @override
  void attack() {
    print('Attacking...');
  }

  void defend() {
    print('Defending...');
  }
}

class Monster implements Fightable {
  int health;
  int damage;

  Monster(this.health, this.damage);

  @override
  void attack() {
    print('Monster attacking...');
  }
}

class Mage extends Character with Magical {
  Mage(int health, int strength) : super(health, strength);
}

class Warrior extends Character with Flyable {
  Warrior(int health, int strength) : super(health, strength);
}