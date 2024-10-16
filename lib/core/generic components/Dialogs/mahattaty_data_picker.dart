import 'package:flutter/material.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_dialog.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MahattatyDataPicker extends StatefulWidget {
  const MahattatyDataPicker({super.key, required this.onDateSelected});

  final Function(DateTime args) onDateSelected;

  @override
  State<MahattatyDataPicker> createState() => _MahattatyDataPickerState();
}

class _MahattatyDataPickerState extends State<MahattatyDataPicker> {
  DateRangePickerSelectionChangedArgs args =
      DateRangePickerSelectionChangedArgs(DateTime.now());

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      this.args = args;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MahattatyDialog(
      title: AppLocalizations.of(context)!.selectDate,
      description: AppLocalizations.of(context)!.selectDateDescription,
      content: [
        SfDateRangePicker(
          view: DateRangePickerView.year,
          selectionMode: DateRangePickerSelectionMode.single,
          showNavigationArrow: false,
          allowViewNavigation: false,
          headerStyle: DateRangePickerHeaderStyle(
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20,
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          todayHighlightColor: Theme.of(context).colorScheme.primary,
          enablePastDates: false,
          onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
            if (args.value != null) {
              final DateTime selectedDate = args.value;
              final int selectedMonth = selectedDate.month;
              final int selectedYear = selectedDate.year;
              final int selectedDay = selectedDate.month == DateTime.now().month
                  ? DateTime.now().day
                  : 1;
              widget.onDateSelected(
                  DateTime(selectedYear, selectedMonth, selectedDay));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
      buttonText: AppLocalizations.of(context)!.selectButton,
      onButtonPressed: () {
        widget.onDateSelected(args.value);
        Navigator.of(context).pop();
      },
    );
  }
}
