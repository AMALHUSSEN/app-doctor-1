import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/Features/ConsentForm/view_model/consentform_view_model.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';

class ConsentScreen extends StatefulWidget {
  static String route = "/ConsentScreen";
  const ConsentScreen({Key? key}) : super(key: key);

  @override
  State<ConsentScreen> createState() => _ConsentScreenState();
}

class _ConsentScreenState extends State<ConsentScreen> {
  ConsentFormViewModel consentFormViewModel = ConsentFormViewModel();
  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    if (isFirstTime) {
      consentFormViewModel = context.watch<ConsentFormViewModel>();
      consentFormViewModel.getConsentFormResponse();
      isFirstTime = false;
    }
    return Stack(
      children: [
        Scaffold(
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    AppLocalizations.of(context)!.consent_form,
                    style: appTextStyle.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  HtmlWidget(
                    consentFormViewModel.consentFormData.content ?? "",
                    textStyle: appTextStyle.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                ],
              ),
            ),
          ),
        ),
        if (consentFormViewModel.loading) const AppLoading(),
      ],
    );
  }
}
