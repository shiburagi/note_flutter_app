import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String get toUserDateTime => DateFormat("d MMM hh:mm a").format(this);
  String get toUserDate => DateFormat("d MMM").format(this);
}

extension intExt on int {
  String get toUserDateTime =>
      DateTime.fromMillisecondsSinceEpoch(this).toUserDateTime;
  String get toUserDate => DateTime.fromMillisecondsSinceEpoch(this).toUserDate;
}
