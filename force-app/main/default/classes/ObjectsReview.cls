public class ObjectsReview {

    public Integer id = 1;
    public String name;
    public static String staticName;
    public InnerC innerC;

    public ObjectsReview() {
        this.name = 'Default';
        this.innerC = new InnerC();
    }

    public ObjectsReview(String n) {
        this.name = n;
    }

    public ObjectsReview(String n, Integer id) {
        this.name = n;
        this.id = id;
        String str = n + ' something at the end';
        this.name = str;
    }

    public void changeId(Integer id) {
        this.id = id;
    }

    public String sayHello() {
        return buildGreeting(this.name, 'Hello');
    }

    public String sayGreeting(String greeting) {
        return buildGreeting(this.name, greeting);
    }

    public static String buildGreeting(String name, String greeting) {
        return name + ' ' + greeting + ' ' + staticName + '!';
    }

    public class InnerC {

        public InnerC() {}

    }



}