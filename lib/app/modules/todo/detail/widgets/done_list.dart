import 'package:flutter/material.dart';
import 'package:multi_app/app/modules/todo/home/controller.dart';
import 'package:get/get.dart';
import 'package:multi_app/app/core/values/colors.dart';
import 'package:multi_app/app/core/utils/extensions.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class DoneList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doneTodos.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 2.0.wp,
                  horizontal: 5.0.wp,
                ),
                child: Text(
                  'Completed (${homeCtrl.doneTodos.length})',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...homeCtrl.doneTodos
                  .map((element) => Dismissible(
                        key: ObjectKey(element),
                        direction: DismissDirection.endToStart,
                        onDismissed: (_) => homeCtrl.deleteDoneTodo(element),
                        background: Container(
                          color: Colors.red.withOpacity(0.8),
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 5.0.wp),
                            child:
                                const Icon(Icons.delete, color: Colors.white),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 3.0.wp,
                            horizontal: 9.0.wp,
                          ),
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  homeCtrl.doingTodo(element['title']);
                                },
                                child: const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Icon(Icons.done, color: blue),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  await Get.defaultDialog(
                                    titlePadding:
                                        EdgeInsets.symmetric(vertical: 5.0.wp),
                                    radius: 5,
                                    title:
                                        'Are you sure want to delete this todo',
                                    content: Form(
                                      onChanged: () {},
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: green,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  minimumSize:
                                                      const Size(50, 24),
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text('No'),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: red,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  minimumSize:
                                                      const Size(50, 24),
                                                ),
                                                onPressed: () {
                                                  var success = homeCtrl
                                                      .delDoneTodo(element);
                                                  if (success) {
                                                    EasyLoading.showSuccess(
                                                        'Todo item deleted');
                                                  } else {
                                                    EasyLoading.showError(
                                                        'Todo item not exists');
                                                  }
                                                  Get.back();
                                                },
                                                child: const Text('Yeah'),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 4.0.wp),
                                  child: Text(
                                    element['title'],
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList()
            ],
          )
        : Container());
  }
}
