import 'package:intl/intl.dart';

class DateUtilsCustom {
  static String formatDate(String isoDate) {
    final dateTime = DateTime.parse(isoDate).toLocal();
    final formatter = DateFormat('yyyy MMM dd, hh:mm a');
    return formatter.format(dateTime);
  }
}
