/// Festivos oficiales de Colombia (Ley Emiliani + fechas fijas y móviles).
class ColombiaHolidays {
  ColombiaHolidays._();

  static final _cache = <int, Set<String>>{};

  static bool isHoliday(DateTime date) {
    return forYear(date.year).contains(_key(date));
  }

  static bool isSunday(DateTime date) => date.weekday == DateTime.sunday;

  static bool isNonWorkingDay(DateTime date) {
    return isSunday(date) || isHoliday(date);
  }

  static Set<String> forYear(int year) {
    return _cache.putIfAbsent(year, () => _calculate(year));
  }

  static String _key(DateTime date) => '${date.year}-${date.month}-${date.day}';

  static Set<String> _calculate(int year) {
    final holidays = <String>{};
    final easter = _easterSunday(year);

    void add(DateTime date) => holidays.add(_key(date));
    void addFixed(int month, int day) => add(DateTime(year, month, day));
    void addEmiliani(int month, int day) {
      add(_emilianiMonday(DateTime(year, month, day)));
    }

    addFixed(1, 1);
    addEmiliani(1, 6);
    addEmiliani(3, 19);
    addFixed(5, 1);
    addEmiliani(6, 29);
    addFixed(7, 20);
    addFixed(8, 7);
    addEmiliani(8, 15);
    addEmiliani(10, 12);
    addEmiliani(11, 1);
    addEmiliani(11, 11);
    addFixed(12, 8);
    addFixed(12, 25);

    add(easter.subtract(const Duration(days: 3)));
    add(easter.subtract(const Duration(days: 2)));
    add(_emilianiMonday(easter.add(const Duration(days: 39))));
    add(_emilianiMonday(easter.add(const Duration(days: 60))));
    add(_emilianiMonday(easter.add(const Duration(days: 68))));

    return holidays;
  }

  static DateTime _emilianiMonday(DateTime date) {
    if (date.weekday == DateTime.monday) return date;
    final daysToAdd = (DateTime.monday - date.weekday + 7) % 7;
    return date.add(Duration(days: daysToAdd));
  }

  static DateTime _easterSunday(int year) {
    final a = year % 19;
    final b = year ~/ 100;
    final c = year % 100;
    final d = b ~/ 4;
    final e = b % 4;
    final f = (b + 8) ~/ 25;
    final g = (b - f + 1) ~/ 3;
    final h = (19 * a + b - d - g + 15) % 30;
    final i = c ~/ 4;
    final k = c % 4;
    final l = (32 + 2 * e + 2 * i - h - k) % 7;
    final m = (a + 11 * h + 22 * l) ~/ 451;
    final month = (h + l - 7 * m + 114) ~/ 31;
    final day = ((h + l - 7 * m + 114) % 31) + 1;
    return DateTime(year, month, day);
  }
}
