// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'dart:convert';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthealth_hcp/Features/CMSPage/view/cmspage_screen.dart';
import 'package:smarthealth_hcp/Features/CMSPage/view_model/cms_view_model.dart';
import 'package:smarthealth_hcp/Features/ConsentForm/view_model/consentform_view_model.dart';
import 'package:smarthealth_hcp/Features/ForgotPassword/viewmodel/forgot_password_viewmodel.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view_model/home_screen_view_model.dart';
import 'package:smarthealth_hcp/Features/Login/view/login_screen.dart';
import 'package:smarthealth_hcp/Features/Login/viewmodel/login_viewmodel.dart';
import 'package:smarthealth_hcp/Features/MyList/Viewmodel/my_list_viewmodel.dart';
import 'package:smarthealth_hcp/Features/MyList/view/my_list_screen.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/view_model/patient_details_screen_view_model.dart';
import 'package:smarthealth_hcp/Features/ProjectConsent/ViewModel/projectconsent_viewmodel.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view_model/select_project_view_model.dart';
import 'package:smarthealth_hcp/Features/Registration/view_model/register_view_model.dart';
import 'package:smarthealth_hcp/Features/RequestCall/view_model/request_call_view_model.dart';
import 'package:smarthealth_hcp/Features/ResetPassword/view_model/reset_password_view_model.dart';
import 'package:smarthealth_hcp/Features/ThemeProvider/theme_provider.dart';
import 'package:smarthealth_hcp/Features/ValidateVoucher/view_model/validate_voucher_view_model.dart';
import 'package:smarthealth_hcp/Features/Verificarion/view_model/verification_view_model.dart';
import 'package:smarthealth_hcp/Features/new_consent_upload/view_model/new_consent_view_model.dart';
import 'package:smarthealth_hcp/LocalizationProvider/locale_provider.dart';
import 'package:smarthealth_hcp/constants/firebase_const.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';
import 'package:smarthealth_hcp/firebase_options.dart';
import 'package:smarthealth_hcp/services/remote_config_service.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
}

AndroidNotificationChannel? channel;
FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
// late FirebaseMessaging messaging;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Remote Config for environment-based API configuration
  await RemoteConfigService().initialize();

  HttpOverrides.global = MyHttpOverrides();
  Shared.pref = await SharedPreferences.getInstance();
  final messaging = FBMessaging.messaging;
  // final fcmToken = await messaging.getToken();
  // Shared.pref.setString(PREF_FCM_TOKEN, fcmToken!);
  channel = const AndroidNotificationChannel(
    'flutter_notification', // id
    'flutter_notification_title', // title
    description: 'flutter_notification_description', // description
    importance: Importance.high,
    enableLights: true,
    enableVibration: true,
    showBadge: true,
    playSound: true,
  );
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  await flutterLocalNotificationsPlugin
      ?.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >()
      ?.createNotificationChannel(channel!);
  await messaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  RemoteMessage? remoteMessage;
  @override
  void initState() {
    super.initState();

    AndroidInitializationSettings android = const AndroidInitializationSettings(
      '@mipmap/app_icon',
    );
    DarwinInitializationSettings iOS = const DarwinInitializationSettings(
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
    );

    final initSettings = InitializationSettings(android: android, iOS: iOS);
    flutterLocalNotificationsPlugin?.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (payload) async {
        debugPrint("OPEN_APP_NAVIGATE_PAYLOAD->${payload.payload.toString()}");
        Map map = jsonDecode(payload.payload.toString());
        debugPrint("PAYLOAD--> $map");
        if (map["type"] == "registration") {
          navigatorKey.currentState?.push(
            MaterialPageRoute(builder: (context) => const MyListScreen()),
          );
        }
      },
    );

    FirebaseMessaging.onMessage.listen((message) async {
      RemoteNotification notification = message.notification!;
      AndroidNotification? android = message.notification?.android;
      // AppleNotification? appleNotification = message.notification?.apple;
      debugPrint("onMessage -->$message");
      debugPrint("onMessage -->${message.data['type']}");
      if (notification != null && android != null) {
        String action = jsonEncode(message.data);
        // Map map = jsonDecode(action);
        debugPrint("MESSAGE_DATA --> $action");
        _navigateToScreen(message);
        flutterLocalNotificationsPlugin!.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel!.id,
              channel!.name,
              channelDescription: channel?.description,
              // priority: Priority.high,
              importance: Importance.max,
              setAsGroupSummary: true,
              styleInformation: const DefaultStyleInformation(true, true),
              largeIcon: const DrawableResourceAndroidBitmap(
                '@mipmap/app_icon',
              ),
              channelShowBadge: true,
              autoCancel: true,
              icon: '@mipmap/app_icon',
            ),
          ),
          // payload: action
          payload: action,
        );
      }
    });
    FBMessaging.messaging.getInitialMessage().then((message) {
      debugPrint("getInitialMessage Message Data--> $message");
      if (message != null) {
        debugPrint("getInitialMessage Message Data--> ${message.data}");
        var data = message.data.entries.toList();
        debugPrint("getInitialMessage  DATA--> $data");
        _navigateToScreen(message);
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint("onMessageOpenedApp  Message Data--> ${message.data}");
      debugPrint("onMessageOpenedApp Message--> $message");
      _navigateToScreen(message);
    });
  }

  _navigateToScreen(RemoteMessage message) {
    log("TYPE---> ${message.data["type"]}");
    if (message.data["type"] == "registration") {
      navigatorKey.currentState?.push(
        MaterialPageRoute(builder: (context) => const MyListScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => RegisterViewModel()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => VerificationViewModel()),
        ChangeNotifierProvider(create: (_) => ForgotpassViewModel()),
        ChangeNotifierProvider(create: (_) => ResetPassViewModel()),
        ChangeNotifierProvider(create: (_) => HomeScreenViewModel()),
        ChangeNotifierProvider(create: (_) => SelectProjectViewModel()),
        ChangeNotifierProvider(create: (_) => PatientdetailsViewModel()),
        ChangeNotifierProvider(create: (_) => MyListViewModel()),
        ChangeNotifierProvider(create: (_) => ConsentFormViewModel()),
        ChangeNotifierProvider(create: (_) => ProjectConsentViewModel()),
        ChangeNotifierProvider(create: (_) => RequestACallViewModel()),
        ChangeNotifierProvider(create: (_) => ValidateVoucherViewModel()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => CMSPageViewModel()),
        ChangeNotifierProvider(create: (_) => NewConsentFileViewModel()),
      ],
      child: Builder(
        builder: (context) {
          final provider = Provider.of<LocaleProvider>(context);

          Shared.pref.setString(
            PREF_CURRENT_LANGUAGE,
            provider.locale.toString(),
          );
          debugPrint(
            "CURRENT_LANGUAGE --> ${Shared.pref.getString(PREF_CURRENT_LANGUAGE)}",
          );

          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Smart Health',
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.system,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routes: {CMSPageScreen.route: (context) => const CMSPageScreen()},
            home: Shared.pref.getBool(PREF_IS_LOGGED_IN) == true
                ? const HomeScreen()
                : const LoginScreen(),
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
