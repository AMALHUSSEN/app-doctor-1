import 'dart:convert';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

class RemoteConfigService {
  static final RemoteConfigService _instance = RemoteConfigService._internal();
  factory RemoteConfigService() => _instance;
  RemoteConfigService._internal();

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  String _environment = 'testing';
  String _apiBaseUrlApp1 = 'https://app.smarthealth-sa.com/api';

  String get environment => _environment;
  String get apiBaseUrlApp1 => _apiBaseUrlApp1;

  // Default API base URL for this app (app1)
  String get apiBaseUrl => '$_apiBaseUrlApp1/';

  bool get isProduction => _environment == 'production';
  bool get isTesting => _environment == 'testing';

  Future<void> initialize() async {
    try {
      // Set default values
      await _remoteConfig.setDefaults(<String, dynamic>{
        'app_config': jsonEncode({
          'environment': 'testing',
          'production': {
            'api_base_url_app1': 'https://stg-1.smarthealth-sa.com/api',
          },
          'testing': {
            'api_base_url_app1': 'https://app.smarthealth-sa.com/api',
          },
        }),
      });

      // Configure fetch settings
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );

      // Fetch and activate remote config
      await _remoteConfig.fetchAndActivate();

      // Parse the config
      _parseConfig();
    } catch (e) {
      // Use default values if remote config fails
      debugPrint('RemoteConfigService: Failed to fetch remote config: $e');
      _parseConfig();
    }
  }

  void _parseConfig() {
    try {
      final configString = _remoteConfig.getString('app_config');
      if (configString.isNotEmpty) {
        final config = jsonDecode(configString) as Map<String, dynamic>;

        _environment = config['environment'] as String? ?? 'testing';

        final envConfig = config[_environment] as Map<String, dynamic>?;
        if (envConfig != null) {
          _apiBaseUrlApp1 =
              envConfig['api_base_url_app1'] as String? ?? _apiBaseUrlApp1;
        }
      }
    } catch (e) {
      debugPrint('RemoteConfigService: Failed to parse config: $e');
    }

    debugPrint('RemoteConfigService: Environment=$_environment');
    debugPrint('RemoteConfigService: API Base URL App1=$_apiBaseUrlApp1');
  }

  // Force refresh the config (useful for debugging or manual refresh)
  Future<void> refresh() async {
    try {
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: Duration.zero,
        ),
      );
      await _remoteConfig.fetchAndActivate();
      _parseConfig();
    } catch (e) {
      debugPrint('RemoteConfigService: Failed to refresh config: $e');
    }
  }
}
