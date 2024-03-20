import 'package:intl/intl.dart';
numberFormat(int inputNumber) {
  var formattedNumber = NumberFormat.compactCurrency(
    decimalDigits: 2,
    symbol: '',
  ).format(inputNumber);

  // log('Formatted Number is: $formattedNumber');
  return formattedNumber;
}


String dateTimeFormat(String inputDate) {
  DateTime dateTime = DateTime.parse(inputDate);
  String formattedDate = DateFormat('dd/MM/yyyy hh:mm a').format(dateTime);
  // log(formattedDate.toString());
  return formattedDate;
}