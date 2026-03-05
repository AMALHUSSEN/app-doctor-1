// ignore_for_file: body_might_complete_normally_nullable, library_private_types_in_public_api

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/Features/ValidateVoucher/view/QRCodeScreen/qr_code_screen.dart';
import 'package:smarthealth_hcp/Features/ValidateVoucher/view_model/validate_voucher_view_model.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:smarthealth_hcp/constants/api_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';

class ValidateVoucherScreen extends StatefulWidget {
  static String route = "/ValidateVoucherScreen";
  const ValidateVoucherScreen({Key? key}) : super(key: key);

  @override
  _ValidateVoucherScreenState createState() => _ValidateVoucherScreenState();
}

class _ValidateVoucherScreenState extends State<ValidateVoucherScreen> {
  TextEditingController serialNumberController = TextEditingController();
  // late ValidateVoucherViewModel validateVoucherViewModel;
  final formGlobalKey = GlobalKey<FormState>();
  bool isLoading = false;

  callValidateVoucherAPI() {
    final validateVoucherViewModel = context.read<ValidateVoucherViewModel>();
    if (formGlobalKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      validateVoucherViewModel
          .validateVoucher(serialNumberController.text)
          .then((value) {
            if (validateVoucherViewModel.userError.success != null) {
              setState(() {
                isLoading = false;
              });
              CommonWidget.showErrorMessage(
                validateVoucherViewModel.userError.message.toString(),
                context,
              );
            } else if (validateVoucherViewModel
                    .validateVoucherResponse
                    .success ==
                API_SUCCESS) {
              setState(() {
                isLoading = false;
              });
              CommonWidget.showErrorMessage(
                validateVoucherViewModel.validateVoucherResponse.message
                    .toString(),
                context,
              );
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
                (route) => false,
              );
            } else if (validateVoucherViewModel
                    .validateVoucherResponse
                    .success ==
                API_FAIL) {
              setState(() {
                isLoading = false;
              });
              CommonWidget.showErrorMessage(
                validateVoucherViewModel.validateVoucherResponse.message
                    .toString(),
                context,
              );
            } else if (validateVoucherViewModel
                    .validateVoucherResponse
                    .success ==
                API_UNVERIFIED) {
              setState(() {
                isLoading = false;
              });
              CommonWidget.showErrorMessage(
                validateVoucherViewModel.validateVoucherResponse.message
                    .toString(),
                context,
              );
            }
          });
    }
  }

  // void scanQRCodeBtnCalled() {
  //   debugPrint('Scan QR code clicked');
  //   Navigator.of(context).pushNamed(QRCodeScanScreen.route).then((value) {

  //   });
  // }

  static const _kBasePadding = 10.0;
  static const kExpandedHeight = 130.0;

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
    // validateVoucherViewModel = context.read<ValidateVoucherViewModel>();
    _scrollController.addListener(() {
      _titlePaddingNotifier.value = _horizontalTitlePadding;
    });
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: Theme.of(context).colorScheme.background,
              pinned: true,
              floating: false,
              elevation: 0,
              expandedHeight: kExpandedHeight,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 0,
                ),
                title: ValueListenableBuilder(
                  valueListenable: _titlePaddingNotifier,
                  builder: (context, value, child) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: value),
                      child: SizedBox(
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            AppLocalizations.of(context)!.validatevoucher,
                            style: appTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        AppLocalizations.of(context)!.validatevouchersubtitle,
                        textAlign: TextAlign.left,
                        style: appTextStyle.copyWith(color: grey, fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
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
                    child: Form(
                      key: formGlobalKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 70.0),
                          TextFormField(
                            controller: serialNumberController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(
                                  context,
                                )!.please_enter_serial_number;
                              }
                            },
                            // controller: passwordController,
                            decoration: InputDecoration(
                              labelText: AppLocalizations.of(
                                context,
                              )!.serial_no,
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
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 20.0,
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.or,
                                style: appTextStyle.copyWith(fontSize: 17),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const QRCodeScanScreen(),
                                  ),
                                ).then((value) {
                                  serialNumberController.text = value
                                      .toString();
                                });
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.white,
                                ),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                    side: const BorderSide(
                                      color: themeBlueColor,
                                    ),
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.qr_code_scanner_rounded,
                                    color: themeBlueColor,
                                  ),
                                  const SizedBox(width: 10.0),
                                  Text(
                                    AppLocalizations.of(context)!.scan_qr_code,
                                    style: appTextStyle.copyWith(
                                      color: themeBlueColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                callValidateVoucherAPI();
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
                  ),
                  if (isLoading == true) const AppLoading(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
