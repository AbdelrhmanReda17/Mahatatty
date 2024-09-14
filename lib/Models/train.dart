import 'package:mahattaty/Utils/constant.dart';

enum TrainType { express, regular, fast, slow }

class Train {
  final String id;
  final String name;
  final TrainType type;
  final String from;
  final String to;
  final String departure;
  final String arrival;
  final String duration;
  final String price;

  Train({
    required this.name,
    required this.type,
    required this.from,
    required this.to,
    required this.departure,
    required this.arrival,
    required this.duration,
    required this.price,
  }) : id = uuid.v6();
}
