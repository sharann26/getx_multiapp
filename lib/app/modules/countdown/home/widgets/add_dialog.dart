import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_app/app/modules/countdown/home/controller.dart';
import 'package:get/get.dart';
import 'package:multi_app/app/core/utils/extensions.dart';

class CountdownAddDialog extends StatelessWidget {
  final homeCtrl = Get.find<CountdownHomeController>();
  CountdownAddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.editingCtrl.clear();
                        homeCtrl.changeTask(null);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        if (homeCtrl.formKey.currentState!.validate()) {
                          if (homeCtrl.todo.value == null) {
                            EasyLoading.showError('Please select task type');
                          } else {
                            var success = homeCtrl.updateTask(
                              homeCtrl.todo.value!,
                              homeCtrl.editingCtrl.text,
                            );
                            if (success) {
                              EasyLoading.showSuccess('Todo item add success');
                              Get.back();
                              homeCtrl.changeTask(null);
                            } else {
                              EasyLoading.showError('Todo item already added');
                            }
                            homeCtrl.editingCtrl.clear();
                          }
                        }
                      },
                      child: Text(
                        'Done',
                        style: TextStyle(fontSize: 14.0.sp),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0.wp,
                ),
                child: Text(
                  'New Task',
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
                child: TextFormField(
                  controller: homeCtrl.editingCtrl,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey[400]!),
                    ),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter todo item';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 5.0.wp, left: 5.0.wp, right: 5.0.wp, bottom: 2.0.wp),
                child: Text(
                  'Add to',
                  style: TextStyle(fontSize: 14.0.sp, color: Colors.grey),
                ),
              ),
              ...homeCtrl.todos.map(
                (element) => Obx(
                  () => InkWell(
                    onTap: () => homeCtrl.changeTask(element),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 3.0.wp,
                        horizontal: 5.0.wp,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(element.time.toString()),
                              SizedBox(width: 3.0.wp),
                              Text(
                                element.title,
                                style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          if (homeCtrl.todo.value == element)
                            const Icon(Icons.check, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
