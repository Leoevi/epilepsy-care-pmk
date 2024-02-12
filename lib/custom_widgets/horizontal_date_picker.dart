import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';

class HorizontalDatePicker extends StatefulWidget {
  const HorizontalDatePicker({
    super.key,
    required this.startDate,
    this.onDateChange,
  });

  final DateTime startDate;

  final void Function(DateTime)? onDateChange;


  @override
  State<HorizontalDatePicker> createState() => _HorizontalDatePickerState();
}

class _HorizontalDatePickerState extends State<HorizontalDatePicker> {
  final DatePickerController _controller = DatePickerController();  // To use "jumpToSelection" method

  // Need to wait for the DatePicker to be built first so that jumpToSelection can be called
  // otherwise 'DatePickerController is not attached to any DatePicker View.'
  // https://stackoverflow.com/questions/49466556/flutter-run-method-on-widget-build-complete
  // TODO: However, the makes the push navigation lag a bit, so another way would be appreciated
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _controller.jumpToSelection());
  }

  @override
  Widget build(BuildContext context) {
    return DatePicker(
      //TODO: Make Selected show on center
      DateTime.now().subtract(Duration(days: 250)),
      height: 90,
      controller: _controller,
      initialSelectedDate: widget.startDate,
      selectionColor: Color.fromARGB(255, 201, 128, 247),
      selectedTextColor: Colors.white,
      locale: "th_TH",
      onDateChange: widget.onDateChange,
    );
  }
}
