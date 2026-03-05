// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/Features/Login/view/login_screen.dart';
import 'package:smarthealth_hcp/Features/ResetPassword/model/reset_pass_request.dart';
import 'package:smarthealth_hcp/Features/ResetPassword/view_model/reset_password_view_model.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/texts_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';

class ResetPwdScreen extends StatefulWidget {
  static String route = "/ResetPasswordScreen";
  final String? phone;
  const ResetPwdScreen({Key? key, this.phone}) : super(key: key);

  @override
  ResetPwdScreenState createState() => ResetPwdScreenState();
}

class ResetPwdScreenState extends State<ResetPwdScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController newPwdController = TextEditingController();
  bool isObsecurePass = true;
  bool isObsecureCPass = true;

  bool isLoading = false;

  callResetPasswordApi(ResetPassRequest resetPassRequest) {
    final resetPassViewModel = context.read<ResetPassViewModel>();

    setState(() {
      isLoading = true;
    });
    resetPassViewModel.resetPassword(resetPassRequest).then((value) {
      if (resetPassViewModel.userError.success != null) {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          resetPassViewModel.userError.message.toString(),
          context,
        );
      } else if (resetPassViewModel.resetpassResponse.success == API_SUCCESS) {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          resetPassViewModel.resetpassResponse.message.toString(),
          context,
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
        // Navigator.pushNamedAndRemoveUntil(
        //     context, LoginScreen.route, (route) => false);
      } else if (resetPassViewModel.resetpassResponse.success == API_FAIL) {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          resetPassViewModel.resetpassResponse.message.toString(),
          context,
        );
      }
    });
  }

  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                  child: Form(
                    key: formGlobalKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.resetpassword,
                          style: appTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            // color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        Text(
                          resetPwdSubTitle,
                          textAlign: TextAlign.left,
                          style: appTextStyle.copyWith(
                            color: grey,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 35.0),
                        TextFormField(
                          obscureText: isObsecurePass,
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
                          },
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              context,
                            )!.enter_password,
                            suffixIcon: IconButton(
                              onPressed: () {
                                isObsecurePass = !isObsecurePass;
                                setState(() {});
                              },
                              icon: Icon(
                                isObsecurePass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: themeBlueColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: themeBlueColor,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 30.0),
                        TextFormField(
                          obscureText: isObsecureCPass,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(
                                context,
                              )!.please_enter_cpassword;
                            } else if (passwordController.text !=
                                newPwdController.text) {
                              return AppLocalizations.of(
                                context,
                              )!.both_password_must_be_same;
                            }
                          },
                          controller: newPwdController,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(
                              context,
                            )!.enter_cpassword,
                            suffixIcon: IconButton(
                              onPressed: () {
                                isObsecureCPass = !isObsecureCPass;
                                setState(() {});
                              },
                              icon: Icon(
                                isObsecureCPass
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: themeBlueColor,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.grey),
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
                        const SizedBox(height: 20.0),
                        const Spacer(),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (formGlobalKey.currentState!.validate()) {
                                ResetPassRequest resetPassRequest =
                                    ResetPassRequest(
                                      username: widget.phone,
                                      password: passwordController.text,
                                      password_confirmation:
                                          newPwdController.text,
                                    );
                                callResetPasswordApi(resetPassRequest);
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
                              AppLocalizations.of(context)!.save,
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
