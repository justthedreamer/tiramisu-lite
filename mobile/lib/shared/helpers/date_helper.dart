class DateHelper {
  static String getDateWithoutTime(DateTime date) {
    return '${date.day}-${date.month}-${date.year}';
  }

  static String getTimeWithoutDate(DateTime date) {
    return '${date.hour}:${date.minute}';
  }
}
