import 'package:intl/intl.dart';

class Formatters {
  static String formatDate(DateTime date) {
    final formatted = DateFormat("yyyy-MM-dd").format(date);
    return "${formatted}T00:00:00Z";
  }

  static String formatCurrency(double amount) {
    final formatter = NumberFormat.currency(locale: 'en_US', symbol: '\$');
    return formatter.format(amount);
  }
}
