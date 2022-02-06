import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:multi_app/app/core/utils/extensions.dart';
import 'package:multi_app/app/modules/countdown/home/view.dart';
import 'package:multi_app/app/modules/todo/home/view.dart';
import 'package:multi_app/app/modules/weight/view.dart';
import 'package:multi_app/app/modules/whatsapp/view.dart';

class AppListPage extends StatelessWidget {
  AppListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(4.0.wp),
            child: Text(
              'My App List',
              style: TextStyle(
                fontSize: 24.0.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'SquidGame',
              ),
            ),
          ),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              AppInfo(
                  page: 'WhatsAppPage',
                  color: Colors.greenAccent,
                  appDetail: {"name": "WhatsApp", "icon": FontAwesomeIcons.whatsappSquare}),
              AppInfo(
                  page: 'WeightTracker',
                  color: Colors.deepPurpleAccent,
                  appDetail: {
                    "name": "Weight Tracker",
                    "icon": FontAwesomeIcons.weight
                  }),
              AppInfo(
                  page: 'TodoHomePage',
                  color: Colors.redAccent,
                  appDetail: {"name": "ToDo", "icon": FontAwesomeIcons.tasks}),
              AppInfo(
                  page: 'CountdownHomePage',
                  color: Colors.redAccent,
                  appDetail: {"name": "Countdown", "icon": FontAwesomeIcons.clock}),
            ],
          ),
        ],
      ),
    );
  }
}

class AppInfo extends StatelessWidget {
  AppInfo({Key? key, this.page, required this.color, required this.appDetail})
      : super(key: key);

  final squareWidth = Get.width - 12.0.wp;
  final page;
  final Color color;
  final appDetail;

  Widget getPage(_page) {
    switch (_page) {
      case 'WhatsAppPage':
        return WhatsAppPage();
      case 'WeightTracker':
        return WeightTrackerPage();
      case 'CountdownHomePage':
        return CountdownHomePage();
      case 'TodoHomePage':
        return TodoHomePage();
      default:
        return TodoHomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => getPage(page));
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
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
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Icon(
                appDetail['icon'],
                color: color,
                size: 42,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(6.0.wp),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appDetail['name'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
