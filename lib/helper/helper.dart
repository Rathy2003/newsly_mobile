import 'package:intl/intl.dart';

class Helper{
  static displayKmDate(String date){
    DateTime dateTime = DateTime.parse(date);
    final fomatted = DateFormat('EEE, dd-MM-yyyy', 'km').format(dateTime);
    return fomatted;
  }
}