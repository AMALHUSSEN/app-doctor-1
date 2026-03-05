// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/Features/MyList/view/my_list_screen.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/models/patient_registration_response/data.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/view_model/patient_details_screen_view_model.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/get_projects_response_model/projects_data.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/get_projects_response_model/voucher.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view_model/select_project_view_model.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/shared_const.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';

class VoucherDetailsScreen extends StatefulWidget {
  final int? voucherIndex;
  final int? projectIndex;
  const VoucherDetailsScreen({super.key, this.voucherIndex, this.projectIndex});

  @override
  State<VoucherDetailsScreen> createState() => _VoucherDetailsScreenState();
}

class _VoucherDetailsScreenState extends State<VoucherDetailsScreen> {
  late SelectProjectViewModel selectProjectViewModel;
  late PatientdetailsViewModel patientdetailsViewModel;
  Voucher? voucherData;
  ProjectsData? projectData;
  PatientRegData? patientRegData;
  bool _isGeneratingPdf = false;

  @override
  void initState() {
    selectProjectViewModel = context.read<SelectProjectViewModel>();
    patientdetailsViewModel = context.read<PatientdetailsViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    patientRegData =
        patientdetailsViewModel.patientRegistrationResponse.result?.data;
    projectData = selectProjectViewModel.projectsData[widget.projectIndex ?? 0];
    voucherData = selectProjectViewModel
        .projectsData[widget.projectIndex ?? 0]
        .vouchers?[widget.voucherIndex ?? 0];
    super.initState();
  }

  Future<void> share(String text) async {
    await SharePlus.instance.share(
      ShareParams(
        title: AppLocalizations.of(context)!.example_share,
        text: text,
        subject: AppLocalizations.of(context)!.example_share,
      ),
    );
  }

  Future<void> sharePdf() async {
    setState(() {
      _isGeneratingPdf = true;
    });

    try {
      // Load Arabic-supporting fonts
      final regularFontData = await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
      final boldFontData = await rootBundle.load('assets/fonts/Cairo-Bold.ttf');
      final regularFont = pw.Font.ttf(regularFontData);
      final boldFont = pw.Font.ttf(boldFontData);

      final isArabic = Localizations.localeOf(context).languageCode == 'ar';
      final textDirection = isArabic ? pw.TextDirection.rtl : pw.TextDirection.ltr;

      final baseStyle = pw.TextStyle(font: regularFont, fontBold: boldFont);

      final pdf = pw.Document();

      final projectName = patientRegData?.projectTitle ?? '';
      final serviceName = patientRegData?.voucherTitle ?? '';
      final doctorName = Shared.pref.getString(PREF_USER_NAME) ?? '';
      final doctorEmail = Shared.pref.getString(PREF_USER_EMAIL) ?? '';
      final voucherId = patientRegData?.id?.toString() ?? '';
      final generatedOn = getDateTimeLocalFormat(
          patientRegData?.createdAt.toString() ?? "");
      final expDate = getDateTimeLocalFormat(
          patientRegData?.expirationDate.toString() ?? "");
      final successMessage = patientRegData?.successMessage ?? '';

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          textDirection: textDirection,
          margin: const pw.EdgeInsets.all(40),
          theme: pw.ThemeData.withFont(base: regularFont, bold: boldFont),
          build: (pw.Context pdfContext) {
            return pw.Directionality(
              textDirection: textDirection,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Center(
                    child: pw.Text(
                      'SmartHealth',
                      style: baseStyle.copyWith(
                        fontSize: 28,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColor.fromInt(0xFF005BAA),
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 8),
                  pw.Center(
                    child: pw.Text(
                      AppLocalizations.of(context)!.voucher,
                      style: baseStyle.copyWith(
                        fontSize: 18,
                        color: PdfColors.grey700,
                      ),
                    ),
                  ),
                  pw.SizedBox(height: 30),
                  pw.Divider(color: PdfColor.fromInt(0xFF005BAA), thickness: 2),
                  pw.SizedBox(height: 20),
                  _buildPdfRow(AppLocalizations.of(context)!.project_name, projectName, baseStyle, textDirection),
                  pw.SizedBox(height: 12),
                  _buildPdfRow(AppLocalizations.of(context)!.service, serviceName, baseStyle, textDirection),
                  pw.SizedBox(height: 12),
                  _buildPdfRow(AppLocalizations.of(context)!.doctor_name, doctorName, baseStyle, textDirection),
                  pw.SizedBox(height: 12),
                  _buildPdfRow(AppLocalizations.of(context)!.doctor_email, doctorEmail, baseStyle, textDirection),
                  pw.SizedBox(height: 12),
                  _buildPdfRow('${AppLocalizations.of(context)!.voucher} #', voucherId, baseStyle, textDirection),
                  pw.SizedBox(height: 12),
                  _buildPdfRow(AppLocalizations.of(context)!.generated_on, generatedOn, baseStyle, textDirection),
                  pw.SizedBox(height: 12),
                  _buildPdfRow(AppLocalizations.of(context)!.exp_date, expDate, baseStyle, textDirection),
                  pw.SizedBox(height: 30),
                  pw.Divider(color: PdfColors.grey400),
                  pw.SizedBox(height: 15),
                  if (successMessage.isNotEmpty)
                    pw.Text(
                      successMessage,
                      textDirection: textDirection,
                      style: baseStyle.copyWith(
                        fontSize: 14,
                        color: PdfColors.grey700,
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      );

      final tempDir = await getTemporaryDirectory();
      final filePath = '${tempDir.path}/voucher_$voucherId.pdf';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      await SharePlus.instance.share(
        ShareParams(
          title: '${AppLocalizations.of(context)!.voucher} #$voucherId',
          files: [XFile(filePath)],
          subject: '${AppLocalizations.of(context)!.voucher} #$voucherId',
        ),
      );
    } catch (e) {
      debugPrint("PDF Generation Error: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error generating PDF: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isGeneratingPdf = false;
        });
      }
    }
  }

  pw.Widget _buildPdfRow(String label, String value, pw.TextStyle baseStyle, pw.TextDirection textDirection) {
    return pw.Directionality(
      textDirection: textDirection,
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.SizedBox(
            width: 140,
            child: pw.Text(
              label,
              textDirection: textDirection,
              style: baseStyle.copyWith(
                fontSize: 13,
                fontWeight: pw.FontWeight.bold,
                color: PdfColors.grey800,
              ),
            ),
          ),
          pw.Expanded(
            child: pw.Text(
              value,
              textDirection: textDirection,
              style: baseStyle.copyWith(
                fontSize: 13,
                color: PdfColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const _kBasePadding = 10.0;
  static const kExpandedHeight = 145.0;

  final ValueNotifier<double> _titlePaddingNotifier = ValueNotifier(
    _kBasePadding,
  );

  final _scrollController = ScrollController();

  double get _horizontalTitlePadding {
    const kCollapsedPadding = 45.0;

    if (_scrollController.hasClients) {
      return min(
        _kBasePadding + kCollapsedPadding,
        _kBasePadding +
            (kCollapsedPadding * _scrollController.offset) /
                (kExpandedHeight - kToolbarHeight),
      );
    }
    return _kBasePadding;
  }

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() {
      _titlePaddingNotifier.value = _horizontalTitlePadding;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        title: Text(
          AppLocalizations.of(context)!.voucher,
          style: appTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
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
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: themeBlueColor),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20.0),
                        Image.asset('assets/images/icon_logo.png', scale: 25),
                        const SizedBox(height: 10.0),
                        Text(
                          "${AppLocalizations.of(context)!.project_name}: ${patientRegData?.projectTitle}",
                          style: appTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "${AppLocalizations.of(context)!.service}:${patientRegData?.voucherTitle}",
                          style: appTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "${AppLocalizations.of(context)!.doctor_name}:${Shared.pref.getString(PREF_USER_NAME)}",
                          style: appTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "${AppLocalizations.of(context)!.doctor_email}:${Shared.pref.getString(PREF_USER_EMAIL)}",
                          style: appTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "${AppLocalizations.of(context)!.voucher} #${patientRegData?.id}",
                          style: appTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "${AppLocalizations.of(context)!.generated_on}:${getDateTimeLocalFormat(patientRegData?.createdAt.toString() ?? "")}",
                          style: appTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "${AppLocalizations.of(context)!.exp_date}:${getDateTimeLocalFormat(patientRegData?.expirationDate.toString() ?? "")}",
                          style: appTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "${patientRegData?.successMessage}",
                          style: appTextStyle.copyWith(fontSize: 16),
                        ),
                        const SizedBox(height: 50.0),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyListScreen(),
                                ),
                              );
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
                              AppLocalizations.of(context)!.done,
                              style: appTextStyle.copyWith(
                                color: white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        if (projectData
                                ?.vouchers![widget.voucherIndex ?? 0]
                                .skipShareVoucher ==
                            0)
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: _isGeneratingPdf ? null : () {
                                sharePdf();
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
                                '${AppLocalizations.of(context)!.share} (PDF)',
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
              ),
            ),
          ),
          if (_isGeneratingPdf)
            Container(
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(color: themeBlueColor),
              ),
            ),
        ],
      ),
    );
  }

  static String getDateTimeLocalFormat(String date) {
    try {
      DateFormat format = DateFormat("MMM dd, yyyy");
      var fDate = format.format(DateTime.parse(date).toLocal());
      debugPrint("F_DATE->$fDate");
      return fDate;
    } catch (e) {
      return "";
    }
  }
}
