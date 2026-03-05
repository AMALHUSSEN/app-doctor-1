import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:signature/signature.dart';
import 'package:smarthealth_hcp/Features/Login/view/login_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectConsent/ViewModel/projectconsent_viewmodel.dart';
import 'package:smarthealth_hcp/Features/ProjectConsent/model/project_consent_detail_response/data.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectConsentScreen extends StatefulWidget {
  final String projectCode;
  final String userId;
  const ProjectConsentScreen({
    Key? key,
    required this.projectCode,
    required this.userId,
  }) : super(key: key);

  @override
  State<ProjectConsentScreen> createState() => _ProjectConsentScreenState();
}

class _ProjectConsentScreenState extends State<ProjectConsentScreen> {
  late Uint8List? data;
  late String projectCode;
  late ByteData? bytes;
  bool isFirstTime = true;
  bool isLoading = true;
  bool isProjectLoading = true;
  late int index;
  String imagePath = "";
  ProjectConsentViewModel projectConsentViewModel = ProjectConsentViewModel();
  ProjectConsentData projectConsentData = ProjectConsentData();
  // late MemoryImage image;
  GlobalKey<SignatureState> signatureKey = GlobalKey();

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.grey[300],
    exportPenColor: Colors.black,
    onDrawStart: () => debugPrint('onDrawStart called!'),
    onDrawEnd: () => debugPrint('onDrawEnd called!'),
  );

  @override
  void initState() {
    projectConsentViewModel = context.read<ProjectConsentViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callProjectDetailAPI();
    });
    debugPrint("P_CODE--< ${widget.projectCode}");
    debugPrint("U_ID--< ${widget.userId}");
    super.initState();
  }

  callProjectDetailAPI() {
    isLoading = true;
    setState(() {});
    projectConsentViewModel.getConsentProjectDetail(widget.userId).then((
      value,
    ) {
      isLoading = false;
      setState(() {});
      if (projectConsentViewModel.userError.success != null) {
        CommonWidget.showErrorMessage(
          projectConsentViewModel.userError.message.toString(),
          context,
        );
      } else if (projectConsentViewModel.projectConsentDetailResponse.success ==
          API_SUCCESS) {
        projectConsentData =
            projectConsentViewModel.projectConsentDetailResponse.result!.data!;
        debugPrint("DATA--> $projectConsentData");
        setState(() {
          isLoading = false;
        });
      } else if (projectConsentViewModel.projectConsentDetailResponse.success ==
          API_FAIL) {
        CommonWidget.showErrorMessage(
          projectConsentViewModel.projectConsentDetailResponse.message
              .toString(),
          context,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          // resizeToAvoidBottomInset: false,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            iconTheme: Theme.of(context).iconTheme,
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ).copyWith(bottom: 20.0),
                      child: Text(
                        // CONSENT,
                        AppLocalizations.of(context)!.consent,
                        style: appTextStyle.copyWith(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 5.0,
                      ),
                      child: Text(
                        // PROJECTS_NAME,
                        AppLocalizations.of(context)!.project_name,
                        style: appTextStyle.copyWith(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 3.0,
                      ),
                      child: Text(
                        // "projectName",
                        projectConsentData.name ?? "",
                        style: appTextStyle.copyWith(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    if (projectConsentData.consent != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 5.0,
                        ),
                        child: Text(
                          // CONSENT,
                          AppLocalizations.of(context)!.consent,
                          style: appTextStyle.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (projectConsentData.consent != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 3.0,
                        ),
                        child: HtmlWidget(
                          // "doctorConsent",
                          projectConsentData.consent ?? "",
                          textStyle: appTextStyle.copyWith(
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        // Text(
                        //   parseHtmalString(doctorConsent ?? ""),
                        //   style: appTitleNumberTextStyle.copyWith(
                        //     fontSize: 15.0,
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        // ),
                      ),
                    const SizedBox(height: 20.0),
                    if (projectConsentData.consentForm != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 5.0,
                        ),
                        child: Text(
                          // CONSENT_FORM,
                          AppLocalizations.of(context)!.consent_form,
                          style: appTextStyle.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    if (projectConsentData.consentForm != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            _launchUrl(
                              projectConsentData.consentForm.toString(),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 26.0,
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.file_copy),
                                  const SizedBox(width: 15.0),
                                  Expanded(
                                    child: Text(
                                      // "doctorConsentForm",
                                      projectConsentData.name ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: appTextStyle.copyWith(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  IconTheme(
                                    data: Theme.of(context).iconTheme,
                                    child: const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                      ).copyWith(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            // SIGNATURE,
                            AppLocalizations.of(context)!.signature,
                            style: appTextStyle.copyWith(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              _controller.clear();
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                              ).copyWith(left: 10.0),
                              child: Text(
                                AppLocalizations.of(context)!.clear,
                                style: appTextStyle.copyWith(
                                  color: themeBlueColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      height: 200,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Signature(
                          controller: _controller,
                          height: 300,
                          backgroundColor: Colors.grey.shade300,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20.0,
                      ),
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_controller.isEmpty) {
                              debugPrint("SIGNATURE -EMPTY -> $_controller");
                              CommonWidget.showErrorMessage(
                                AppLocalizations.of(
                                  context,
                                )!.please_add_signature,
                                context,
                              );
                            } else if (_controller.isNotEmpty) {
                              data = await _controller.toPngBytes();
                              // MemoryImage(data!);
                              var image = await writeCounter();
                              debugPrint("SIGNATURE -> $image");
                              debugPrint("SIGNATUREnot null -> $image");
                              imagePath = image.path;
                              doctorConsentApiCall();
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
                            // SUBMIT,
                            AppLocalizations.of(context)!.submit,
                            style: appTextStyle.copyWith(
                              color: white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (projectConsentViewModel.loading || isLoading) const AppLoading(),
      ],
    );
  }

  void _launchUrl(String url) async {
    debugPrint("URL_GOING_TO_OPEN -> $url");
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/image.jpg');
  }

  Future<File> writeCounter() async {
    final file = await _localFile;
    return file.writeAsBytes(data!);
  }

  doctorConsentApiCall() async {
    isLoading = true;
    setState(() {});
    debugPrint("PIVOT_ID--> ${projectConsentData.pivotId}");
    debugPrint("IMAGEPATH--> $imagePath");
    projectConsentViewModel
        .doctorConsent(projectConsentData.pivotId ?? 0, imagePath)
        .then((value) {
          isLoading = false;
          setState(() {});
          if (projectConsentViewModel.userError.success != null) {
            CommonWidget.showErrorMessage(
              projectConsentViewModel.userError.message.toString(),
              context,
            );
          } else if (projectConsentViewModel.submitConsentResponse.success ==
              API_SUCCESS) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
            );
          } else if (projectConsentViewModel.submitConsentResponse.success ==
              API_FAIL) {
            CommonWidget.showErrorMessage(
              projectConsentViewModel.submitConsentResponse.message.toString(),
              context,
            );
          }
        });
  }
}
