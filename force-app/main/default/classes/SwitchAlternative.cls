public with sharing class SwitchAlternative {
  public void evaluateWeekdaySwitch(String day) {
    switch on day {
      when 'Monday' {
        System.debug('Start of the work week');
      }
      when 'Tuesday', 'Wednesday', 'Thursday' {
        System.debug('Middle of the work week');
      }
      when 'Friday' {
        System.debug('End of the work week');
      }
      when 'Saturday', 'Sunday' {
        System.debug('Weekend');
      }
      when else {
        System.debug('Invalid day');
      }
    }
  }

  public void evaluateWeekdayMap(String day) {
    Map<String, Integer> dayMap = new Map<String, Integer>{
      'Monday' => 0,
      'Tuesday' => 1,
      'Wednesday' => 1,
      'Thursday' => 1,
      'Friday' => 2,
      'Staturday' => 3,
      'Sunday' => 3
    };

    List<String> messages = new List<String>{
      'Start of the work week',
      'Middle of the work week',
      'End of the work week',
      'Weekend'
    };

    System.debug(
      dayMap.containsKey(day) ? messages.get(dayMap.get(day)) : 'Invalid day'
    );
  }

  
}


