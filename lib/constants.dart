import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String getAsset(String imageName) => 'assets/$imageName.png';

String getLottie(String name) => 'assets/images/$name.json';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

const Color kMainColor = Color(0xffDE1F14);
const Color kPrimaryColor = Color(0xFF043536);
const Color kSecondaryColor = Color(0xFFBFB7AB);
const Color kAccentColor = Color(0xFFFFFFFF);
const Color kBorderColor = Color(0xFFBFB7AB);
const Color kSecondaryTextColor = Color(0xFFA5A3A3);
const Color kBlackColor = Color(0xFF000000);
const Color kGreyColor = Color(0xFFD1D8DD);
const Color kUnselectedColor = Color(0xFFAAAEB4);
const Color kGreenColor = Color(0xff21B573);
const Color kRedColor = Color(0xffE92929);

BoxShadow shadow = BoxShadow(
    offset: Offset(0, 1),
    blurRadius: 10,
    color: Colors.black.withOpacity(0.16));

extension NumberExtensions on num {
  SizedBox get hSpace => SizedBox(height: toDouble());

  SizedBox get wSpace => SizedBox(width: toDouble());
}
