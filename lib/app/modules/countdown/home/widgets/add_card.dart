import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_app/app/data/models/todo.dart';
import 'package:multi_app/app/modules/countdown/home/controller.dart';
import 'package:get/get.dart';
import 'package:multi_app/app/widget/icons.dart';
import 'package:multi_app/app/core/values/colors.dart';
import 'package:multi_app/app/core/utils/extensions.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class CountdownAddCard extends StatefulWidget {
  @override
  _CountdownAddCardState createState() => _CountdownAddCardState();
}

class _CountdownAddCardState extends State<CountdownAddCard> {
  final homeCtrl = Get.find<CountdownHomeController>();
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
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: 'Task Type',
            content: Form(
              key: homeCtrl.formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: homeCtrl.editingCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your task title';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0.wp),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            _selectDate(context);
                          },
                          child: Container(
                            width: 10,
                            height: 10,
                            alignment: Alignment.center,
                            child: TextFormField(
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                              enabled: false,
                              controller: _dateController,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _selectTime(context);
                          },
                          child: Container(
                            width: 120,
                            height: 50,
                            alignment: Alignment.center,
                            child: TextFormField(
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _timeController,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      minimumSize: const Size(150, 40),
                    ),
                    onPressed: () {
                      if (homeCtrl.formKey.currentState!.validate()) {
                        String time =
                            _dateController.text + " " + _timeController.text;
                        String color =
                            icons[homeCtrl.chipIndex.value].color!.toHex();
                        var task = Todo(
                          title: homeCtrl.editingCtrl.text,
                          time: time,
                          color: color,
                        );
                        Get.back();
                        homeCtrl.addTask(task)
                            ? EasyLoading.showSuccess("Task created")
                            : EasyLoading.showError("Task is duplicate");
                      }
                    },
                    child: const Text('Confirm'),
                  )
                ],
              ),
            ),
          );
          homeCtrl.editingCtrl.clear();
          homeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 25.0.sp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
