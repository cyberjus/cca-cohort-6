public virtual with sharing class Dog {
  public String name;
  public Integer weight;
  public String color;
  public Date birthdate;

  public Dog(String name) {
    this.name = name;
    this.weight = 10;
  }

  public void bark() {
    if (this.weight > 50) {
      System.debug('BARK');
    } else {
      System.debug('bark');
    }
  }

  public virtual void eat() {
    this.weight += 2;
  }

}
