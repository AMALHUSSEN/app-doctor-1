// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/Features/Login/model/LoginResponse/login_response.dart';
import 'package:smarthealth_hcp/Features/Login/view/login_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectConsent/View/projectconsent_screen.dart';
import 'package:smarthealth_hcp/Features/ResetPassword/view/reset_password_screen.dart';
import 'package:smarthealth_hcp/Features/Verificarion/model/RegisterVerificationResponse/register_verification_response.dart';
import 'package:smarthealth_hcp/Features/Verificarion/view_model/verification_view_model.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/intent_const.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';

class VerificationScreen extends StatefulWidget {
  static String route = "/VerificationScreen";
  final String? phone;
  final String? phoneCode;
  final String? from;
  const VerificationScreen({Key? key, this.phone, this.from, this.phoneCode})
    : super(key: key);

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  TextEditingController pinCodeController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController =
      StreamController<ErrorAnimationType>();
  late Timer timer;
  // late String phone;
  // String phoneCode = "+966";
  String verificationCode = "";
  // late String from;
  int start = 30;
  bool isTimeRunning = false;
  String counter = "";
  bool isLoading = false;

  void startTimer() {
    const onesec = Duration(seconds: 1);
    timer = Timer.periodic(onesec, (timer) {
      if (start == 0) {
        setState(() {
          isTimeRunning = false;
          timer.cancel();
        });
      } else {
        setState(() {
          isTimeRunning = true;
          start--;
          if (start < 10) {
            counter = "00:0$start";
          } else {
            counter = "00:$start";
          }
        });
      }
    });
  }

  @override
  void initState() {
    isTimeRunning = true;
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  callVerificationAPI() {
    final verificationViewModel = context.read<VerificationViewModel>();

    if (pinCodeController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      verificationViewModel
          .verifyPhone(
            widget.phone ?? "",
            widget.phoneCode ?? "",
            pinCodeController.text,
          )
          .then((value) {
            if (verificationViewModel.userError.success != null) {
              setState(() {
                isLoading = false;
              });
              CommonWidget.showErrorMessage(
                verificationViewModel.userError.message.toString(),
                context,
              );
            } else if (verificationViewModel.verifyResponse.success ==
                API_SUCCESS) {
              setState(() {
                isLoading = false;
              });
              CommonWidget.showErrorMessage(
                verificationViewModel.verifyResponse.message.toString(),
                context,
              );
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResetPwdScreen(phone: widget.phone),
                ),
              );
            } else if (verificationViewModel.verifyResponse.success ==
                API_FAIL) {
              setState(() {
                isLoading = false;
              });
              CommonWidget.showErrorMessage(
                verificationViewModel.verifyResponse.message.toString(),
                context,
              );
            }
          });
    } else {
      CommonWidget.showErrorMessage(
        AppLocalizations.of(context)!.please_enter_verification_code,
        context,
      );
    }
  }

  callResendOtpAPI() {
    final verificationViewModel = context.read<VerificationViewModel>();

    setState(() {
      isLoading = true;
    });
    verificationViewModel.resendVerification(widget.phone ?? "").then((value) {
      if (verificationViewModel.userError.success != null) {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          verificationViewModel.userError.message.toString(),
          context,
        );
      } else if (verificationViewModel.resendCodeResponse.success ==
          API_SUCCESS) {
        start = 30;
        isTimeRunning = true;
        startTimer();
        CommonWidget.showErrorMessage(
          verificationViewModel.resendCodeResponse.message.toString(),
          context,
        );
        setState(() {
          isLoading = false;
        });
      } else if (verificationViewModel.resendCodeResponse.success == API_FAIL) {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          verificationViewModel.resendCodeResponse.message.toString(),
          context,
        );
      }
    });
  }

  Future callApi(String otp, BuildContext context) async {
    final verificationViewModel = context.read<VerificationViewModel>();

    setState(() {
      isLoading = true;
    });
    var response = verificationViewModel.registerVerification(otp);
    response.then((apiResponse) {
      debugPrint("RESPONSE SCREEN - > $apiResponse");

      RegisterVerificationResponse registerVerificationResponse = apiResponse;

      if (registerVerificationResponse.success == API_SUCCESS) {
        setState(() {
          isLoading = false;
        });
        log(
          "PROJECT_CODE--> ${registerVerificationResponse.result?.data?.projectCode}",
        );
        CommonWidget.showErrorMessage(
          registerVerificationResponse.message.toString(),
          context,
        );
        if (registerVerificationResponse.result?.data?.projectCode == null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProjectConsentScreen(
                projectCode:
                    registerVerificationResponse.result?.data?.projectCode ??
                    "",
                userId:
                    registerVerificationResponse.result?.data?.id.toString() ??
                    "",
              ),
            ),
          );
        }
        // if (widget.from == INTENT_FROM_SIGN_UP) {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => const LoginScreen(),
        //     ),
        //   );
        // }
      } else {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          registerVerificationResponse.message.toString(),
          context,
        );
      }
    });
  }

  Future logincallApi(String otp, BuildContext context) async {
    final verificationViewModel = context.read<VerificationViewModel>();
    setState(() {
      isLoading = true;
    });
    var response = verificationViewModel.loginVerification(otp);
    response.then((apiResponse) {
      debugPrint("RESPONSE SCREEN - > $apiResponse");

      LoginResponse loginResponse = apiResponse;

      if (loginResponse.success == API_SUCCESS) {
        CommonWidget.showErrorMessage(
          loginResponse.message.toString(),
          context,
        );
        if (widget.from == INTENT_FROM_LOGIN) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          loginResponse.message.toString(),
          context,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final argument = ModalRoute.of(context)!.settings.arguments as Map;
    // from = argument[INTENT_FROM];
    // phone = argument[INTENT_PHONE];
    // phoneCode = argument[INTENT_PHONE_CODE];

    debugPrint("PHONE --> ${widget.phone}");
    debugPrint("PHONE_CODE--> ${widget.phoneCode}");
    debugPrint("FROM--> ${widget.from}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        // foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ).copyWith(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.verification,
                        style: appTextStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          // color: Colors.black,
                          fontSize: 30,
                        ),
                      ),
                      const SizedBox(height: 40),
                      Text(
                        AppLocalizations.of(context)!.verificationSubtitle,
                        textAlign: TextAlign.left,
                        style: const TextStyle(color: grey, fontSize: 15),
                      ),
                      const SizedBox(height: 50),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: PinCodeTextField(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          length: 4,
                          obscureText: false,
                          animationType: AnimationType.scale,
                          cursorColor: themeBlueColor,
                          pinTheme: PinTheme(
                            selectedColor: themeBlueColor,
                            inactiveColor: themeBlueColor,
                            errorBorderColor: themeBlueColor,
                            borderWidth: 1.0,
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(5),
                            fieldHeight: 50,
                            fieldWidth: 50,
                            disabledColor: themeBlueColor,
                            activeFillColor: Colors.white,
                          ),
                          keyboardType: TextInputType.number,
                          animationDuration: const Duration(milliseconds: 300),
                          backgroundColor: Colors.transparent,
                          enableActiveFill: false,
                          errorAnimationController: errorController,
                          controller: pinCodeController,
                          enablePinAutofill: true,
                          onCompleted: (value) {
                            verificationCode = value;
                            debugPrint(
                              "VERIFICATION_CODE --> $verificationCode",
                            );
                            if (widget.from == INTENT_FROM_FORGOT_PASSWORD) {
                              callVerificationAPI();
                              debugPrint("RESET_PASSWORD");
                            } else if (widget.from == INTENT_FROM_SIGN_UP) {
                              callApi(value, context);
                              debugPrint("REGISTRATION--");
                            } else {
                              logincallApi(value, context);
                            }
                          },
                          onChanged: (value) {
                            debugPrint(value);
                          },
                          beforeTextPaste: (text) {
                            debugPrint("Allowing to paste $text");
                            return true;
                          },
                          appContext: context,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          counter,
                          textAlign: TextAlign.center,
                          style: appTextStyle.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            callResendOtpAPI();
                          },
                          child: Text(
                            AppLocalizations.of(context)!.resend,
                            style: appTextStyle.copyWith(
                              color: !isTimeRunning
                                  ? themeBlueColor
                                  : Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (widget.from == INTENT_FROM_FORGOT_PASSWORD) {
                              callVerificationAPI();
                              debugPrint("RESET_PASSWORD");
                            } else if (widget.from == INTENT_FROM_SIGN_UP) {
                              callApi(verificationCode, context);
                              debugPrint("REGISTRATION");
                            } else {
                              logincallApi(verificationCode, context);
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all(
                              themeBlueColor,
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.verify,
                            style: appTextStyle.copyWith(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
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
}
