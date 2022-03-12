import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:convert';

class Utility {
  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }

  /// Converts Feet and Inches to Meters
  double convertFtIntoM(Map<String, double> ftIn, [int precision = 2]) {
    var meter = (ftIn['feet']! * 0.3048) + (ftIn['inch']! * 0.0254);
    String _meter = meter.toStringAsFixed(precision);
    meter = double.parse(_meter);
    return meter;
  }

  /// Converts Centimeters to Meters
  double convertCMtoM(double cm, [int precision = 2]) {
    var meter = cm * 0.01;
    String _meter = meter.toStringAsFixed(precision);
    meter = double.parse(_meter);
    return meter;
  }

  /// Converts Pounds to Kilograms
  double convertLBtoKG(double lb, [int precision = 2]) {
    var kg = lb * 0.45359237;
    String _kg = kg.toStringAsFixed(precision);
    kg = double.parse(_kg);
    return kg;
  }

  String bmiStatusWithText(bmi, gender) {
    var bmiInfo = bmiStatusWithTextAndColor(bmi, gender);
    return bmiInfo['bmiWithStatusText'];
  }

  Color bmiColor(bmi, gender) {
    var bmiInfo = bmiStatusWithTextAndColor(bmi, gender);
    return bmiInfo['color'];
  }

  static bmiStatusWithTextAndColor(bmi, gender) {
    bmi = double.parse(bmi);
    String statusText = '';
    Color color = Colors.purple;
    if (gender == 'male') {
      if (bmi <= 18.5) {
        statusText = 'Underweight';
        color = Colors.blue;
      } else if (bmi > 18.5 && bmi <= 24.9) {
        statusText = 'Normal';
        color = Colors.green;
      } else if (bmi >= 25.0 && bmi <= 29.9) {
        statusText = 'Overweight';
        color = Colors.yellow;
      } else if (bmi >= 30.0 && bmi <= 34.9) {
        statusText = 'Obese';
        color = Colors.orange;
      } else if (bmi >= 35.0) {
        statusText = 'Extremely Obese';
        color = Colors.red;
      }
    } else {
      if (bmi <= 18.5) {
        statusText = 'Underweight';
        color = Colors.blue;
      } else if (bmi > 18.5 && bmi <= 24.9) {
        statusText = 'Normal';
        color = Colors.green;
      } else if (bmi >= 25.0 && bmi <= 29.9) {
        statusText = 'Overweight';
        color = Colors.orange;
      } else if (bmi >= 30.0) {
        statusText = 'Obese';
        color = Colors.red;
      }
    }
    return {
      'bmiWithStatusText': (statusText == '' || bmi == 0.0) ? '$bmi' : '$bmi - $statusText',
      'color': color,
    };
  }
}