import 'package:flutter/material.dart';
import 'package:multi_app/app/core/values/constants.dart';
import 'package:multi_app/app/modules/countdown/home/controller.dart';
import 'package:get/get.dart';
import 'package:multi_app/app/core/utils/extensions.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CountdownDetailPage extends StatelessWidget {
  final homeCtrl = Get.find<CountdownHomeController>();
  CountdownDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.todo.value!;
    var color = HexColor.fromHex(task.color);

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Form(
          key: homeCtrl.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.updateTodo();
                        homeCtrl.changeTask(null);
                        homeCtrl.editingCtrl.clear();
                      },
                      icon: Icon(Icons.arrow_back),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    Text(
                      task.title,
                      style: TextStyle(
                          fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6.0.wp),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: GestureDetector(
                  onTap: () {
                    print(task);
                    // open date time picker
                  },
                  child: Row(
                    children: [
                      Text(
                        task.time,
                        style: TextStyle(fontSize: 12.0.sp),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 3.0.wp),
              Padding(
                padding:
                    EdgeInsets.only(left: 16.0.wp, top: 3.0.wp, right: 16.0.wp),
                child: Row(
                  children: [
                    Text(
                      'Progress',
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 3.0.wp),
                    Expanded(
                      child: StepProgressIndicator(
                        totalSteps: 100,
                        currentStep: 11,
                        size: 5,
                        padding: 0,
                        selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [color.withOpacity(0.5), color],
                        ),
                        unselectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Colors.grey[300]!, Colors.grey[300]!],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0.wp, top: 3.0.wp),
                child: SelectDateFormat(task: task),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectDateFormat extends StatefulWidget {
  SelectDateFormat({Key? key, required this.task}) : super(key: key);
  final task;

  @override
  _SelectDateFormat createState() => _SelectDateFormat();
}

class _SelectDateFormat extends State<SelectDateFormat> {
  final homeCtrl = Get.find<CountdownHomeController>();
  List<dynamic> selectedDateFormatList = [];

  @override
  void initState() {
    if (widget.task != null) {
      if (widget.task.todos.runtimeType == Null
          ? widget.task.todos != null
          : widget.task.todos.isNotEmpty) {
        if (widget.task.todos[0]['title'] != null) {
          selectedDateFormatList = widget.task.todos;
        }
      }
    }
    super.initState();
  }

  _showReportDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          //Here we will build the content of the dialog
          return AlertDialog(
            title: Text("Date format"),
            content: MultiSelectChip(
              dateFormatList,
              selectedDateFormatList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedDateFormatList = selectedList;
                });
              },
              maxSelection: dateFormatList.length,
            ),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () => {
                  print(widget.task),
                  homeCtrl.addTodo(
                    "dateFormat: " + selectedDateFormatList.toString(),
                  ),
                  Get.back(),
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () => _showReportDialog(),
        /* child: Container(
          child: Text(homeCtrl
              .getDateTime(widget.task)
              .difference(DateTime.now())
              .toString()),
        ), */
        child: homeCtrl.countDownText(widget.task),
      ),
    );
  }
}

class MultiSelectChip extends StatefulWidget {
  final List<dynamic> dateList;
  final Function(List<dynamic>)? onSelectionChanged;
  final Function(List<dynamic>)? onMaxSelected;
  final int? maxSelection;
  final List<dynamic> selectedColor;

  MultiSelectChip(this.dateList, this.selectedColor,
      {this.onSelectionChanged, this.onMaxSelected, this.maxSelection});

  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  List<dynamic> selectedChoices = [];
  final homeCtrl = Get.find<CountdownHomeController>();

  _buildChoiceList() {
    List<Widget> choices = [];

    widget.dateList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selectedColor: Colors.blue[300],
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            if (selectedChoices.length == (widget.maxSelection ?? -1) &&
                !selectedChoices.contains(item)) {
              widget.onMaxSelected?.call(selectedChoices);
            } else {
              setState(() {
                selectedChoices.contains(item)
                    ? selectedChoices.remove(item)
                    : selectedChoices.add(item);
                widget.onSelectionChanged?.call(selectedChoices);
              });
            }
          },
        ),
      ));
    });

    return choices;
  }

  @override
  void initState() {
    if (widget.selectedColor[0] != null) {
      if (widget.selectedColor[0]['title'] != null) {
        var selectedList = homeCtrl.stringToList(
            widget.selectedColor[0]['title'], dateFormatList);
        selectedChoices = selectedList;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
