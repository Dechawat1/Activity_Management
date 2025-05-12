import 'package:intl/intl.dart';

class Utility
{
  static String getHumanReadableDate( int dt )
  {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(dt);

    return DateFormat('EEE,dd MMM yyyy hh:mm a').format(dateTime);
  }
}