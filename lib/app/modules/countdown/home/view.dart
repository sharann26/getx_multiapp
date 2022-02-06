import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:multi_app/app/data/models/todo.dart';
import 'package:multi_app/app/modules/countdown/home/controller.dart';
import 'package:multi_app/app/core/utils/extensions.dart';
import 'package:multi_app/app/widget/icons.dart';
import 'package:multi_app/app/modules/countdown/home/widgets/task_card.dart';
import 'package:multi_app/app/core/values/colors.dart';
import 'package:multi_app/app/modules/countdown/report/view.dart';
import 'package:date_format/date_format.dart';
import 'package:intl/intl.dart';

class CountdownHomePage extends GetView<CountdownHomeController> {
  final homeCtrl = Get.find<CountdownHomeController>();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  bool _seen = false;

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    return _seen
        ? Container(
            color: Color.fromRGBO(186, 197, 216, 1),
            child: Padding(
              padding: EdgeInsets.all(3.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset('assets/images/under_development.png',
                      width: 420, height: 420),
                  Text(
                    'Under Development',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontFamily: 'HandWriting',
                    ),
                  ),
                  SizedBox(height: 4.0.wp),
                  GestureDetector(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 28.0.wp),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 12.0),
                          Text('Go back to app list'),
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.back();
                    },
                  )
                ],
              ),
            ),
          )
        : Scaffold(
            body: Obx(
              () => IndexedStack(
                index: controller.tabIndex.value,
                children: [
                  SafeArea(
                    child: ListView(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0.wp),
                          child: Text(
                            controller.todos.isEmpty ? '' : 'My Countdown List',
                            style: TextStyle(
                              fontSize: 24.0.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Obx(
                          () => controller.todos.isEmpty
                              ? Column(
                                  children: [
                                    SizedBox(height: 10.0.wp),
                                    Image.asset(
                                      'assets/images/countdown.png',
                                      fit: BoxFit.cover,
                                      width: 35.0.wp,
                                      colorBlendMode: BlendMode.srcATop,
                                    ),
                                    SizedBox(height: 5.0.wp),
                                    Text(
                                      "Let's start countdown",
                                      style: TextStyle(
                                        fontFamily: 'SquidGame',
                                        fontSize: 16.0.sp,
                                      ),
                                    ),
                                  ],
                                )
                              : GridView.count(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  children: [
                                    ...controller.todos
                                        .map((element) => LongPressDraggable(
                                              data: element,
                                              onDragStarted: () => controller
                                                  .changeDeleting(true),
                                              onDraggableCanceled: (_, __) =>
                                                  controller
                                                      .changeDeleting(false),
                                              onDragEnd: (_) => controller
                                                  .changeDeleting(false),
                                              feedback: Opacity(
                                                opacity: 0.8,
                                                child: CountdownTaskCard(
                                                    todo: element),
                                              ),
                                              child: CountdownTaskCard(
                                                  todo: element),
                                            ))
                                        .toList(),
                                  ],
                                ),
                        )
                      ],
                    ),
                  ),
                  CountdownReportPage(),
                ],
              ),
            ),
            floatingActionButton: DragTarget<Todo>(
              builder: (_, __, ___) {
                return Obx(
                  () => FloatingActionButton(
                    backgroundColor:
                        controller.deleting.value ? Colors.red : blue,
                    onPressed: () async {
                      await Get.defaultDialog(
                        titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
                        radius: 5,
                        title: 'Task Type',
                        content: Form(
                          key: homeCtrl.formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 3.0.wp),
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
                                child: dateTimePicker(
                                  dateController: _dateController,
                                  timeController: _timeController,
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
                                  if (homeCtrl.formKey.currentState!
                                      .validate()) {
                                    String time = _dateController.text +
                                        " " +
                                        _timeController.text;
                                    String color =
                                        icons[homeCtrl.chipIndex.value]
                                            .color!
                                            .toHex();
                                    var task = Todo(
                                      title: homeCtrl.editingCtrl.text,
                                      time: time,
                                      color: color,
                                    );
                                    Get.back();
                                    homeCtrl.addTask(task)
                                        ? EasyLoading.showSuccess(
                                            "Task created")
                                        : EasyLoading.showError(
                                            "Task is duplicate");
                                  }
                                },
                                child: const Text('Confirm'),
                              )
                            ],
                          ),
                        ),
                      );
                      homeCtrl.editingCtrl.clear();
                      _dateController.clear();
                      _timeController.clear();
                      homeCtrl.changeChipIndex(0);
                    },
                    child: Icon(
                        controller.deleting.value ? Icons.delete : Icons.add),
                  ),
                );
              },
              onAccept: (Todo todo) {
                controller.deleteTask(todo);
                EasyLoading.showSuccess('Task deleted');
              },
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: Obx(
                () => BottomNavigationBar(
                  onTap: (int index) => controller.changeTabIndex(index),
                  currentIndex: controller.tabIndex.value,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: [
                    BottomNavigationBarItem(
                      label: 'Home',
                      icon: Padding(
                        padding: EdgeInsets.only(right: 15.0.wp),
                        child: const Icon(Icons.apps),
                      ),
                    ),
                    BottomNavigationBarItem(
                      label: 'Report',
                      icon: Padding(
                        padding: EdgeInsets.only(left: 15.0.wp),
                        child: const Icon(Icons.data_usage),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}

class dateTimePicker extends StatelessWidget {
  dateTimePicker({
    Key? key,
    required this.dateController,
    required this.timeController,
  }) : super(key: key);

  double _height = 0.0;
  double _width = 0.0;
  String _setTime = '', _setDate = '';
  String _hour = '', _minute = '', _time = '';
  String dateTime = '';
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime =
      TimeOfDay(hour: DateTime.now().hour, minute: DateTime.now().minute);
  final TextEditingController dateController;
  final TextEditingController timeController;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2091));
    if (picked != null) {
      dateController.text = DateFormat.yMMMd('en_US').format(picked);
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      selectedTime = picked;
      _hour = selectedTime.hour.toString();
      _minute = selectedTime.minute.toString();
      _time = _hour + ' : ' + _minute;
      timeController.text = _time;
      print(selectedDate);
      timeController.text = formatDate(
          DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, selectedTime.hour, selectedTime.minute),
          [hh, ':', nn, " ", am]).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
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
              controller: dateController,
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
              controller: timeController,
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
