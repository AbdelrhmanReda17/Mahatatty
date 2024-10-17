import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mahattaty/core/utils/app_localizations_extension.dart';
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
  late final List<String> weekdays = [
    AppLocalizations.of(context)!.sun,
    AppLocalizations.of(context)!.mon,
    AppLocalizations.of(context)!.tue,
    AppLocalizations.of(context)!.wed,
    AppLocalizations.of(context)!.thu,
    AppLocalizations.of(context)!.fri,
    AppLocalizations.of(context)!.sat,
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.startDate.day - 1;
  }

  void selectDate(int index) {
    DateTime x = DateTime.now();
    ref.read(trainSearchProvider.notifier).state =
        ref.read(trainSearchProvider).copyWith(
              departureDate: Timestamp.fromDate(
                DateTime(
                  x.year,
                  x.month,
                  index + 1,
                  x.day == index + 1 ? x.hour : 0,
                  x.day == index + 1 ? x.minute : 0,
                ),
              ),
            );
    setState(() {
      selectedIndex = index;
    });
  }

  List<Widget> _buildDateList() {
    bool isSameMonth = widget.startDate.month == DateTime.now().month;
    List<Widget> dateWidgets = [];
    for (int i = 0; i < widget.daysInMonth; i++) {
      dateWidgets.add(DateCard(
        isEnabled: isSameMonth ? i >= DateTime.now().day - 1 : true,
        day: weekdays[i % 7],
        date: AppLocalizations.of(context)!.arabicOrEnglish(i + 1),
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
              initialScrollOffset: selectedIndex! * 58),
          scrollDirection: Axis.horizontal,
          children: _buildDateList()),
    );
  }
}
