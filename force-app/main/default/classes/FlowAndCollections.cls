public with sharing class FlowAndCollections {
    
    
  public static void demoFlowControl() {
    // if (condition) {}
    String testString = 'hello world';
    Boolean testTheString = (testString == 'hello world!' || testString == 'hello world');

    if (testTheString) {
      // Run the commands here 
      System.debug('the statement was true');
    } else if (testString == 'hello world') {
      System.debug('the statement met the second condition');
    } else {
      System.debug('the statement was false');
    }
      
      
    System.debug('%%%% results - ' + testString);
  }


  public static void demoCollections() {
    // List, Set, Map

    List<String> listOfStrings = new List<String> { 'asdfasdg', 'dfgad', '3', '4' };
    System.debug(listOfStrings.size());
    System.debug(listOfStrings);

    listOfStrings.add('5');
    listOfStrings.add('6');
    System.debug(listOfStrings);

    listOfStrings.remove(0);

    System.debug(listOfStrings);
    System.debug(listOfStrings.size());

    Set<String> setOfStrings = new Set<String>();

    setOfStrings.add('1');
    setOfStrings.add('2');
    setOfStrings.add('1');

    System.debug(setOfStrings);


    Map<String, Decimal> mapOfDecimals = new Map<String, Decimal>();

    mapOfDecimals.put('one', 1);
    mapOfDecimals.put('two', 2);
    mapOfDecimals.put('one', 3);

    System.debug(mapOfDecimals);
    System.debug(mapOfDecimals.get('one'));



  }


  public static void demoLoops() {
    // Loops - for, for-in

    Integer stop = 5;

    List<String> listOfStrings = new List<String> {'0', '1', '2', '3'};

    for (Integer i=0; i<listOfStrings.size(); i++) {
      // Execute this code block for every item
      System.debug(listOfStrings.get(i));
      if (i > 1) break;
    }

    Integer n = 0;
    for (String str : listOfStrings) {
      if (n == 1) continue;
      System.debug(str);
      if (n > 1) break;
      n++;
    }


 
  }


}