/// A utility class for formatting dates in the application.
/// Converts date strings to user-friendly formats.
class DateFormatter {
  /// List of month abbreviations
  static const List<String> _monthAbbreviations = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  /// Formats a date string from YYYY-MM-DD to DD-MMM-YYYY
  /// Example: "2026-02-07" -> "07-Feb-2026"
  ///
  /// Returns the original string if parsing fails or input is invalid.
  static String formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty || dateStr == "Date") {
      return "";
    }

    try {
      final parts = dateStr.split('-');
      if (parts.length == 3) {
        final year = parts[0];
        final monthIndex = int.parse(parts[1]) - 1;
        final day = parts[2].padLeft(2, '0');

        if (monthIndex >= 0 && monthIndex < 12) {
          final month = _monthAbbreviations[monthIndex];
          return "$day-$month-$year";
        }
      }
    } catch (_) {
      // Return original string if parsing fails
    }

    return dateStr;
  }

  /// Formats a time string (keeps HH:MM format)
  /// Example: "15:30" -> "15:30"
  static String formatTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty || timeStr == "Time") {
      return "";
    }
    return timeStr;
  }

  /// Formats date and time together
  /// Example: "2026-02-07", "15:30" -> "07-Feb-2026 15:30"
  static String formatDateTime(String? dateStr, String? timeStr) {
    final formattedDate = formatDate(dateStr);
    final formattedTime = formatTime(timeStr);

    if (formattedDate.isEmpty && formattedTime.isEmpty) {
      return "";
    }
    if (formattedDate.isEmpty) return formattedTime;
    if (formattedTime.isEmpty) return formattedDate;

    return "$formattedDate $formattedTime";
  }
}
