import 'package:flutter/material.dart';
import 'package:multi_app/app/modules/countdown/home/controller.dart';
import 'package:get/get.dart';
import 'package:multi_app/app/core/utils/extensions.dart';

class CountdownDoingList extends StatelessWidget {
  final homeCtrl = Get.find<CountdownHomeController>();
  CountdownDoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        children: [
          Text(
            'homeCtrl.todo.time',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0.sp,
            ),
          ),
        ],
      ),
    );
  }
}
