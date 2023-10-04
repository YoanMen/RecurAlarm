const kDefaultPadding = 16.0;

enum ReminderType {
  daily,
  weekly,
  monthly,
}

enum SelectedWhenInMonth {
  begin,
  middle,
  end,
}

// converts the index to a number of day between recalls
const Map<int, int> weeklDayCount = {
  0: 7,
  1: 14,
  2: 21,
};

// converts the index to a number of months between recalls
const Map<int, int> monthCount = {
  0: 1,
  1: 3,
  2: 6,
  3: 12,
};

// convert  to a specific day of the month
const Map<String, int> whenInMonth = {
  "begin": 1,
  "middle": 11,
  "end": 22,
};
