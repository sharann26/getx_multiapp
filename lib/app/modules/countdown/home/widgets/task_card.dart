import 'package:flutter/material.dart';
import 'package:multi_app/app/modules/countdown/detail/view.dart';
import 'package:multi_app/app/modules/countdown/home/controller.dart';
import 'package:get/get.dart';
import 'package:multi_app/app/data/models/todo.dart';
import 'package:multi_app/app/widget/icons.dart';
import 'package:multi_app/app/core/utils/extensions.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class CountdownTaskCard extends StatelessWidget {
  final homeCtrl = Get.find<CountdownHomeController>();
  final Todo todo;
  CountdownTaskCard({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    final color = HexColor.fromHex(todo.color);
    var squareWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: () {
        homeCtrl.changeTask(todo);
        homeCtrl.changeTodos(todo.todos ?? []);
        Get.to(() => CountdownDetailPage());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: const Offset(0, 7),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              // totalSteps: homeCtrl.isTodosEmpty(todo) ? 1 : todo.todos!.length,
              totalSteps: 3,
              // currentStep:
              //     homeCtrl.isTodosEmpty(todo) ? 0 : homeCtrl.getDoneTodo(todo),
              currentStep: 1,
              size: 5,
              padding: 0,
              selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5), color]),
              unselectedGradientColor: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white]),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Text(homeCtrl.convertToCountdownTime(todo.time)),
              // child: CountDownText(
              //   due: DateTime.parse(todo.time),
              //   finishedText: 'Completed',
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
