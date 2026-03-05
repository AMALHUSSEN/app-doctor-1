import 'dart:developer';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:smarthealth_hcp/utils/platform_utils.dart';
import 'package:flutter/material.dart';
import 'package:new_version_plus/new_version_plus.dart';
import 'package:open_store/open_store.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/Features/ForgotPassword/view/forgot_password_screen.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/Features/Login/model/LoginResponse/login_response.dart';
import 'package:smarthealth_hcp/Features/Login/viewmodel/login_viewmodel.dart';
import 'package:smarthealth_hcp/Features/Registration/view/registration_screen.dart';
import 'package:smarthealth_hcp/Features/Verificarion/view/verification_screen.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/firebase_const.dart';
import 'package:smarthealth_hcp/constants/intent_const.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/texts_consts.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  String phoneCode = '+966';
  bool? isLoading = false;
  bool isObsecure = true;
  final formGlobalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (PlatformUtils.isIOS) {
      FBMessaging.messaging.requestPermission(
        announcement: false,
        carPlay: false,
        criticalAlert: false,
      );
    }
    if (!PlatformUtils.isWeb) checkAppVersion();
  }

  checkAppVersion() {
    final loginViewModel = context.read<LoginViewModel>();
    loginViewModel.checkAppVersion().then((value) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      final currentVersion = int.parse(packageInfo.version.split(".").join());
      log("CURRENT_VERSION-> $currentVersion");

      final latestVersion = int.parse(
        loginViewModel.appVersionData.version?.split(".").join() ?? "0.0.0",
      );
      log("LATEST_VERSION-> $latestVersion");

      final newVersionPlus = NewVersionPlus(
        iOSId: packageInfo.packageName,
        androidId: packageInfo.packageName,
      );
      final VersionStatus? status = await newVersionPlus.getVersionStatus();
      if (status != null && status.canUpdate) {
        await showModalBottomSheet(
          context: context,
          isDismissible: false,
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context)!.new_app_version,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40.0),
                  Image.asset(
                    "assets/images/securityIcon.png",
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    AppLocalizations.of(context)!.for_better_use,
                    style: TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40.0),
                  GestureDetector(
                    onTap: () async {
                      OpenStore.instance.open(
                        appStoreId: "1584980228",
                        androidAppBundleId: "com.rsnmed.smarthealth",
                      );
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: themeBlueColor,
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context)!.update_now,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            );
          },
        );
      } else {
        log("DON'T SHOW_UPDATE_DIALOG");
      }
    });
  }

  Future<void> getFcmToken() async {
    final fcmToken = await FBMessaging.messaging.getToken();
    Shared.pref.setString(PREF_FCM_TOKEN, fcmToken!);
    log("FCM_TOKEN-> $fcmToken");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 70),
                          Image.asset('assets/images/icon_logo.png', scale: 25),
                          const SizedBox(height: 50),
                          Text(
                            AppLocalizations.of(context)!.welcomeback,
                            style: appTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              // color: Colors.black,
                              fontSize: 30,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            AppLocalizations.of(context)!.welcometosmarthealth,
                            textAlign: TextAlign.left,
                            style: const TextStyle(color: grey, fontSize: 15),
                          ),
                          const SizedBox(height: 30),
                          Form(
                            key: formGlobalKey,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 95,
                                      child: TextFormField(
                                        readOnly: true,
                                        validator: (value) {
                                          if (mobileController.text.isEmpty) {
                                            return "";
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          suffixIcon: const Icon(
                                            Icons.arrow_drop_down,
                                          ),
                                          prefixIcon: CountryCodePicker(
                                            dialogBackgroundColor: Theme.of(
                                              context,
                                            ).colorScheme.surface,
                                            showFlag: false,
                                            initialSelection: phoneCode,
                                            onChanged: (value) {
                                              debugPrint(value.dialCode);
                                              phoneCode = value.dialCode!;
                                            },
                                            dialogSize: Size(
                                              MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.8,
                                              MediaQuery.of(
                                                    context,
                                                  ).size.height *
                                                  0.8,
                                            ),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (mobileController.text.isEmpty) {
                                            return AppLocalizations.of(
                                              context,
                                            )!.please_enter_mobile_number;
                                          }
                                          return null;
                                        },
                                        controller: mobileController,
                                        maxLines: 1,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          labelText: hintEnterMobile,
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            borderSide: const BorderSide(
                                              color: Colors.grey,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            borderSide: const BorderSide(
                                              color: themeBlueColor,
                                            ),
                                          ),
                                        ),
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                TextFormField(
                                  obscureText: isObsecure,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.please_enter_password;
                                    } else if (value.length <= 4) {
                                      return AppLocalizations.of(
                                        context,
                                      )!.please_enter_atlist_digit_passwor;
                                    }
                                    return null;
                                  },
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    labelText: hintEnterPassword,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        isObsecure = !isObsecure;
                                        setState(() {});
                                      },
                                      icon: Icon(
                                        isObsecure
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: themeBlueColor,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: themeBlueColor,
                                      ),
                                    ),
                                  ),
                                  textInputAction: TextInputAction.done,
                                ),
                                const SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ForgotPasswordScreen(),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      )!.forgotpassword,
                                      textAlign: TextAlign.right,
                                      style: appTextStyle.copyWith(
                                        color: themeBlueColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            getFcmToken().then((value) => callLoginApi());
                          },
                          style: ButtonStyle(
                            shape: WidgetStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            backgroundColor: WidgetStateProperty.all(
                              themeBlueColor,
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.confirm,
                            style: appTextStyle.copyWith(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            // DONT_HAVE_ACCOUNT,
                            AppLocalizations.of(context)!.dont_have_account,
                            style: appTextStyle.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const RegistrationScreen(),
                                ),
                              );
                            },
                            child: Text(
                              // REGISTER_NOW,
                              AppLocalizations.of(context)!.register_now,
                              style: appTextStyle.copyWith(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: themeBlueColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isLoading == true) const AppLoading(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  callLoginApi() {
    final loginViewModel = context.read<LoginViewModel>();
    if (formGlobalKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      loginViewModel
          .doLogin(phoneCode, mobileController.text, passwordController.text)
          .then((value) {
            if (loginViewModel.userError.success != null) {
              isLoading = false;
              CommonWidget.showErrorMessage(
                loginViewModel.userError.message.toString(),
                context,
              );
              setState(() {});
            } else if (loginViewModel.loginResponse.success == API_SUCCESS) {
              isLoading = false;
              debugPrint("API_SUCCESS");
              if (loginViewModel.loginResponse.result?.data?.verificationCode ==
                  null) {
                saveUserPref(loginViewModel.loginResponse).whenComplete(() {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                    (route) => false,
                  );
                  // Navigator.pushNamedAndRemoveUntil(
                  //     context, HomeScreen.route, (route) => false);
                });
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerificationScreen(
                      from: INTENT_FROM_LOGIN,
                      phone: mobileController.text.toString(),
                      phoneCode: phoneCode,
                    ),
                  ),
                );

                // Navigator.pushNamed(
                //   context,
                //   VerificationScreen.route,
                //   arguments: {
                //     INTENT_FROM: INTENT_FROM_LOGIN,
                //     INTENT_PHONE: mobileController.text.toString(),
                //     INTENT_PHONE_CODE: phoneCode,
                //   },
                // );
              }

              setState(() {});
            } else if (loginViewModel.loginResponse.success == API_FAIL) {
              isLoading = false;
              debugPrint("API_FAIL");
              CommonWidget.showErrorMessage(
                loginViewModel.loginResponse.message.toString(),
                context,
              );

              setState(() {});
            } else if (loginViewModel.loginResponse.success == API_UNVERIFIED) {
              setState(() {
                isLoading = false;
              });
              CommonWidget.showErrorMessage(
                loginViewModel.loginResponse.message.toString(),
                context,
              );
            }
          });
    }
  }

  // void navigationPerform() {
  //   final loginViewModel = context.read<LoginViewModel>();
  //   debugPrint("NAVIGATION");
  //   if (loginViewModel.loginResponse.result!.data!.verificationCode == null) {
  //     debugPrint("HOME_SCREEN");
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //           builder: (context) => const HomeScreen(),
  //         ),
  //         (route) => false);
  //     // Navigator.pushNamedAndRemoveUntil(
  //     //     context, HomeScreen.route, (route) => false);
  //   } else if (loginViewModel.loginResponse.result!.data!.verificationCode !=
  //       null) {
  //     debugPrint("VERIFICATION_SCREEN");
  //     Navigator.pushNamedAndRemoveUntil(
  //       context,
  //       VerificationScreen.route,
  //       (route) => false,
  //       arguments: {
  //         INTENT_FROM: INTENT_FROM_LOGIN,
  //         INTENT_PHONE: mobileController.text.toString(),
  //         INTENT_PHONE_CODE: phoneCode,
  //       },
  //     );
  //   } else {
  //     debugPrint("NAVIGATION_DECLINED");
  //   }
  // }

  saveUserPref(LoginResponse loginActivityModel) async {
    String token = loginActivityModel.token.toString();
    debugPrint('Token is ... $token');
    if (token != 'null') {
      Shared.pref.setString(
        PREF_USER_ACCESS_TOKEN,
        loginActivityModel.token.toString(),
      );
    }
    Shared.pref.setBool(PREF_IS_LOGGED_IN, true);
    Shared.pref.setInt(PREF_USER_ID, loginActivityModel.result!.data!.id!);
    Shared.pref.setString(
      PREF_USER_NAME,
      loginActivityModel.result!.data!.name.toString(),
    );
    Shared.pref.setString(
      PREF_USER_EMAIL,
      loginActivityModel.result!.data!.email.toString(),
    );
    Shared.pref.setString(
      PREF_USER_PHONE,
      loginActivityModel.result!.data!.phone.toString(),
    );
    Shared.pref.setString(
      PREF_USER_LAST_NAME,
      loginActivityModel.result!.data!.lastName.toString(),
    );
    Shared.pref.setString(
      PREF_USER_COUNTRY,
      loginActivityModel.result!.data!.country.toString(),
    );
    Shared.pref.setString(
      PREF_USER_CITY,
      loginActivityModel.result!.data!.city.toString(),
    );
    Shared.pref.setString(
      PREF_USER_HOSPITAL_NAME,
      loginActivityModel.result!.data!.hospitalName.toString(),
    );
    Shared.pref.setString(
      PREF_USER_SPECIALITY,
      loginActivityModel.result!.data!.speciality.toString(),
    );
    Shared.pref.setString(
      USER_STATUS,
      loginActivityModel.result!.data!.status.toString(),
    );
  }
}
