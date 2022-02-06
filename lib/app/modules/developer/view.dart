import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:multi_app/app/modules/applist/view.dart';
import 'package:multi_app/app/core/values/constants.dart';
import 'dart:io';

class DeveloperProfile extends StatelessWidget {
  const DeveloperProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mC,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 35),
                AvatarImage(),
                SizedBox(height: 15),
                Text(
                  'Sharann Nagarajan Ponnusamy',
                  style: TextStyle(fontSize: 21),
                ),
                SizedBox(height: 15),
                Text(
                  'Mobile App Developer',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    NMButton(icon: FontAwesomeIcons.facebookF),
                    SizedBox(width: 25),
                    NMButton(icon: FontAwesomeIcons.twitter),
                    SizedBox(width: 25),
                    NMButton(icon: FontAwesomeIcons.instagram),
                    SizedBox(width: 25),
                    NMButton(icon: FontAwesomeIcons.whatsapp),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SocialBox extends StatelessWidget {
  final IconData icon;
  final String count;
  final String category;

  const SocialBox(
      {required this.icon, required this.count, required this.category});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: nMboxInvert,
        child: Row(
          children: <Widget>[
            FaIcon(icon, color: Colors.pink.shade800, size: 20),
            SizedBox(width: 8),
            Text(
              count,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            SizedBox(width: 3),
            Text(
              category,
            ),
          ],
        ),
      ),
    );
  }
}

class NMButton extends StatelessWidget {
  final IconData icon;
  const NMButton({required this.icon});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        var url = '';
        if (icon == Icons.arrow_back) {
          Get.to(() => AppListPage());
        } else if (icon == Icons.menu) {
          Get.to(() => AppListPage());
        } else if (icon == FontAwesomeIcons.facebookF) {
          url = 'https://www.facebook.com/sharann.sharann.16';
        } else if (icon == FontAwesomeIcons.twitter) {
          url = 'https://mobile.twitter.com/isharann';
        } else if (icon == FontAwesomeIcons.instagram) {
          url = 'https://www.instagram.com/sharann_np/';
        } else if (icon == FontAwesomeIcons.whatsapp) {
          var whatsappURLIOS = "https://wa.me/+918248947601";
          var whatsappURLAndroid = "whatsapp://send?phone=+918248947601";
          if (Platform.isIOS) {
            // for iOS phone only
            if (await canLaunch(whatsappURLIOS)) {
              await launch(whatsappURLIOS, forceSafariVC: false);
              EasyLoading.showInfo('Opening WhatsApp');
            } else {
              EasyLoading.showInfo('whatsapp no installed in your iphone');
            }
          } else {
            if (await canLaunch(whatsappURLAndroid)) {
              await launch(whatsappURLAndroid);
              EasyLoading.showInfo('Opening WhatsApp');
            } else {
              EasyLoading.showInfo(
                  'whatsapp no installed in your android phone');
            }
          }
        }
        if (icon == FontAwesomeIcons.facebookF ||
            icon == FontAwesomeIcons.twitter ||
            icon == FontAwesomeIcons.instagram) {
          if (await canLaunch(url)) {
            await launch(url, universalLinksOnly: true);
          } else {
            EasyLoading.showInfo('There was a problem to open the url: $url');
            throw 'There was a problem to open the url: $url';
          }
        }
      },
      child: Container(
        width: 55,
        height: 55,
        decoration: nMbox,
        child: Icon(
          icon,
          color: fCL,
        ),
      ),
    );
  }
}

class AvatarImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      padding: EdgeInsets.all(8),
      decoration: nMbox,
      child: Container(
        decoration: nMbox,
        padding: EdgeInsets.all(3),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/developer.jpg'),
                fit: BoxFit.fitHeight),
          ),
        ),
      ),
    );
  }
}
