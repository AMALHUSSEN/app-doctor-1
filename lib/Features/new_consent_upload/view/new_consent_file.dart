import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:smarthealth_hcp/utils/platform_utils.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:smarthealth_hcp/Features/HomeScreen/view/home_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/upload_consent_screen.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/voucher_detail_screen.dart';
import 'package:smarthealth_hcp/Features/new_consent_upload/view_model/new_consent_view_model.dart';
import 'package:smarthealth_hcp/common_widget.dart/apploading.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/widget_consts.dart';

class UploadNewConsent extends StatefulWidget {
  final int registrationId;
  final int voucherIndex;
  final int projectIndex;
  const UploadNewConsent({
    super.key,
    required this.registrationId,
    required this.projectIndex,
    required this.voucherIndex,
  });

  @override
  State<UploadNewConsent> createState() => _UploadNewConsentState();
}

class _UploadNewConsentState extends State<UploadNewConsent> {
  bool isLoading = false;
  List<String> selectedFiles = [];

  @override
  void initState() {
    debugPrint('new consent registrationId ${widget.registrationId}');
    debugPrint('new consent voucherIndex ${widget.voucherIndex}');
    debugPrint('new consent projectIndex ${widget.projectIndex}');
    super.initState();
  }

  bool _isImageFile(String path) {
    final ext = path.toLowerCase().split('.').last;
    return ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'].contains(ext);
  }

  String _getFileName(String path) {
    return path.split('/').last.split('\\').last;
  }

  void _showFilePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 20.0,
              ),
              child: Text(
                AppLocalizations.of(context)!.choose_option,
                style: appTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      requestCameraPermission();
                    },
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                          width: 50,
                          child: CircleAvatar(
                            backgroundColor: themeBlueColor,
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          AppLocalizations.of(context)!.camera,
                          style: appTextStyle.copyWith(
                            color: themeBlueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _getFromGallery();
                    },
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                          width: 50,
                          child: CircleAvatar(
                            backgroundColor: themeBlueColor,
                            child: Icon(
                              Icons.image,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          AppLocalizations.of(context)!.gallery,
                          style: appTextStyle.copyWith(
                            color: themeBlueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      getStoragePermission();
                    },
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                          width: 50,
                          child: CircleAvatar(
                            backgroundColor: themeBlueColor,
                            child: Icon(
                              Icons.insert_drive_file,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          AppLocalizations.of(context)!.from_drive,
                          style: appTextStyle.copyWith(
                            color: themeBlueColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
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
      body: Consumer<NewConsentFileViewModel>(
        builder: (BuildContext context, NewConsentFileViewModel newConsentFileViewModel, __) {
          return Stack(
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
                      AppLocalizations.of(context)!.upload_new_consent,
                      style: appTextStyle.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Selected files list or upload placeholder
                    Expanded(
                      child: selectedFiles.isEmpty
                          ? Center(
                              child: GestureDetector(
                                onTap: _showFilePickerBottomSheet,
                                child: Container(
                                  height: 250,
                                  width: 250,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.file_upload_outlined,
                                        color: Colors.grey,
                                        size: 70,
                                      ),
                                      Text(
                                        AppLocalizations.of(context)!.upload_consent_form,
                                        style: appTextStyle.copyWith(
                                          color: Colors.grey,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: selectedFiles.length,
                                    itemBuilder: (context, index) {
                                      final filePath = selectedFiles[index];
                                      final isImage = _isImageFile(filePath);
                                      return Container(
                                        margin: const EdgeInsets.only(bottom: 8),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade300),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: ListTile(
                                          leading: isImage
                                              ? ClipRRect(
                                                  borderRadius: BorderRadius.circular(6),
                                                  child: Image.file(
                                                    File(filePath),
                                                    width: 50,
                                                    height: 50,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )
                                              : Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: themeBlueColor.withOpacity(0.1),
                                                    borderRadius: BorderRadius.circular(6),
                                                  ),
                                                  child: const Icon(
                                                    Icons.insert_drive_file,
                                                    color: themeBlueColor,
                                                    size: 30,
                                                  ),
                                                ),
                                          title: Text(
                                            _getFileName(filePath),
                                            style: appTextStyle.copyWith(fontSize: 14),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          subtitle: Text(
                                            index == 0 ? 'Primary' : 'Attachment $index',
                                            style: appTextStyle.copyWith(
                                              fontSize: 12,
                                              color: index == 0 ? themeBlueColor : grey,
                                            ),
                                          ),
                                          trailing: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                selectedFiles.removeAt(index);
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              color: Colors.red,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: _showFilePickerBottomSheet,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 16,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: themeBlueColor,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.add, color: themeBlueColor),
                                        const SizedBox(width: 8),
                                        Text(
                                          AppLocalizations.of(context)!.add_new_file,
                                          style: appTextStyle.copyWith(
                                            color: themeBlueColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                if (selectedFiles.isEmpty) {
                                  CommonWidget.showErrorMessage(
                                    AppLocalizations.of(context)!.please_upload_consent,
                                    context,
                                  );
                                } else {
                                  _uploadAllFiles(newConsentFileViewModel);
                                }
                              },
                        style: ButtonStyle(
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                          backgroundColor: WidgetStateProperty.all(
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
              if (isLoading || newConsentFileViewModel.loading) const AppLoading(),
            ],
          );
        },
      ),
    );
  }

  /// Upload all selected files sequentially
  Future<void> _uploadAllFiles(NewConsentFileViewModel viewModel) async {
    setState(() {
      isLoading = true;
    });

    try {
      for (int i = 0; i < selectedFiles.length; i++) {
        await viewModel.uploadNewConsent(
          widget.registrationId,
          selectedFiles[i],
        );
      }

      if (mounted) {
        setState(() {
          isLoading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VoucherDetailsScreen(
              voucherIndex: widget.voucherIndex,
              projectIndex: widget.projectIndex,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        CommonWidget.showErrorMessage(
          'Upload failed: $e',
          context,
        );
      }
    }
  }

  Future<void> requestCameraPermission() async {
    if (PlatformUtils.isIOS) {
      // On iOS, image_picker handles camera permissions internally via
      // UIImagePickerController. Using permission_handler to pre-request
      // can interfere and cause the camera to not return the captured image.
      _getFromCamera();
      return;
    }
    PermissionStatus status = await Permission.camera.request();
    if (status.isGranted) {
      _getFromCamera();
    } else if (status.isDenied) {
      showDialog(
        context: context,
        builder: (context) => PermissionWarningDialog(
          title: AppLocalizations.of(context)!.smarthealth,
          content: AppLocalizations.of(context)!.please_provide_camera_permission,
        ),
      );
    } else if (status.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (context) => PermissionWarningDialog(
          title: AppLocalizations.of(context)!.smarthealth,
          content: AppLocalizations.of(context)!.please_provide_camera_permission,
        ),
      );
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    // Close the bottom sheet before opening the camera to avoid
    // context/navigation issues on iOS when the camera takes over the screen.
    Navigator.of(context).pop();
    final profileImageXfile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    if (profileImageXfile != null && mounted) {
      setState(() {
        selectedFiles.add(profileImageXfile.path);
      });
    }
  }

  /// Get from gallery - supports multiple images
  _getFromGallery() async {
    Navigator.of(context).pop();
    final images = await ImagePicker().pickMultiImage(
      imageQuality: 50,
    );
    if (images.isNotEmpty && mounted) {
      setState(() {
        for (final img in images) {
          selectedFiles.add(img.path);
        }
      });
    }
  }

  Future<void> getStoragePermission() async {
    if (PlatformUtils.isIOS) {
      // On iOS, FilePicker uses the native document picker which handles
      // its own permissions. No need for permission_handler.
      uploadFile();
      return;
    }
    if (PlatformUtils.isAndroid) {
      DeviceInfoPlugin plugin = DeviceInfoPlugin();
      AndroidDeviceInfo android = await plugin.androidInfo;
      if (android.version.sdkInt < 33) {
        if (await Permission.manageExternalStorage.request().isGranted) {
          uploadFile();
        } else if (await Permission.storage.request().isPermanentlyDenied) {
          await openAppSettings();
        } else if (await Permission.audio.request().isDenied) {}
      } else {
        if (await Permission.photos.request().isGranted) {
          uploadFile();
        } else if (await Permission.photos.request().isPermanentlyDenied) {
          await openAppSettings();
        } else if (await Permission.photos.request().isDenied) {}
      }
    }
  }

  /// Upload Files from Drive - supports multiple file selection
  uploadFile() async {
    Navigator.of(context).pop();
    var fileP = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: true,
    );

    if (fileP != null && fileP.files.isNotEmpty && mounted) {
      setState(() {
        for (final pFile in fileP.files) {
          if (pFile.path != null) {
            selectedFiles.add(pFile.path!);
          }
        }
      });
    }
  }
}
