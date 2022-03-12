import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:multi_app/app/modules/applist/view.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardPage extends StatelessWidget {
  OnboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IntroductionScreen(
        pages: [
          PageViewModel(
              title: 'WhatsApp Chat',
              body: 'Chat with unsaved number from WhatsApp',
              image: buildImage('assets/images/whatsapp.png'),
              decoration: getPageDecoration()),
          PageViewModel(
              title: 'BMI Calculator',
              body: 'To calculate our bmi value for given weight and height',
              image: buildImage('assets/images/weight_tracker.png'),
              decoration: getPageDecoration()),
          PageViewModel(
              title: 'ToDo',
              body:
                  'Used to maintain our day-to-day tasks/list everything that we have to do',
              image: buildImage('assets/images/todo.png'),
              decoration: getPageDecoration()),
          PageViewModel(
              title: 'Countdown',
              body: 'Will predict exactly how long is left',
              image: buildImage('assets/images/countdown.png'),
              decoration: getPageDecoration()),
        ],
        done: Text(
          'Go to App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        onDone: goToAppList,
        showSkipButton: true,
        skip: Text('Skip'),
        next: Icon(Icons.arrow_forward),
        dotsDecorator: getDotsDecorator(),
      ),
    );
  }

  goToAppList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seen', true);
    Get.to(() => AppListPage());
  }

  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 150, height: 150));

  DotsDecorator getDotsDecorator() => DotsDecorator(
        color: Color(0XFFBDBDBD),
        activeColor: Colors.blue,
        size: Size(10, 10),
        activeSize: Size(22, 10),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
      );

  PageDecoration getPageDecoration() => PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
      bodyTextStyle: TextStyle(fontSize: 20),
      descriptionPadding: EdgeInsets.all(16).copyWith(bottom: 0),
      imagePadding: EdgeInsets.all(24),
      pageColor: Colors.white);
}
