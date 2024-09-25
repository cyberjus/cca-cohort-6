public with sharing class GoldenRetriever extends Dog {


    public GoldenRetriever(String name) {
        super(name);
    }

    public override void eat() {
        this.weight += 4;
    }

    public String fetch(String ball) {
        return ball;
    }
} 