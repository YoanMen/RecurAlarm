const kDefaultPadding = 16.0;

enum ReminderType {
  daily,
  weekly,
  monthly,
}

enum SelectedDay {
  nothing,
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
}

// converts the index to a number of weeks between recalls
const Map<int, int> weeklDayCount = {
  0: 7,
  1: 14,
  2: 21,
};

// converts the index to a number of months between recalls
const Map<int, int> monthDayCount = {
  0: 1,
  1: 3,
  2: 6,
  3: 12,
};

// convert the whenInMonth index to a specific day of the month
const Map<int, int> whenInMonth = {
  0: 7,
  1: 21,
  2: 28,
};
