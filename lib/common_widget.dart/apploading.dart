// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/utils/platform_utils.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: PlatformUtils.isAndroid
            ? const CircularProgressIndicator(
                color: themeBlueColor,
              )
            : const CupertinoActivityIndicator(
                radius: 18,
                color: themeBlueColor,
              ),
      ),
    );
  }
}
