import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  final datePicker = '';
  double _height = 0.0;
  double _width = 0.0;
  String _setTime = '', _setDate = '';
  String _hour = '', _minute = '', _time = '';
  String dateTime = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2091));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMMMd('en_US').format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        print(selectedDate);
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    _dateController.text = DateFormat.yMMMd('en_US').format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    dateTime = DateFormat.yMMMd('en_US').format(DateTime.now());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        InkWell(
          onTap: () {
            _selectDate(context);
          },
          child: Container(
            width: 120,
            height: 50,
            // margin: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            // decoration: BoxDecoration(color: Colors.grey[200]),
            child: TextFormField(
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
              enabled: false,
              // keyboardType: TextInputType.text,
              controller: _dateController,
              // onSaved: (val) {
              //   _setDate = val.toString();
              // },
              // decoration: InputDecoration(
              //     disabledBorder:
              //         UnderlineInputBorder(borderSide: BorderSide.none),
              //     // labelText: 'Time',
              //     contentPadding: EdgeInsets.only(top: 0.0)),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            _selectTime(context);
          },
          child: Container(
            // margin: EdgeInsets.only(top: 30),
            width: 120,
            height: 50,
            alignment: Alignment.center,
            // decoration: BoxDecoration(color: Colors.grey[200]),
            child: TextFormField(
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
              // onSaved: (val) {
              //   _setTime = val.toString();
              // },
              enabled: false,
              keyboardType: TextInputType.text,
              controller: _timeController,
              // decoration: InputDecoration(
              //   disabledBorder:
              //       UnderlineInputBorder(borderSide: BorderSide.none),
              //   // labelText: 'Time',
              //   contentPadding: EdgeInsets.all(5),
              // ),
            ),
          ),
        ),
      ],
    );
  }
}
