import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_app/app/core/utils/utility.dart';
import 'package:multi_app/app/core/values/colors.dart';
import 'package:multi_app/app/core/values/constants.dart';

class BmiCalculatorPage extends StatefulWidget {
  const BmiCalculatorPage({Key? key}) : super(key: key);

  @override
  _BmiCalculatorPageState createState() => _BmiCalculatorPageState();
}

class _BmiCalculatorPageState extends State<BmiCalculatorPage> {
  int currentIndex = 0;
  String result = '0';
  TextEditingController heightController = TextEditingController();
  TextEditingController heightController2 = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double h = 0;
  double h2 = 0;
  double w = 0;
  final utility = Get.find<Utility>();
  String _heightUnit = 'cm';
  String _weightUnit = 'kg';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  radioButton("Men", blue, 0),
                  radioButton("Women", green, 1),
                ],
              ),
              SizedBox(height: 12.0),
              RichText(
                text: TextSpan(
                  text: 'Your height in ',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  children: [
                    TextSpan(
                      text: _heightUnit,
                      style: TextStyle(color: blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          print('object');
                          setState(() {
                            var index = heightUnits.indexOf(_heightUnit);
                            var value = index == heightUnits.length - 1
                                ? heightUnits[0]
                                : heightUnits[index + 1];
                            _heightUnit = value;
                          });
                        },
                    ),
                    TextSpan(text: ' : '),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              _heightUnit != 'feet + inches'
                  ? TextField(
                      keyboardType: TextInputType.number,
                      controller: heightController,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: "Your height in '$_heightUnit'",
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () => {
                            heightController.clear,
                            setState(() {
                              result = "0";
                            }),
                          },
                          icon: Icon(Icons.clear),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: heightController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: "Your height in 'feet'",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => {
                                heightController.clear,
                                setState(() {
                                  result = "0";
                                }),
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ),
                        ),
                        SizedBox(height: 12.0),
                        TextField(
                          keyboardType: TextInputType.number,
                          controller: heightController2,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: "Your height in 'inchs'",
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () => {
                                heightController2.clear,
                                setState(() {
                                  result = "0";
                                }),
                              },
                              icon: Icon(Icons.clear),
                            ),
                          ),
                        ),
                      ],
                    ),
              SizedBox(height: 12.0),
              RichText(
                text: TextSpan(
                  text: 'Your weight in ',
                  style: TextStyle(color: Colors.black, fontSize: 16.0),
                  children: [
                    TextSpan(
                      text: _weightUnit,
                      style: TextStyle(color: blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          print('weight');
                          setState(() {
                            var index = weightUnits.indexOf(_weightUnit);
                            var value = index == weightUnits.length - 1
                                ? weightUnits[0]
                                : weightUnits[index + 1];
                            _weightUnit = value;
                          });
                        },
                    ),
                    TextSpan(text: ' : '),
                  ],
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                keyboardType: TextInputType.number,
                controller: weightController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "Your weight in '$_weightUnit'",
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => {
                      weightController.clear,
                      setState(() {
                        result = "0";
                      }),
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    minimumSize: const Size(180, 40),
                  ),
                  onPressed: () {
                    setState(() {
                      h = double.parse(heightController.value.text);
                      h2 = double.parse(heightController2.value.text == ""
                          ? "0"
                          : heightController2.value.text);
                      w = double.parse(weightController.value.text);
                    });
                    calculateBmi(h, h2, w);
                  },
                  child: Text(
                    'Calculate',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 26.0),
              Container(
                width: double.infinity,
                child: Text(
                  'Your BMI is :',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15.0),
              SizedBox(height: 15.0),
              Container(
                width: double.infinity,
                child: Text(
                  utility.bmiStatusWithText(
                    result,
                    currentIndex == 0 ? 'male' : 'female',
                  ),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: utility.bmiColor(
                      result,
                      currentIndex == 0 ? 'male' : 'female',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18.0),
              currentIndex == 0
                  ? Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '<= 18.5',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '> 18.5 and <= 24.9',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '>= 25.0 and <= 29.9',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '>= 30.0 and <= 34.9',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 28.0),
                        Text(
                          '>= 35.0',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )
                  : Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '<= 18.5',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '> 18.5 and <= 24.9',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '>= 25.0 and <= 29.9',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          '>= 30.0',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void calculateBmi(double height, double height2, double weight) {
    var _meter = height;
    if (_heightUnit == 'cm') {
      _meter = utility.convertCMtoM(height);
    } else if (_heightUnit == 'feet + inches') {
      _meter = utility.convertFtIntoM({'feet': height, 'inch': height2}, 2);
    }

    var _kg = weight;
    if (_weightUnit == 'lbs') {
      _kg = utility.convertLBtoKG(weight);
    }

    double _result = _kg / (_meter * _meter);
    String bmi = _result.toStringAsFixed(2);

    setState(() {
      result = bmi;
    });
  }

  Widget radioButton(String value, Color color, int index) {
    final backgroundColor = currentIndex == index ? color : Colors.grey[200];
    final textColor = currentIndex == index ? Colors.white : color;

    return ElevatedButton(
      onPressed: () {
        changeIndex(index);
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) => states.contains(MaterialState.disabled)
              ? Colors.white38
              : backgroundColor,
        ),
        elevation: MaterialStateProperty.resolveWith<double?>(
          (states) => 0,
        ),
        shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
          (states) => const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            value == 'Men' ? Icons.male : Icons.female,
            color: textColor,
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: TextStyle(color: textColor, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
