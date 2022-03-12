import 'package:get/get.dart';
import 'package:multi_app/app/core/utils/utility.dart';
import 'package:multi_app/app/data/providers/task/provider.dart';
import 'package:multi_app/app/data/services/storage/repository.dart';
import 'package:multi_app/app/modules/countdown/home/controller.dart';
import 'package:multi_app/app/modules/todo/home/controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
      fenix: true
    );
    Get.lazyPut(
      () => CountdownHomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
      fenix: true
    );
    Get.lazyPut(
      () => Utility(),
      fenix: true
    );
  }
}
