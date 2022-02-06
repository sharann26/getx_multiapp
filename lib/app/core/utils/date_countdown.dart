import 'dart:async';
import 'package:flutter/material.dart';

class CountDownText extends StatefulWidget {
  CountDownText(
      {Key? key,
      required this.due,
      required this.finishedText,
      this.dateFormats = '[]',
      this.longDateName = false,
      this.style,
      this.showLabel = false})
      : super(key: key);

  final DateTime? due;
  final String? finishedText;
  final String? dateFormats;
  final bool? longDateName;
  final bool? showLabel;
  final TextStyle? style;

  @override
  _CountDownTextState createState() => _CountDownTextState();
}

class _CountDownTextState extends State<CountDownText> {
  Timer? timer;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      CountDown().timeLeft(widget.due!, widget.finishedText!,
          longDateName: widget.longDateName,
          showLabel: widget.showLabel,
          dateFormats: widget.dateFormats),
      style: widget.style,
    );
  }
}

class CountDown {
  String timeLeft(DateTime due, String finishedText,
      {bool? longDateName, bool? showLabel, String? dateFormats}) {
    String retVal;

    Duration _timeUntilDue = due.difference(DateTime.now());

    int _daysUntil = 0;
    int _hoursUntil = 0;
    int _minUntil = 0;
    int _secUntil = 0;
    // String s = _secUntil.toString().substring(_secUntil.toString().length - 2);
    // //Fixed Invalid Range Value
    String s = _secUntil.toString().length <= 2
        ? _secUntil.toString()
        : _secUntil.toString().substring(_secUntil.toString().length - 2);

    _daysUntil = _timeUntilDue.inDays;
    _hoursUntil = _timeUntilDue.inHours - (_daysUntil * 24);
    _minUntil =
        _timeUntilDue.inMinutes - (_daysUntil * 24 * 60) - (_hoursUntil * 60);
    _secUntil = _timeUntilDue.inSeconds - (_minUntil * 60);
    s = _secUntil.toString().length <= 2
        ? _secUntil.toString()
        : _secUntil.toString().substring(_secUntil.toString().length - 2);
        
    /* String dateFormat = dateFormats ?? "";
    if (dateFormat.indexOf('Year') > -1 ||
        dateFormat.indexOf('Month') > -1 ||
        dateFormat.indexOf('Date') > -1) {
          
    } else if (dateFormat.indexOf('Hour') > -1) {
      
    } else if (dateFormat.indexOf('Mintue') > -1) {
      
    } else {

    } */
    if (_daysUntil > 0) {
      //Check whether to return longDateName date name or not
      if (showLabel == false) {
        retVal = _daysUntil.toString() +
            " : " +
            _hoursUntil.toString() +
            " : " +
            _minUntil.toString() +
            " : " +
            s.toString();
      } else {
        if (longDateName == false) {
          retVal = _daysUntil.toString() +
              " d " +
              _hoursUntil.toString() +
              " h " +
              _minUntil.toString() +
              " m " +
              s.toString() +
              " s ";
        } else {
          retVal = _daysUntil.toString() +
              " days " +
              _hoursUntil.toString() +
              " hours " +
              _minUntil.toString() +
              " minutes " +
              s.toString() +
              " seconds ";
        }
      }
    } else if (_hoursUntil > 0) {
      if (showLabel == false) {
        retVal = _hoursUntil.toString() +
            " : " +
            _minUntil.toString() +
            " : " +
            s.toString();
      } else {
        if (longDateName == false) {
          retVal = _hoursUntil.toString() +
              " h " +
              _minUntil.toString() +
              " m " +
              s.toString() +
              " s ";
        } else {
          retVal = _hoursUntil.toString() +
              " hours " +
              _minUntil.toString() +
              " minutes " +
              s.toString() +
              " seconds ";
        }
      }
    } else if (_minUntil > 0) {
      if (showLabel == false) {
        retVal = _minUntil.toString() + " : " + s.toString();
      } else {
        if (longDateName == false) {
          retVal = _minUntil.toString() + " m " + s.toString() + " s ";
        } else {
          retVal =
              _minUntil.toString() + " minutes " + s.toString() + " seconds ";
        }
      }
    } else if (_secUntil > 0) {
      if (showLabel == false) {
        retVal = s.toString();
      } else {
        if (longDateName == false) {
          retVal = s.toString() + " s ";
        } else {
          retVal = s.toString() + " seconds ";
        }
      }
    } else {
      retVal = finishedText;
    }
    return retVal;
  }
}
