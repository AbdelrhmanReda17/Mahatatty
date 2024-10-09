import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/search_train_controller.dart';
import 'cards/date_card.dart';

class DateList extends ConsumerStatefulWidget {
  late final int daysInMonth;
  final DateTime startDate;

  DateList({super.key, required this.startDate})
      : daysInMonth = DateTime(startDate.year, startDate.month + 1, 0).day;

  @override
  DateListState createState() => DateListState();
}

class DateListState extends ConsumerState<DateList> {
  int? selectedIndex;
  final List<String> weekdays = [
    "Sun",
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat"
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.startDate.day - 1;
  }

  void selectDate(int index) {
    ref.read(trainSearchProvider.notifier).state = ref
        .read(trainSearchProvider)
        .copyWith(
            departureDate: Timestamp.fromDate(DateTime(
                widget.startDate.year, widget.startDate.month, index + 1)));
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> _buildDateList() {
    bool isSameMonth = widget.startDate.month == DateTime.now().month;
    List<Widget> dateWidgets = [];
    for (int i = 0; i < widget.daysInMonth; i++) {
      dateWidgets.add(DateCard(
        isEnabled: isSameMonth ? i >= DateTime.now().day - 2 : true,
        day: weekdays[i % 7],
        date: (i + 1).toString(),
        isSelected: selectedIndex == i,
        onSelect: () => selectDate(i),
      ));
      dateWidgets.add(const SizedBox(width: 10));
    }
    return dateWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView(
          controller: ScrollController(
              initialScrollOffset: selectedIndex! * 51.0 - 100.0),
          scrollDirection: Axis.horizontal,
          children: _buildDateList()),
    );
  }
}
