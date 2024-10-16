import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class TimeConverter {
  static String convertTimeToString(Timestamp time) {
    DateTime dateTime = time.toDate();
    DateTime now = DateTime.now();
    int diff = now.difference(dateTime).inSeconds;

    if (diff < 60) {
      return 'Just now';
    } else if (diff < 3600) {
      return '${(diff / 60).floor()}m ago';
    } else if (diff < 86400) {
      return '${(diff / 3600).floor()}h ago';
    } else if (diff < 604800) {
      return '${(diff / 86400).floor()}d ago';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  static String convertTimeToDate(Timestamp time,
      {bool isNumber = false, bool isDay = false}) {
    DateTime dateTime = time.toDate();
    if (isNumber) {
      if (isDay) {
        return '${dateTime.month}/${dateTime.year}';
      }
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    } else {
      if (isDay) {
        return '${_changeMonthNumberToText(dateTime.month)} ${dateTime.year}';
      }
      return '${dateTime.day} ${_changeMonthNumberToText(dateTime.month)} ${dateTime.year}';
    }
  }

  static String convertTimeToTime(Timestamp time) {
    DateTime dateTime = time.toDate();
    return '${dateTime.hour}:${dateTime.minute}';
  }

  static String _changeMonthNumberToText(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'Unknown';
    }
  }

  static Duration convertTimeToDuration(Timestamp time) {
    DateTime dateTime = time.toDate();
    return DateTime.now().difference(dateTime);
  }
}
