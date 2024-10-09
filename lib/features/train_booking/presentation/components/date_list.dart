import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cards/date_card.dart';



class DateList extends ConsumerStatefulWidget {
  const DateList({
    super.key,
    required this.startDate
  });

  final DateTime startDate;

  @override
  DateListState createState() => DateListState();
}

class DateListState extends ConsumerState<DateList>{
  int? selectedIndex;
  final List<String> weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

  void selectDate(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> _buildDateList(){
    List<Widget> dateWidgets = [];
    for (int i = 0; i < 7; i++){
      DateTime date = widget.startDate.add(Duration(days: i));
      dateWidgets.add(
          DateCard(
              day: weekdays[date.weekday % 7 ],
              date: date.day.toString(),
              isSelected: selectedIndex == i,
              onSelect: () => selectDate(i),
          )
      );
      dateWidgets.add(const SizedBox(width: 10));
    }
    return dateWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: _buildDateList()
      ),
    );
  }
}





