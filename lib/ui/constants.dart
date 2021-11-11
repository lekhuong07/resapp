import 'package:flutter/material.dart';

const appColor = Color.fromRGBO(25, 93, 138, 1);
const appDisabledColor = Color.fromRGBO(25, 93, 138, 0.5);

Size screenSize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double screenHeight(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).height / dividedBy;
}

double screenTab(BuildContext context, {double dividedBy = 25}) {
  return screenSize(context).height / dividedBy;
}

double middleTab(BuildContext context, {double dividedBy = 10}) {
  return screenSize(context).width - (screenSize(context).height / dividedBy);
}

double screenWidth(BuildContext context, {double dividedBy = 1}) {
  return screenSize(context).width / dividedBy;
}

double midWidth(BuildContext context, {double dividedBy = 2}) {
  return screenSize(context).width / dividedBy;
}

double midHeight(BuildContext context, {double dividedBy = 2}) {
  return screenSize(context).height / dividedBy;
}

double buttonWidth(BuildContext context, {double dividedBy = 3}) {
  return screenSize(context).width / dividedBy;
}

double buttonHeight(BuildContext context, {double dividedBy = 20}) {
  return screenSize(context).height / dividedBy;
}

double imageHeight(BuildContext context, {double dividedBy = 3}) {
  return screenSize(context).height / dividedBy;
}

double imageWidth(BuildContext context, {double dividedBy = 3}) {
  return screenSize(context).width / dividedBy;
}

double iconSize(BuildContext context, {double dividedBy = 20}) {
  return screenSize(context).width / dividedBy;
}

double fontSizeBig(BuildContext context, {double dividedBy = 10}) {
  return screenSize(context).width / dividedBy;
}

double fontSizeNormal(BuildContext context, {double dividedBy = 16}) {
  return screenSize(context).width / dividedBy;
}

double fontSizeSmall(BuildContext context, {double dividedBy = 22}) {
  return screenSize(context).width / dividedBy;
}

double fontSizeExtraSmall(BuildContext context, {double dividedBy = 26}) {
  return screenSize(context).width / dividedBy;
}