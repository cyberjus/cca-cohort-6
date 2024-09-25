
List<Dog> dogs = new List<Dog>();

GoldenRetriever golden = new GoldenRetriever('Indiana');
Pug pug = new Pug('Fido');
dogs.add(golden);
dogs.add(pug);

for (Dog d : dogs) {
  d.eat();
}

for (Dog d : dogs) {
 System.debug(d);
 System.debug(d.weight);
}