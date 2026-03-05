// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/l10n/l10n.dart';

String _getDeviceLocale() {
  if (kIsWeb) {
    return 'en';
  }
  try {
    // ignore: uri_does_not_exist
    return _getPlatformLocale();
  } catch (_) {
    return 'en';
  }
}

String _getPlatformLocale() {
  // dart:io is only available on non-web platforms
  // This will be tree-shaken on web
  try {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    return locale.languageCode;
  } catch (_) {
    return 'en';
  }
}

class LocaleProvider extends ChangeNotifier {
  Locale _locale = Locale(_getDeviceLocale());

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }
}
