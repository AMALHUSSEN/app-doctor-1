import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';

class CommonWidget {
  static void showErrorMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: themeBlueColor,
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: appTextStyle.copyWith(
            fontSize: 16.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static void showSheet(
    BuildContext context, {
    required Widget child,
    required VoidCallback onClicked,
  }) => showCupertinoModalPopup(
    context: context,
    builder: (context) => CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          actionTextStyle: appTextStyle.copyWith(
            fontSize: 18.0,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      child: CupertinoActionSheet(
        actions: [child],
        cancelButton: CupertinoActionSheetAction(
          onPressed: onClicked,
          child: Text(
            AppLocalizations.of(context)!.done,
            style: appTextStyle.copyWith(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );

  static String getFormattedTime(String time) {
    DateFormat format = DateFormat("hh:mm a");
    var formatedTime = format.format(DateTime.parse(time));
    // debugPrint("F_time->$formatedTime");
    // debugPrint("F_time->${DateTime.parse(time)}");
    return formatedTime;
  }

  static String getFormattedTimeLocale(String date) {
    DateFormat format = DateFormat("hh:mm a");
    var fDate = format.format(DateTime.parse('${date}Z').toLocal());
    debugPrint("F_DATE->$fDate");
    return fDate;
  }

  static String getFormattedTimeLocaleDoseDate(String date) {
    DateFormat format = DateFormat("MMMM dd, yyyy");
    var fDate = format.format(DateTime.parse(date).toLocal());
    debugPrint("F_DATE->$fDate");
    return fDate;
  }

  static String getFormattedTimeLocal(String date) {
    DateFormat format = DateFormat("hh:mm a");
    var fDate = format.format(DateTime.parse('${date}Z').toLocal());
    debugPrint("F_DATE->$fDate");
    return fDate;
  }

  static String getFormatDateTimeLocaleDoseTime(String date) {
    DateFormat format = DateFormat("hh:mm a");
    var fDate = format.format(DateTime.parse('${date}Z').toLocal());
    debugPrint("F_DATE->$fDate");
    return fDate;
  }

  static String getFormatDateTimeLocale(String date) {
    DateFormat format = DateFormat("MMM dd, yyyy hh:mm a");
    var fDate = format.format(DateTime.parse('${date}Z').toLocal());
    debugPrint("F_DATE->$fDate");
    return fDate;
  }

  static String getFormatedDateTimeLocale(String date) {
    DateFormat format = DateFormat("dd MMM, yyyy hh:mm a");
    var fDate = format.format(DateTime.parse('${date}Z').toLocal());
    debugPrint("F_DATE->$fDate");
    return fDate;
  }

  static String getFormatedDateTime(String date) {
    DateFormat format = DateFormat("dd MMM, yyyy hh:mm a");
    var fDate = format.format(DateTime.parse(date));
    debugPrint("F_DATE->$fDate");
    return fDate;
  }

  static String getDateTimeLocalFormat(String date) {
    DateFormat format = DateFormat("MMM dd, yyyy hh:mm a");
    var fDate = format.format(DateTime.parse(date).toLocal());
    debugPrint("F_DATE->$fDate");
    return fDate;
  }

  static String parseHtmalString(String htmlString) {
    final String paesedString = Bidi.stripHtmlIfNeeded(htmlString);
    return paesedString;
  }

  static String dateFormate(String date, String pattern) {
    DateFormat format = DateFormat(pattern);
    var fDate = format.format(DateTime.parse(date).toLocal());

    return fDate;
  }

  static String getLocalDate(String date, String pattern) {
    DateFormat format = DateFormat(pattern);
    var fDate = format.format(DateTime.parse(date));
    debugPrint("F_DATE->$fDate");
    return fDate;
  }

  static String getLocaleTime(String date) {
    DateFormat format = DateFormat("hh:mm a");
    var fDate = format.format(DateTime.parse(date));
    debugPrint("getLocaleTime->$fDate");
    return fDate;
  }
}
