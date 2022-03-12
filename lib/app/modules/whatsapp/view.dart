import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_app/main.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:multi_app/app/modules/todo/home/controller.dart';
import 'package:get/get.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:multi_app/app/core/values/colors.dart';
import 'package:multi_app/app/core/utils/extensions.dart';

class WhatsAppPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  final countryCodeCtrl = TextEditingController();
  WhatsAppPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    openwhatsapp(whatsapp) async {
      var whatsappURLAndroid = "whatsapp://send?phone=" + whatsapp;
      var whatappURLIos = "https://wa.me/$whatsapp";
      if (Platform.isIOS) {
        // for iOS phone only
        if (await canLaunch(whatappURLIos)) {
          await launch(whatappURLIos, forceSafariVC: false);
          EasyLoading.showInfo('Opening WhatsApp');
        } else {
          EasyLoading.showInfo('whatsapp no installed in your iphone');
        }
      } else {
        // for android, web
        if (await canLaunch(whatsappURLAndroid)) {
          await launch(whatsappURLAndroid);
          EasyLoading.showInfo('Opening WhatsApp');
        } else {
          EasyLoading.showInfo('whatsapp no installed in your android phone');
        }
      }
    }

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 10.0.wp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: GestureDetector(
                  child: Icon(Icons.menu),
                  onTap: () {
                    Get.to(() => AppHomePage());
                  },
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0.wp),
              child: Form(
                key: homeCtrl.formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: CountryCodePicker(
                              initialSelection: 'IN',
                              showCountryOnly: false,
                              showOnlyCountryWhenClosed: true,
                              favorite: ['+91', 'IN'],
                              enabled: true,
                              hideMainText: true,
                              showFlagMain: true,
                              showFlag: true,
                              hideSearch: false,
                              showFlagDialog: true,
                              alignLeft: true,
                              onInit: (value) {
                                countryCodeCtrl.text = value.toString();
                              },
                              onChanged: (value) {
                                countryCodeCtrl.text = value.toString();
                              },
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              controller: homeCtrl.editingCtrl,
                              keyboardType: TextInputType.phone,
                              decoration: const InputDecoration(
                                labelText: 'Phone number',
                              ),
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return 'Please enter phone number';
                                }
                                const pattern =
                                    r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
                                final regExp = RegExp(pattern);
                                if (!regExp.hasMatch(value)) {
                                  return 'Please enter valid phone number';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            minimumSize: const Size(150, 40),
                          ),
                          onPressed: () {
                            if (homeCtrl.formKey.currentState!.validate()) {
                              openwhatsapp(countryCodeCtrl.text +
                                  homeCtrl.editingCtrl.text);
                            }
                          },
                          child: Text('Message'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
