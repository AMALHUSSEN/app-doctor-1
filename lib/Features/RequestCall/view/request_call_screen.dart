import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/Features/RequestCall/view_model/request_call_view_model.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';

class RequestCallScreen extends StatefulWidget {
  static String route = "/RequestCallScreen";
  const RequestCallScreen({Key? key}) : super(key: key);

  @override
  RequestCallScreenState createState() => RequestCallScreenState();
}

class RequestCallScreenState extends State<RequestCallScreen> {
  TextEditingController yourConcernController = TextEditingController();
  bool isLoading = false;
  // late RequestACallViewModel requestACallViewModel;

  // @override
  // void initState() {
  //   requestACallViewModel = context.read<RequestACallViewModel>();
  //   super.initState();
  // }

  requestcallAPI() async {
    final requestACallViewModel = context.read<RequestACallViewModel>();
    setState(() {
      isLoading = true;
    });
    requestACallViewModel.requestACall(yourConcernController.text).then((
      value,
    ) {
      if (requestACallViewModel.userError.success != null) {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          requestACallViewModel.userError.message.toString(),
          context,
        );
      } else if (requestACallViewModel.requestCallResponse.success ==
          API_SUCCESS) {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          requestACallViewModel.requestCallResponse.message.toString(),
          context,
        );
      } else if (requestACallViewModel.requestCallResponse.success ==
          API_FAIL) {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          requestACallViewModel.requestCallResponse.message.toString(),
          context,
        );
      }
    });
  }

  void submitBtnClicked() {
    debugPrint('Submit button pressed');
    if (yourConcernController.text != '') {
      requestcallAPI();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            },
            icon: Image.asset('assets/images/icon_home.png'),
          ),
        ],
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
                  ).copyWith(bottom: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.requestacall,
                        style: appTextStyle.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Text(
                        AppLocalizations.of(context)!.yourconcern,
                        style: appTextStyle.copyWith(
                          color: themeBlueColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(
                              context,
                            )!.please_enter_your_concern;
                          }
                          return null;
                        },
                        controller: yourConcernController,
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(
                            context,
                          )!.enter_your_concern_here,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: themeBlueColor),
                          ),
                        ),
                        textCapitalization: TextCapitalization.sentences,
                      ),
                      const Spacer(),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            submitBtnClicked();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              themeBlueColor,
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.submit,
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
