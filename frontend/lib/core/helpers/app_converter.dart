import 'package:easy_localization/easy_localization.dart';

class AppConverter {
  const AppConverter._();

  static String utcToLocalDateText(DateTime date) {
    final format = DateFormat('dd/MM/yyyy-h:mma');
    final strToToDateTime = DateTime.parse(date.toUtc().toString());
    final convertToLocal = strToToDateTime.toLocal();
    return format.format(convertToLocal);
  }

  //TODO: convet iso to date time
  static DateTime isoToDateTime(String date) {
    try {
      return DateTime.parse(date);
    } on Exception catch (_) {
      return DateTime.now();
    }
  }

  static String isoToDateTimeText(String? date) {
    try {
      if (date == null) {
        return '';
      }
      final dateTime = isoToDateTime(date);
      return utcToLocalDateText(dateTime);
    } catch (_) {
      return '';
    }
  }
}
