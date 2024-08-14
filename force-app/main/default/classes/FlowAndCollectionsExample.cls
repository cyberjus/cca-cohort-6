public with sharing class FlowAndCollectionsExample {
  public static void runExample() {
    // Create list of winners - in a real scenario this might be from a SOQL query of records
    List<String> winners = new List<String>{
      'Team 1',
      'Team 2',
      'Team 1',
      'Team 3',
      'Team 1',
      'Team 2',
      'Team 3',
      'Team 1',
      'Team 1',
      'Team 2',
      'Team 2'
    };

    // Build a map of Team name to the number of times they win
    Map<String, Integer> winnerCounts = new Map<String, Integer>();
    for (String winner : winners) {
      // Check that we have set an index value for each team. 
      // Without the index we will get a null pointer reference error
      // when trying to update the win total
      if (!winnerCounts.containsKey(winner)) {
        winnerCounts.put(winner, 0);
      }
      // Re-set each team value with an updated win count 
      // by getting the previous total and adding 1
      winnerCounts.put(winner, winnerCounts.get(winner) + 1);
    }

    Decimal maxScore = 0; // To check who has the most wins
    String wonTheMost; // String to hold team name with most wins
    // Loop the key values of the map (the team names)
    for (String winner : winnerCounts.keySet()) {
      // Output the totals
      System.debug(winner + ' won ' + winnerCounts.get(winner) + ' games');
      // Check if the current team has more wins than what was previously max
      if (winnerCounts.get(winner) > maxScore) {
        // Change the variables for the team
        maxScore = winnerCounts.get(winner);
        wonTheMost = winner;
      }
    }

    // Output the results
    System.debug('The team that won the most was ' + wonTheMost);

  }
}
