public with sharing class GameManager {
  public static void runMockGames(Integer teamCount) {
    List<Game> games = new List<Game>();

    // Add Games
    for (Integer i = 1; i <= teamCount; i++) {
      for (Integer n = teamCount; n > i; n--) {
        games.add(new Game('Team ' + i, 'Team ' + n));
      }
    }

    // Show Schedule
    System.debug('---- Schedule ----');
    for (Game g : games) {
      System.debug(g.teamOne + ' vs. ' + g.teamTwo);
    }

    // Play Games
    System.debug(' ');
    System.debug('---- Scores ----');
    for (Game g : games) {
      Integer scoreOne = Integer.valueof((Math.random() * 20));
      Integer scoreTwo = Integer.valueof((Math.random() * 20));
      g.recordScores(scoreOne, scoreTwo);
      System.debug(
        g.teamOne + ': ' + scoreOne + ' - ' + g.teamTwo + ': ' + scoreTwo
      );
    }

    // Process Scoreboard
    Scoreboard scoreboard = new Scoreboard(games);
    System.debug(' ');
    System.debug('---- Standings ----');
    scoreboard.printScoreboard();
  }

  public class Game {
    public String teamOne;
    public String teamTwo;
    public Date playedDate;
    public Integer teamOneScore;
    public Integer teamTwoScore;
    private String winnerName;

    // Constructor, takes the name of two teams
    public Game(String teamOne, String teamTwo) {
      this.teamOne = teamOne;
      this.teamTwo = teamTwo;
      this.playedDate = Date.today();
    }

    public String whoWins() {
      return this.winnerName != null ? this.winnerName : 'Not Yet Played';
    }

    // Record The score of the game and return the winner
    public String recordScores(Integer teamOneScore, Integer teamTwoScore) {
      this.teamOneScore = teamOneScore;
      this.teamTwoScore = teamTwoScore;
      if (teamOneScore == teamTwoScore) {
        this.winnerName = 'Tied';
      } else if (teamOneScore > teamTwoScore) {
        this.winnerName = this.teamOne;
      } else {
        this.winnerName = this.teamTwo;
      }
      return teamTwo;
    }
  }

  public class Scoreboard {
    Map<String, TeamRecord> records;

    public Scoreboard(List<Game> games) {
      this.records = new Map<String, TeamRecord>();
      this.processGames(games);
    }

    public void printScoreboard() {
      System.debug('Team Name  \\ Wins \\ Losses \\ Ties');
      for (TeamRecord tr : records.values()) {
        System.debug(tr.printLine());
      }
    }

    private void processGames(List<Game> games) {
      for (Game g : games) {
        // Add teams to map
        if (!this.records.containsKey(g.teamOne))
          this.records.put(g.teamOne, new TeamRecord(g.teamOne));
        if (!this.records.containsKey(g.teamTwo))
          this.records.put(g.teamTwo, new TeamRecord(g.teamTwo));

        // Get from Map and add game score
        this.records.get(g.teamOne).addGameResult(g);
        this.records.get(g.teamTwo).addGameResult(g);
      }
    }
  }

  public class TeamRecord {
    public String teamName;
    public Integer wins;
    public Integer losses;
    public Integer ties;

    public TeamRecord(String teamName) {
      this.teamName = teamName;
      this.wins = 0;
      this.losses = 0;
      this.ties = 0;
    }

    public void addGameResult(Game game) {
      if (game.winnerName == this.teamName) {
        this.wins++;
      } else if (game.winnerName == 'Tied') {
        this.ties++;
      } else {
        this.losses++;
      }
    }

    public String printLine() {
      // Team Name    | Wins | Losses | Ties
      return this.teamName.rightPad(10) +
        ' \\ ' +
        String.valueOf(this.wins).leftPad(4) +
        +' \\ ' +
        String.valueOf(this.losses).leftPad(6) +
        ' \\ ' +
        String.valueOf(this.ties).leftPad(4);
    }
  }
}
