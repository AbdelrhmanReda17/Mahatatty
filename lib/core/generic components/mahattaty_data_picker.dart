import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mahattaty/core/generic%20components/mahattaty_dialog.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class MahattatyDataPicker extends StatefulWidget {
  const MahattatyDataPicker({super.key});

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
      title: 'Select Date',
      description: 'Select the date you want to travel',
      content: [
        SfDateRangePicker(
          headerStyle: DateRangePickerHeaderStyle(
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: 20,
            ),
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          enableMultiView: false,
          backgroundColor: Theme.of(context).colorScheme.surface,
          todayHighlightColor: Theme.of(context).colorScheme.primary,
          enablePastDates: false,
          showNavigationArrow: false,
          navigationMode: DateRangePickerNavigationMode.snap,
          showActionButtons: false,
          onSelectionChanged: _onSelectionChanged,
          selectionMode: DateRangePickerSelectionMode.extendableRange,
        ),
      ],
      buttonText: 'Select',
      onButtonPressed: () {
        log('Selected Date: ${args.value}');
        Navigator.of(context).pop();
      },
    );
  }
}
