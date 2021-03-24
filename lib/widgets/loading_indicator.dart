import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void onLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return customCupertinoActivityIndicator(false);
    },
  );
}

Widget customCupertinoActivityIndicator(bool isLight) {
  return Center(
      child: Theme(
          data: ThemeData(
              cupertinoOverrideTheme: CupertinoThemeData(
                  brightness: isLight ? Brightness.light : Brightness.dark)),
          child: CupertinoActivityIndicator(
            radius: 30,
          ))
    // child:  CupertinoActivityIndicator(
    //   radius: SizeConfig.imageSizeMultiplier * 10,),
  );
}