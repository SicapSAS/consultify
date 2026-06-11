class AppointmentFilter {
  static const _monthNames = [
    'enero',
    'febrero',
    'marzo',
    'abril',
    'mayo',
    'junio',
    'julio',
    'agosto',
    'septiembre',
    'octubre',
    'noviembre',
    'diciembre',
  ];

  final int year;
  final DateTime? selectedDate;

  AppointmentFilter({
    required this.year,
    this.selectedDate,
  });

  factory AppointmentFilter.initial() {
    final now = DateTime.now();
    return AppointmentFilter(
      year: now.year,
      selectedDate: DateTime(now.year, now.month, now.day),
    );
  }

  AppointmentFilter copyWith({
    int? year,
    DateTime? selectedDate,
    bool clearSelectedDate = false,
  }) {
    return AppointmentFilter(
      year: year ?? this.year,
      selectedDate: clearSelectedDate ? null : (selectedDate ?? this.selectedDate),
    );
  }

  int? get selectedDay => selectedDate?.day;
  int? get selectedMonth => selectedDate?.month;

  String get apiDateValue {
    if (selectedDate != null) {
      return _formatIsoDate(selectedDate!);
    }
    return year.toString();
  }

  String get emptyMessage {
    if (selectedDate != null) {
      final date = selectedDate!;
      final day = date.day.toString().padLeft(2, '0');
      final month = _monthNames[date.month - 1];
      return 'No hay citas para el $day de $month de ${date.year}';
    }

    return 'No hay citas para el año $year';
  }

  String _formatIsoDate(DateTime date) {
    final y = date.year.toString().padLeft(4, '0');
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  Map<String, dynamic> toJson() {
    return {
      'date': apiDateValue,
    };
  }
}
