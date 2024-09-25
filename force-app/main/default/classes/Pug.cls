public with sharing class Pug extends Dog {
    
    public Pug(String name) {
        super(name);
    }

    public override void eat() {
        this.weight += 1;
    }

}