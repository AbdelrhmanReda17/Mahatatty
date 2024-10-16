import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mahattaty/features/train_booking/domain/entities/ticket.dart';
import 'package:mahattaty/features/train_booking/domain/entities/train_seat.dart';

import '../../features/train_booking/domain/entities/train.dart';

class ArabicNumbers {
  String convert(number) {
    if (number is int) {
      String replace1 = number.toString().replaceAll('0', '٠');
      String replace2 = replace1.replaceAll('1', '١');
      String replace3 = replace2.replaceAll('2', '٢');
      String replace4 = replace3.replaceAll('3', '٣');
      String replace5 = replace4.replaceAll('4', '٤');
      String replace6 = replace5.replaceAll('5', '٥');
      String replace7 = replace6.replaceAll('6', '٦');
      String replace8 = replace7.replaceAll('7', '٧');
      String replace9 = replace8.replaceAll('8', '٨');
      String replace10 = replace9.replaceAll('9', '٩');
      return replace10;
    } else {
      String replace0 = number.toString().replaceAll(',', '.');
      String replace1 = replace0.replaceAll('0', '٠');
      String replace2 = replace1.replaceAll('1', '١');
      String replace3 = replace2.replaceAll('2', '٢');
      String replace4 = replace3.replaceAll('3', '٣');
      String replace5 = replace4.replaceAll('4', '٤');
      String replace6 = replace5.replaceAll('5', '٥');
      String replace7 = replace6.replaceAll('6', '٦');
      String replace8 = replace7.replaceAll('7', '٧');
      String replace9 = replace8.replaceAll('8', '٨');
      String replace10 = replace9.replaceAll('9', '٩');
      return replace10;
    }
  }
}

extension AppLocalizationsExtension on AppLocalizations {
  String station(String code) {
    String lowerCaseCode = code.toLowerCase();
    switch (lowerCaseCode) {
      case 'cai':
        return cai;
      case 'alx':
        return alx;
      case 'asw':
        return asw;
      case 'lxr':
        return lxr;
      case 'atz':
        return atz;
      case 'bfs':
        return bfs;
      case 'dtt':
        return dtt;
      case 'fym':
        return fym;
      case 'gby':
        return gby;
      case 'giz':
        return giz;
      case 'ism':
        return ism;
      case 'kfs':
        return kfs;
      case 'mtw':
        return mtw;
      case 'myn':
        return myn;
      case 'mnf':
        return mnf;
      case 'wad':
        return wad;
      case 'sin':
        return sin;
      case 'psd':
        return psd;
      case 'qal':
        return qal;
      case 'qna':
        return qna;
      case 'bav':
        return bav;
      case 'shr':
        return shr;
      case 'swj':
        return swj;
      case 'ssh':
        return ssh;
      case 'suz':
        return suz;
      case 'dka':
        return dka;
      case 'bah':
        return bah;
      default:
        return "Unknown Station";
    }
  }
  String ticket(TicketType ticket) {
    switch (ticket) {
      case TicketType.roundTrip:
        return roundTrip;
      case TicketType.oneWay:
        return oneWay;
      default:
        return "Unknown Ticket Type";
    }
  }
  String seat(SeatType seat) {
    switch (seat) {
      case SeatType.firstClass:
        return firstClass;
      case SeatType.economic:
        return economicClass;
      case SeatType.business:
        return businessClass;
      default:
        return "Unknown Seat Type";
    }
  }
  String train(TrainType type){
    switch (type) {
      case TrainType.express:
        return express;
      case TrainType.touristic:
        return touristic;
      case TrainType.ordinary:
        return ordinary;
      default:
        return "Unknown Train Type";
    }
  }


  String arabicOrEnglish(dynamic text){
    ArabicNumbers arabic = ArabicNumbers();
    return language == 'العربية' ? arabic.convert(text) : text.toString();
  }

}
