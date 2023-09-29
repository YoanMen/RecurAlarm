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

const Map<int, int> weeklDayCount = {
  0: 7,
  1: 14,
  2: 21,
};

const Map<int, int> monthDayCount = {
  0: 1,
  1: 3,
  2: 6,
  3: 12,
};

const Map<int, int> whenInMonth = {
  0: 7,
  1: 21,
  2: 28,
};
