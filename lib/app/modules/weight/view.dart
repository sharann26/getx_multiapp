import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_app/app/core/utils/extensions.dart';

class WeightTrackerPage extends StatelessWidget {
  const WeightTrackerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
