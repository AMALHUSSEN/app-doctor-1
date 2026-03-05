import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/Features/CMSPage/view_model/cms_view_model.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/intent_const.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';

class CMSPageScreen extends StatefulWidget {
  static String route = "/CMSPageScreen";
  const CMSPageScreen({Key? key}) : super(key: key);

  @override
  State<CMSPageScreen> createState() => _CMSPageScreenState();
}

class _CMSPageScreenState extends State<CMSPageScreen> {
  bool isFirstTime = true;

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments as Map;
    final cmsPageViewModel = context.watch<CMSPageViewModel>();

    if (isFirstTime) {
      if (argument[INTENT_CMS_PAGE] == INTENT_TERMS_CONDITION) {
        cmsPageViewModel.getCMSResponse(INTENT_TERMS_CONDITION);
      } else if (argument[INTENT_CMS_PAGE] == INTENT_COOKIES_POLICY) {
        cmsPageViewModel.getCMSResponse(INTENT_COOKIES_POLICY);
      } else {
        cmsPageViewModel.getCMSResponse(INTENT_PRIVACY_POLICY);
      }
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
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                          (route) => false);
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
                    cmsPageViewModel.cmsData.title ?? "",
                    style: appTextStyle.copyWith(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  HtmlWidget(
                    cmsPageViewModel.cmsData.content ?? "",
                    textStyle: appTextStyle.copyWith(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (cmsPageViewModel.loading) const AppLoading(),
      ],
    );
  }
}
