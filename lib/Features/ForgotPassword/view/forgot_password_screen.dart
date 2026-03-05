import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/Features/ForgotPassword/viewmodel/forgot_password_viewmodel.dart';
import 'package:smarthealth_hcp/Features/Verificarion/view/verification_screen.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/intent_const.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/texts_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';

class ForgotPasswordScreen extends StatefulWidget {
  static String route = "/ForgotPasswordScreen";
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController mobileController = TextEditingController();
  String phoneCode = '+966';
  late String phone;
  bool isPhoneEmpty = false;
  bool isLoading = false;
  FocusNode phoneFocusnode = FocusNode();
  TextEditingController phoneController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  callForgotPassApi() {
    final forgotpassViewModel = context.read<ForgotpassViewModel>();

    if (formGlobalKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      forgotpassViewModel.doForgotPassword(mobileController.text, phoneCode).then((
        value,
      ) {
        isLoading = false;
        setState(() {});
        if (forgotpassViewModel.userError.success != null) {
          CommonWidget.showErrorMessage(
            forgotpassViewModel.userError.message.toString(),
            context,
          );
        } else if (forgotpassViewModel.forgotpassResponse.success ==
            API_SUCCESS) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VerificationScreen(
                from: INTENT_FROM_FORGOT_PASSWORD,
                phone: mobileController.text,
                phoneCode: phoneCode,
              ),
            ),
          );
          // Navigator.pushNamed(context, VerificationScreen.route, arguments: {
          //   INTENT_FROM: INTENT_FROM_FORGOT_PASSWORD,
          //   INTENT_PHONE: mobileController.text,
          //   INTENT_PHONE_CODE: phoneCode
          // });
        } else if (forgotpassViewModel.forgotpassResponse.success == API_FAIL) {
          debugPrint(
            "RESPONSE_ERRROR -> ${forgotpassViewModel.forgotpassResponse.message}",
          );
          CommonWidget.showErrorMessage(
            forgotpassViewModel.forgotpassResponse.message.toString(),
            context,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0),
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
                          AppLocalizations.of(context)!.forgotpassword,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            // color: Colors.black,
                            fontSize: 30,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          AppLocalizations.of(context)!.forgotpwdsubtitle,
                          textAlign: TextAlign.left,
                          style: appTextStyle.copyWith(
                            color: grey,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 30),
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
                                  suffixIcon: const Icon(Icons.arrow_drop_down),
                                  prefixIcon: CountryCodePicker(
                                    dialogBackgroundColor: Theme.of(
                                      context,
                                    ).colorScheme.background,
                                    showFlag: false,
                                    initialSelection: phoneCode,
                                    onChanged: (value) {
                                      debugPrint(value.dialCode);
                                      phoneCode = value.dialCode!;
                                      debugPrint("CODE--> $phoneCode");
                                    },
                                    dialogSize: Size(
                                      MediaQuery.of(context).size.width * 0.8,
                                      MediaQuery.of(context).size.height * 0.8,
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 80),
                        const Spacer(),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              // confirmBtnCalled();
                              FocusScope.of(context).unfocus();
                              callForgotPassApi();
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
                              AppLocalizations.of(context)!.confirm,
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
