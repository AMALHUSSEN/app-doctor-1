// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';

class UploadConsentBottomsheet extends StatefulWidget {
  final Function? getFile;
  final String? reports;
  const UploadConsentBottomsheet({super.key, this.getFile, this.reports});

  @override
  State<UploadConsentBottomsheet> createState() =>
      _UploadConsentBottomsheetState();
}

class _UploadConsentBottomsheetState extends State<UploadConsentBottomsheet> {
  late XFile? profileImageXfile;
  late File file;
  bool isCloudSelected = false;
  List<PlatformFile>? pFiles = [];
  String? fileName;
  @override
  Widget build(BuildContext context) {
    fileName = widget.reports;

    return Padding(
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
                    _getFromCamera(context);
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          backgroundColor: themeBlueColor,
                          child: Icon(Icons.camera_alt, color: Colors.white),
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
                    _getFromGallery(context);
                  },
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 50,
                        child: CircleAvatar(
                          backgroundColor: themeBlueColor,
                          child: Icon(Icons.image, color: Colors.white),
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
                    uploadFile(context);
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
    );
  }

  /// Get from Camera
  _getFromCamera(BuildContext context) async {
    profileImageXfile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
    );
    debugPrint("IMAGE -> $profileImageXfile");
    if (profileImageXfile != null) {
      debugPrint("IMAGE -> ${profileImageXfile!.path}");
      // fileName = profileImageXfile!.name;
      file = File(profileImageXfile!.path.toString());
      fileName = profileImageXfile!.path;
      widget.getFile!(fileName);
      Navigator.of(context).pop();
    }
  }

  /// Get from gallery
  _getFromGallery(BuildContext context) async {
    profileImageXfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 50,
    );
    debugPrint("IMAGE -> $profileImageXfile");
    if (profileImageXfile != null) {
      debugPrint("IMAGE -> ${profileImageXfile!.path}");
      // _callUpdateProfileImageApi(profileImageXfile!.path);

      fileName = profileImageXfile!.path;
      // fileName = profileImageXfile!.name;
      file = File(profileImageXfile!.path.toString());
      widget.getFile!(fileName);
      Navigator.of(context).pop();
    }
  }

  /// Upload File from Drive
  uploadFile(BuildContext context) async {
    pFiles = (await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    ))!.files;
    debugPrint("FILE -> $pFiles");
    fileName = pFiles!.first.path;
    file = File(fileName.toString());
    debugPrint("FILENAME -> ${pFiles!.first.path}");
    widget.getFile!(fileName);
    Navigator.of(context).pop();
  }
}
