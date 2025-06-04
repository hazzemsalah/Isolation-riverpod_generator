class DateFormatter {
  static String formatDateTime(String timestampString) {
    try {
      final dateTime = DateTime.parse(timestampString);
      return '${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')} '
             '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return timestampString;
    }
  }

  static String formatDateTimeDetailed(String timestampString) {
    try {
      final dateTime = DateTime.parse(timestampString);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inDays == 0) {
        return 'Today ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      } else if (difference.inDays == 1) {
        return 'Yesterday ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else {
        return formatDateTime(timestampString);
      }
    } catch (e) {
      return timestampString;
    }
  }

  static DateTime? parseDateTime(String timestampString) {
    try {
      return DateTime.parse(timestampString);
    } catch (e) {
      return null;
    }
  }
}