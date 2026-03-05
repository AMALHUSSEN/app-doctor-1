import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:smarthealth_hcp/utils/platform_utils.dart';
import 'package:flutter/material.dart';
import 'package:open_store/open_store.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/Features/CMSPage/view/cmspage_screen.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/model/app_setting_response/data.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view_model/home_screen_view_model.dart';
import 'package:smarthealth_hcp/Features/License/view/license_screen.dart';
import 'package:smarthealth_hcp/Features/License/view_model/license_view_model.dart';
import 'package:smarthealth_hcp/Features/Login/view/login_screen.dart';
import 'package:smarthealth_hcp/Features/MyList/view/my_list_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/select_project_screen.dart';
import 'package:smarthealth_hcp/Features/RequestCall/view_model/request_call_view_model.dart';
import 'package:smarthealth_hcp/Features/ValidateVoucher/view/validate_voucher_screen.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/intent_const.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static String route = "/HomeScreen";

  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  bool disableRedeemVoucher = true;
  bool disableRequestCall = true;

  late HomeScreenViewModel homeScreenViewModel;
  late LicenseViewModel licenseViewModel;
  late AppSettingData appSettingData;

  callHomeScreenAPI() {
    isLoading = true;

    homeScreenViewModel.homescreenAPI().then((value) {
      if (homeScreenViewModel.userError.success != null) {
        CommonWidget.showErrorMessage(
          homeScreenViewModel.userError.message.toString(),
          context,
        );
      } else if (homeScreenViewModel.homescreenResponse.success ==
          API_SUCCESS) {
        isLoading = false;
        disableRedeemVoucher =
            homeScreenViewModel
                .homescreenResponse
                .result
                ?.data
                ?.disableRedeemVoucher ??
            true;
        disableRequestCall =
            homeScreenViewModel
                .homescreenResponse
                .result
                ?.data
                ?.disableRequestCall ??
            true;
        setState(() {});
      } else if (homeScreenViewModel.homescreenResponse.success == API_FAIL) {
        debugPrint(
          "RESPONSE_ERRROR -> ${homeScreenViewModel.homescreenResponse.message}",
        );
        CommonWidget.showErrorMessage(
          homeScreenViewModel.homescreenResponse.message.toString(),
          context,
        );
      }
    });
  }

  callLogoutApi() {
    setState(() {
      isLoading = true;
      debugPrint("LOADING --> $isLoading");
    });
    homeScreenViewModel.logoutApi().then((value) {
      Shared.pref.clear();
      setState(() {
        isLoading = false;
        debugPrint("LOADING___ --> $isLoading");
      });
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    });
  }

  callAppSettingAPI() {
    isLoading = true;

    homeScreenViewModel.appSettingApi().then((value) {
      if (homeScreenViewModel.userError.success != null) {
        CommonWidget.showErrorMessage(
          homeScreenViewModel.userError.message.toString(),
          context,
        );
      } else if (homeScreenViewModel.appSettingResponse.success ==
          API_SUCCESS) {
        isLoading = false;
        debugPrint("API_SUCCESS");
        setState(() {});
      } else if (homeScreenViewModel.appSettingResponse.success == API_FAIL) {
        debugPrint(
          "RESPONSE_ERRROR -> ${homeScreenViewModel.appSettingResponse.message}",
        );
        CommonWidget.showErrorMessage(
          homeScreenViewModel.appSettingResponse.message.toString(),
          context,
        );
      }
    });
  }

  @override
  void initState() {
    homeScreenViewModel = context.read<HomeScreenViewModel>();
    licenseViewModel = context.read<LicenseViewModel>();

    licenseViewModel.getLicenses().then((_) {
      if (mounted) setState(() {});
    });

    homeScreenViewModel.getBlockProjects();
    if (!PlatformUtils.isWeb) homeScreenViewModel.checkAppVersion().then((value) async {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      if (packageInfo.version == homeScreenViewModel.appVersionData.version) {
      } else {
        showModalBottomSheet(
          context: context,
          isDismissible: false,
          // Set to false to make bottom sheet non-dismissable
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () async {
                //
                OpenStore.instance.open(
                  appStoreId: "1584980228",
                  androidAppBundleId: "com.rsnmed.smarthealth",
                );
                // await launchUrl(Uri.parse('https://apps.apple.com/us/app/smarthealth-hcp/id1584980228'));
              },
              child: Container(
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
                    Container(
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
                    SizedBox(height: 20.0),
                  ],
                ),
              ),
            );
          },
        );
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callHomeScreenAPI();
      callAppSettingAPI();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image.asset(
                  //   'assets/images/icon_logo.png',
                  //   scale: 30,
                  // ),
                  const SizedBox(height: 40.0),
                  if (isLoading == false)
                    if (homeScreenViewModel.appSettingData.logoUrl != "")
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Image.network(
                            homeScreenViewModel.appSettingData.logoUrl ?? '',
                            scale: 30,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return PlatformUtils.isAndroid
                                    ? const Center(
                                        child: CircularProgressIndicator(
                                          color: themeBlueColor,
                                        ),
                                      )
                                    : const Center(
                                        child: CupertinoActivityIndicator(
                                          radius: 18,
                                          color: themeBlueColor,
                                        ),
                                      );
                              }
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: Theme.of(context).cardColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  title: Text(
                                    AppLocalizations.of(context)!.smarthealth,
                                    style: appTextStyle.copyWith(
                                      color: themeBlueColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  content: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.are_you_sure_you_want_to_logout,
                                    style: appTextStyle.copyWith(
                                      color: Colors.grey,
                                      fontSize: 17,
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.cancel,
                                        style: appTextStyle.copyWith(
                                          color: themeBlueColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        callLogoutApi();
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.ok,
                                        style: appTextStyle.copyWith(
                                          color: themeBlueColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: ImageIcon(
                              AssetImage('assets/images/icon_logout.png'),
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                  const SizedBox(height: 10),
                  Text(
                    homeScreenViewModel.appSettingData.welcomeTitle ?? "",
                    // AppLocalizations.of(context)!.welcometosmarthealth,
                    style: appTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      // color: Colors.black,
                      fontSize: 33,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    homeScreenViewModel.appSettingData.tagline ?? "",
                    // AppLocalizations.of(context)!.homescreensubtitle,
                    textAlign: TextAlign.left,
                    style: appTextStyle.copyWith(color: grey, fontSize: 15),
                  ),
                  // License expiry warning banner
                  if (licenseViewModel.hasExpiringLicense())
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LicenseScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: orangeColor, width: 1),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.warning_amber_rounded,
                                  color: orangeColor, size: 24),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  '${AppLocalizations.of(context)!.license_expiring_soon} ${licenseViewModel.getExpiringLicense()?.projectName ?? ''} - ${licenseViewModel.getExpiringLicense()?.daysRemaining ?? 0} ${AppLocalizations.of(context)!.license_days_remaining}',
                                  style: appTextStyle.copyWith(
                                    fontSize: 13,
                                    color: orangeColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              const Icon(Icons.chevron_right,
                                  color: orangeColor, size: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(height: 50),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 200,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const SelectProjectScreen(),
                                ),
                              );
                            },
                            child: Card(
                              color: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 15.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Image.asset(
                                        'assets/images/icon_register.png',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      AppLocalizations.of(context)!.new_request,
                                      style: appTextStyle.copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyListScreen(),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 200,
                            child: Card(
                              color: Theme.of(context).cardColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                  vertical: 15.0,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      width: 40,
                                      child: Image.asset(
                                        'assets/images/icon_mylist.png',
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      AppLocalizations.of(context)!.my_list,
                                      style: appTextStyle.copyWith(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  // License card
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LicenseScreen(),
                        ),
                      );
                    },
                    child: Card(
                      color: Theme.of(context).cardColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 15.0,
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 40,
                              width: 30,
                              child: Icon(Icons.verified_user,
                                  color: themeBlueColor, size: 30),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              AppLocalizations.of(context)!.licenses,
                              style: appTextStyle.copyWith(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  disableRequestCall != true
                      ? GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return CupertinoAlertDialog(
                                  title: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.request_support,
                                  ),
                                  content: Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.are_you_sure_you_want_to_submit_technical_issue_request,
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        requestCallAPI();
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.yes,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.no,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );

                            /* Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RequestCallScreen(),
                        ),
                      );*/
                          },
                          child: Card(
                            color: Theme.of(context).cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 15.0,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 30,
                                    child: Image.asset(
                                      'assets/images/icon_call.png',
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.technical_issue,
                                    style: appTextStyle.copyWith(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  disableRequestCall != true
                      ? const SizedBox(height: 10)
                      : const SizedBox(),
                  disableRedeemVoucher != true
                      ? GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ValidateVoucherScreen(),
                              ),
                            );
                          },
                          child: Card(
                            color: Theme.of(context).cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 15.0,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    height: 40,
                                    width: 30,
                                    child: Image.asset(
                                      'assets/images/icon_lab.png',
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    AppLocalizations.of(
                                      context,
                                    )!.validate_voucher,
                                    style: appTextStyle.copyWith(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                  disableRedeemVoucher != true
                      ? const SizedBox(height: 10)
                      : const SizedBox(),
                  // Privacy Policy, Terms & Conditions, Cookies Policy tabs
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              CMSPageScreen.route,
                              arguments: {INTENT_CMS_PAGE: INTENT_PRIVACY_POLICY},
                            );
                          },
                          child: Card(
                            color: Theme.of(context).cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 15.0,
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.privacy_tip_outlined,
                                      color: themeBlueColor, size: 30),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context)!.privacy_policy,
                                    style: appTextStyle.copyWith(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              CMSPageScreen.route,
                              arguments: {INTENT_CMS_PAGE: INTENT_TERMS_CONDITION},
                            );
                          },
                          child: Card(
                            color: Theme.of(context).cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 15.0,
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.description_outlined,
                                      color: themeBlueColor, size: 30),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context)!.terms_condition,
                                    style: appTextStyle.copyWith(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              CMSPageScreen.route,
                              arguments: {INTENT_CMS_PAGE: INTENT_COOKIES_POLICY},
                            );
                          },
                          child: Card(
                            color: Theme.of(context).cardColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                                vertical: 15.0,
                              ),
                              child: Column(
                                children: [
                                  Icon(Icons.cookie_outlined,
                                      color: themeBlueColor, size: 30),
                                  const SizedBox(height: 8),
                                  Text(
                                    AppLocalizations.of(context)!.cookies_policy,
                                    style: appTextStyle.copyWith(
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  homeScreenViewModel.blockProjectData.isNotEmpty
                      ? ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount:
                              homeScreenViewModel.blockProjectData.length,
                          padding: const EdgeInsets.only(top: 20),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Card(
                                color: Theme.of(context).cardColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: ListTile(
                                    minLeadingWidth: 60,
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            backgroundColor: Colors.transparent,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                    15,
                                                    25,
                                                    15,
                                                    25,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.asset(
                                                    "assets/images/logo.jpeg",
                                                    width: 180,
                                                  ),
                                                  const SizedBox(height: 20),
                                                  Center(
                                                    child: Text(
                                                      AppLocalizations.of(
                                                        context,
                                                      )!.you_are_now_leaving,
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                  RichText(
                                                    text: TextSpan(
                                                      text: AppLocalizations.of(
                                                        context,
                                                      )!.this_link_will_take_you,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              " ${AppLocalizations.of(context)!.privacy_policy} ",
                                                          style:
                                                              const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .blueAccent,
                                                              ),
                                                          recognizer: TapGestureRecognizer()
                                                            ..onTap = () {
                                                              Navigator.of(
                                                                context,
                                                              ).pop();
                                                              Navigator.pushNamed(
                                                                context,
                                                                CMSPageScreen
                                                                    .route,
                                                                arguments: {
                                                                  INTENT_CMS_PAGE:
                                                                      INTENT_PRIVACY_POLICY,
                                                                },
                                                              );
                                                            },
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.does_not_apply,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(height: 30),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 40,
                                                          child: ElevatedButton(
                                                            onPressed: () async {
                                                              print(
                                                                "homeScreenViewModel.blockProjectData[index].linkWebSite ${homeScreenViewModel.blockProjectData[index].toJson()}",
                                                              );
                                                              Navigator.pop(
                                                                context,
                                                              );
                                                              final Uri
                                                              url = Uri.parse(
                                                                homeScreenViewModel
                                                                    .blockProjectData[index]
                                                                    .linkWebSite!,
                                                              );
                                                              if (!await launchUrl(
                                                                url,
                                                              )) {
                                                                //throw Exception('Could not launch ${homeScreenViewModel.blockProjectData[index].linkWebSite!}');
                                                                ScaffoldMessenger.of(
                                                                  context,
                                                                ).showSnackBar(
                                                                  SnackBar(
                                                                    backgroundColor:
                                                                        themeBlueColor,
                                                                    behavior:
                                                                        SnackBarBehavior
                                                                            .fixed,
                                                                    content: Text(
                                                                      AppLocalizations.of(
                                                                        context,
                                                                      )!.link_not_valid,
                                                                      style: appTextStyle.copyWith(
                                                                        fontSize:
                                                                            16.0,
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }
                                                            },
                                                            style: ButtonStyle(
                                                              shape: WidgetStateProperty.all(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        25.0,
                                                                      ),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  WidgetStateProperty.all(
                                                                    themeBlueColor,
                                                                  ),
                                                            ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.continue_btn,
                                                              style: appTextStyle
                                                                  .copyWith(
                                                                    color:
                                                                        white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: SizedBox(
                                                          height: 40,
                                                          child: ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                context,
                                                              ).pop();
                                                            },
                                                            style: ButtonStyle(
                                                              shape: WidgetStateProperty.all(
                                                                RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                        25.0,
                                                                      ),
                                                                ),
                                                              ),
                                                              backgroundColor:
                                                                  WidgetStateProperty.all(
                                                                    themeBlueColor,
                                                                  ),
                                                            ),
                                                            child: Text(
                                                              AppLocalizations.of(
                                                                context,
                                                              )!.cancel,
                                                              style: appTextStyle
                                                                  .copyWith(
                                                                    color:
                                                                        white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        16,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                          return CupertinoAlertDialog(
                                            title: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.navigate_to_website,
                                            ),
                                            content: Text(
                                              AppLocalizations.of(
                                                context,
                                              )!.would_you_like_to_go_to_website,
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                onPressed: () async {
                                                  print(
                                                    "homeScreenViewModel.blockProjectData[index].linkWebSite ${homeScreenViewModel.blockProjectData[index].toJson()}",
                                                  );
                                                  Navigator.pop(context);
                                                  final Uri url = Uri.parse(
                                                    homeScreenViewModel
                                                        .blockProjectData[index]
                                                        .linkWebSite!,
                                                  );
                                                  if (!await launchUrl(url)) {
                                                    //throw Exception('Could not launch ${homeScreenViewModel.blockProjectData[index].linkWebSite!}');
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        backgroundColor:
                                                            themeBlueColor,
                                                        behavior:
                                                            SnackBarBehavior
                                                                .fixed,
                                                        content: Text(
                                                          AppLocalizations.of(
                                                            context,
                                                          )!.link_not_valid,
                                                          style: appTextStyle
                                                              .copyWith(
                                                                fontSize: 16.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                        ),
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.yes,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  )!.no,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    leading: SizedBox(
                                      width: 55,
                                      child:
                                          homeScreenViewModel
                                                  .blockProjectData[index]
                                                  .logoUrl !=
                                              null
                                          ? Image.network(
                                              homeScreenViewModel
                                                      .blockProjectData[index]
                                                      .logoUrl ??
                                                  '',
                                              width: 55,
                                              height: 55,
                                              loadingBuilder:
                                                  (
                                                    context,
                                                    child,
                                                    loadingProgress,
                                                  ) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child;
                                                    } else {
                                                      return PlatformUtils.isAndroid
                                                          ? const Center(
                                                              child: CircularProgressIndicator(
                                                                color:
                                                                    themeBlueColor,
                                                              ),
                                                            )
                                                          : const Center(
                                                              child: CupertinoActivityIndicator(
                                                                radius: 18,
                                                                color:
                                                                    themeBlueColor,
                                                              ),
                                                            );
                                                    }
                                                  },
                                            )
                                          : const Icon(Icons.image, size: 40),
                                    ),
                                    title: Text(
                                      homeScreenViewModel
                                          .blockProjectData[index]
                                          .title!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    subtitle: Text(
                                      homeScreenViewModel
                                          .blockProjectData[index]
                                          .description!,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 13,
                                      ),
                                    ),
                                    trailing: Icon(Icons.navigate_next_sharp),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Container(),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushNamed(context, CMSPageScreen.route,
                  //         arguments: {INTENT_CMS_PAGE: INTENT_TERMS_CONDITION});
                  //   },
                  //   child: Card(
                  //     color: Theme.of(context).cardColor,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(
                  //         20.0,
                  //       ),
                  //     ),
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //         horizontal: 10.0,
                  //         vertical: 15.0,
                  //       ),
                  //       child: Row(
                  //         children: [
                  //           SizedBox(
                  //             height: 55,
                  //             width: 55,
                  //             child: Image.asset('assets/images/icon_lab.png'),
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           Text(
                  //             AppLocalizations.of(context)!.terms_condition,
                  //             style: appTextStyle.copyWith(
                  //                 fontSize: 18.0, fontWeight: FontWeight.w600),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushNamed(context, CMSPageScreen.route,
                  //         arguments: {INTENT_CMS_PAGE: INTENT_PRIVACY_POLICY});
                  //   },
                  //   child: Card(
                  //     color: Theme.of(context).cardColor,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20.0)),
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 10.0, vertical: 15.0),
                  //       child: Row(
                  //         children: [
                  //           SizedBox(
                  //             height: 55,
                  //             width: 55,
                  //             child: Image.asset('assets/images/icon_lab.png'),
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           Text(
                  //             AppLocalizations.of(context)!.privacy_policy,
                  //             style: appTextStyle.copyWith(
                  //                 fontSize: 18.0, fontWeight: FontWeight.w600),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  // GestureDetector(
                  //   onTap: () {
                  //     showDialog(
                  //       context: context,
                  //       builder: (context) => AlertDialog(
                  //         backgroundColor: Theme.of(context).cardColor,
                  //         shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(20.0)),
                  //         title: Text(
                  //           AppLocalizations.of(context)!.smarthealth,
                  //           style: appTextStyle.copyWith(
                  //             color: themeBlueColor,
                  //             fontSize: 20,
                  //             fontWeight: FontWeight.w600,
                  //           ),
                  //         ),
                  //         content: Text(
                  //           AppLocalizations.of(context)!
                  //               .are_you_sure_you_want_to_logout,
                  //           style: appTextStyle.copyWith(
                  //             color: Colors.grey,
                  //             fontSize: 17,
                  //           ),
                  //         ),
                  //         actions: [
                  //           TextButton(
                  //             onPressed: () {
                  //               Navigator.pop(context);
                  //             },
                  //             child: Text(
                  //               AppLocalizations.of(context)!.cancel,
                  //               style: appTextStyle.copyWith(
                  //                 color: themeBlueColor,
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //             ),
                  //           ),
                  //           TextButton(
                  //             onPressed: () {
                  //               Navigator.pop(context);
                  //               callLogoutApi();
                  //             },
                  //             child: Text(
                  //               AppLocalizations.of(context)!.ok,
                  //               style: appTextStyle.copyWith(
                  //                 color: themeBlueColor,
                  //                 fontSize: 18,
                  //                 fontWeight: FontWeight.w600,
                  //               ),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     );
                  //   },
                  //   child: Card(
                  //     color: Theme.of(context).cardColor,
                  //     shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(20.0)),
                  //     child: Padding(
                  //       padding: const EdgeInsets.symmetric(
                  //           horizontal: 10.0, vertical: 15.0),
                  //       child: Row(
                  //         children: [
                  //           SizedBox(
                  //             height: 55,
                  //             width: 55,
                  //             child:
                  //                 Image.asset('assets/images/icon_logout.png'),
                  //           ),
                  //           const SizedBox(
                  //             width: 10,
                  //           ),
                  //           Text(
                  //             AppLocalizations.of(context)!.logout,
                  //             style: appTextStyle.copyWith(
                  //                 fontSize: 18.0, fontWeight: FontWeight.w600),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          if (isLoading == true) const AppLoading(),
        ],
      ),
    );
  }

  requestCallAPI() async {
    final requestACallViewModel = context.read<RequestACallViewModel>();
    setState(() {
      isLoading = true;
    });
    requestACallViewModel.requestACall("").then((value) {
      if (requestACallViewModel.userError.success != null) {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: themeBlueColor,
            behavior: SnackBarBehavior.fixed,
            content: Text(
              requestACallViewModel.userError.message.toString(),
              style: appTextStyle.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else if (requestACallViewModel.requestCallResponse.success ==
          API_SUCCESS) {
        print("Hello API_SUCCESS");
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: themeBlueColor,
            behavior: SnackBarBehavior.fixed,
            content: Text(
              requestACallViewModel.requestCallResponse.message.toString(),
              style: appTextStyle.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        );
      } else if (requestACallViewModel.requestCallResponse.success ==
          API_FAIL) {
        print("Hello API_FAIL");
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: themeBlueColor,
            behavior: SnackBarBehavior.fixed,
            content: Text(
              requestACallViewModel.requestCallResponse.message.toString(),
              style: appTextStyle.copyWith(
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        );
      }
    });
  }
}
