import 'package:flutter/cupertino.dart';
import 'package:multi_app/app/core/values/colors.dart';
import 'package:multi_app/app/core/values/icons.dart';

List<Icon> getIcons() {
  return const [
    Icon(IconData(personIcon, fontFamily: 'MaterialIcons'), color: purple),
    Icon(IconData(workIcon, fontFamily: 'MaterialIcons'), color: pink),
    Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'), color: deepPink),
    Icon(IconData(sportIcon, fontFamily: 'MaterialIcons'), color: green),
    Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'), color: yellow),
    Icon(IconData(shopIcon, fontFamily: 'MaterialIcons'), color: lightBlue),
    Icon(IconData(walletIcon, fontFamily: 'MaterialIcons'), color: blue),
  ];
}