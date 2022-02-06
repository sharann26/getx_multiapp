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

List dateFormatList = ["Year", "Month", "Date", "Hour", "Mintue", "Seconds"];

const APPS_LIST = [
  {
    "name": "WhatsApp",
    "imagePath": "assets/images/whatsapp.png",
    "desc": "Chat with unsaved number from WhatsApp",
  },
  {
    "name": "Weight Tracker",
    "imagePath": "assets/images/weight_tracker.png",
    "desc": "To motivate for weight gainer and maintain the weight",
  },
  {
    "name": "Todo",
    "imagePath": "assets/images/todo.png",
    "desc": "Used to maintain our day-to-day tasks that we have to do",
  },
];

const FOOD_DATA = [
  {"name": "Burger", "icon": Icons.add, "color": Colors.blue},
  {"name": "Cheese Dip", "icon": Icons.close, "color": Colors.green},
  {"name": "Cola", "icon": Icons.person, "color": Colors.yellow},
  {"name": "Fries", "icon": Icons.language, "color": Colors.purple},
  {"name": "Ice Cream", "icon": Icons.notifications, "color": Colors.grey},
  {"name": "Noodles", "icon": Icons.no_sim, "color": Colors.indigo},
  {"name": "Pizza", "icon": Icons.sailing, "color": Colors.red},
  {"name": "Sandwich", "icon": Icons.sanitizer, "color": Colors.pink},
  {"name": "Wrap", "icon": Icons.save, "color": Colors.brown}
];

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
