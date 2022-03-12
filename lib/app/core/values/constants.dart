import 'package:flutter/material.dart';

const is24hours = {
  "AM": false,
  "PM": true,
};

const monthName = {
  "Jan": "01",
  "Feb": "02",
  "Mar": "03",
  "Apr": "04",
  "May": "05",
  "Jun": "06",
  "Jul": "07",
  "Aug": "08",
  "Sep": "09",
  "Oct": "10",
  "Nov": "11",
  "Dec": "12",
};

List dateFormatList = ["Year", "Month", "Date", "Hour", "Minute", "Seconds"];

List heightUnits = ["cm", "meter", "feet + inches"];
List weightUnits = ["kg", "lbs"];

Color fC = Colors.teal;
Color mC = Colors.grey.shade100;
Color mCL = Colors.white;
Color mCD = Colors.black.withOpacity(0.075);
Color mCC = Colors.green.withOpacity(0.65);
Color fCL = Colors.grey.shade600;

BoxDecoration nMbox =
    BoxDecoration(shape: BoxShape.circle, color: mC, boxShadow: [
  BoxShadow(
    color: mCD,
    offset: Offset(10, 10),
    blurRadius: 10,
  ),
  BoxShadow(
    color: mCL,
    offset: Offset(-10, -10),
    blurRadius: 10,
  ),
]);

BoxDecoration nMboxInvert = BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: mCD,
    boxShadow: [
      BoxShadow(
          color: mCL, offset: Offset(3, 3), blurRadius: 3, spreadRadius: -3),
    ]);
