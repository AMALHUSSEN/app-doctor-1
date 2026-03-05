// ignore_for_file: file_names, unused_local_variable, prefer_final_fields, depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/questionnaire_response_bean/datum.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';

class CustomCheckBox extends StatefulWidget {
  final QuestionnaireData? questionnaireData;
  // final Option? question;
  final Function? callBack;

  const CustomCheckBox({Key? key, this.questionnaireData, this.callBack})
      : super(key: key);

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  late final ValueChanged<bool?>? onChanged;
  List<int> selectedIds = [];
  int _value = 1;
  int selectedEmoji = 0;
  int selectedChecboxId = 0;
  int selectedRadioButtonId = 0;

  Map request = {};
  List<dynamic> questions = [];
  List<dynamic> listRequest = [];
  @override
  void initState() {
    super.initState();
    widget.questionnaireData?.options?.map((e) {
      if (e.answer == true) {
        selectedIds.add(e.id!);
        debugPrint("GIVEN ANSWER ID -> $selectedIds");

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var brightness = SchedulerBinding.instance.window.platformBrightness;

    return widget.questionnaireData!.type != "rating"
        ? Wrap(
            runSpacing: -10,
            direction: Axis.vertical,
            children: [
              ...widget.questionnaireData!.options!.map((e) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.questionnaireData!.type == "radio_button")
                      Radio(
                        visualDensity: VisualDensity.compact,
                        activeColor: themeBlueColor,
                        value: selectedRadioButtonId == e.id ? 1 : 0,
                        groupValue: _value,
                        onChanged: (value) {
                          selectedRadioButtonId = e.id!;
                          debugPrint("SELECTED_IDS--> $selectedRadioButtonId");
                          request.addAll({
                            'id': widget.questionnaireData!.id,
                            'options': selectedRadioButtonId
                          });
                          // listRequest.add(request);
                          debugPrint(
                              "REQUEST_IS EXIST--> ${request.containsKey(widget.questionnaireData!.id)}");
                          debugPrint("REQUEST--> $request");
                          widget.callBack!(e.id, request);
                          setState(() {});
                        },
                      ),
                    if (widget.questionnaireData!.type == "checkbox")
                      Checkbox(
                        visualDensity: VisualDensity.compact,
                        activeColor: themeBlueColor,
                        checkColor: Colors.white,
                        splashRadius: 20.0,
                        value: selectedIds.contains(e.id) ? true : false,
                        onChanged: (value) {
                          selectedIds.contains(e.id!)
                              ? selectedIds.remove(e.id)
                              : selectedIds.add(e.id!);
                          debugPrint(
                              "SELECTED_selectedChecbox--> $selectedIds");
                          request.addAll({
                            'id': widget.questionnaireData!.id,
                            'options': selectedIds
                          });
                          // listRequest.add(request);
                          debugPrint(
                              "REQUEST_IS EXIST--> ${request.containsKey(widget.questionnaireData!.id)}");
                          debugPrint("REQUEST--> $request");
                          widget.callBack!(e.id, request);
                          setState(() {});
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(
                            width: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        if (widget.questionnaireData!.type == "radio_button") {
                          selectedRadioButtonId = e.id!;
                          debugPrint(
                              "SELECTED_selectedChecbox--> $selectedRadioButtonId");
                          request.addAll({
                            'id': widget.questionnaireData!.id,
                            'options': selectedRadioButtonId
                          });
                        } else if (widget.questionnaireData!.type ==
                            "checkbox") {
                          selectedIds.contains(e.id!)
                              ? selectedIds.remove(e.id)
                              : selectedIds.add(e.id!);
                          request.addAll({
                            'id': widget.questionnaireData!.id,
                            'options': selectedIds
                          });
                        }
                        // listRequest.add(request);
                        debugPrint("REQUEST--> $request");
                        widget.callBack!(e.id, request);
                        setState(() {});
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(
                          e.option.toString(),
                          style: appTextStyle.copyWith(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  selectedEmoji = 1;
                  request.addAll({
                    'id': widget.questionnaireData!.id,
                    'rating': selectedEmoji
                  });
                  // listRequest.add(request);
                  widget.callBack!(widget.questionnaireData!.id, request);
                  setState(() {});
                },
                icon: Icon(
                  Icons.sentiment_very_dissatisfied_sharp,
                  size: 35,
                  color: selectedEmoji == 1
                      ? themeBlueColor
                      : brightness == ThemeMode.dark
                          ? Colors.white
                          : Theme.of(context).hintColor,
                ),
              ),
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  selectedEmoji = 2;
                  request.addAll({
                    'id': widget.questionnaireData!.id,
                    'rating': selectedEmoji
                  });
                  // listRequest.add(request);
                  widget.callBack!(widget.questionnaireData!.id, request);
                  setState(() {});
                },
                icon: Icon(
                  Icons.sentiment_dissatisfied_sharp,
                  size: 35,
                  color: selectedEmoji == 2
                      ? themeBlueColor
                      : brightness == ThemeMode.dark
                          ? Colors.white
                          : Theme.of(context).hintColor,
                ),
              ),
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  selectedEmoji = 3;
                  request.addAll({
                    'id': widget.questionnaireData!.id,
                    'rating': selectedEmoji
                  });
                  // listRequest.add(request);
                  widget.callBack!(widget.questionnaireData!.id, request);
                  setState(() {});
                },
                icon: Icon(
                  Icons.sentiment_neutral_outlined,
                  size: 35,
                  color: selectedEmoji == 3
                      ? themeBlueColor
                      : brightness == ThemeMode.dark
                          ? Colors.white
                          : Theme.of(context).hintColor,
                ),
              ),
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  selectedEmoji = 4;
                  request.addAll({
                    'id': widget.questionnaireData!.id,
                    'rating': selectedEmoji
                  });
                  // listRequest.add(request);
                  widget.callBack!(widget.questionnaireData!.id, request);
                  setState(() {});
                },
                icon: Icon(
                  Icons.sentiment_satisfied_alt_sharp,
                  size: 35,
                  color: selectedEmoji == 4
                      ? themeBlueColor
                      : brightness == ThemeMode.dark
                          ? Colors.white
                          : Theme.of(context).hintColor,
                ),
              ),
              IconButton(
                splashRadius: 20,
                onPressed: () {
                  selectedEmoji = 5;
                  request.addAll({
                    'id': widget.questionnaireData!.id,
                    'rating': selectedEmoji
                  });
                  // listRequest.add(request);
                  widget.callBack!(widget.questionnaireData!.id, request);
                  setState(() {});
                },
                icon: Icon(
                  Icons.emoji_emotions_outlined,
                  size: 35,
                  color: selectedEmoji == 5
                      ? themeBlueColor
                      : brightness == ThemeMode.dark
                          ? Colors.white
                          : Theme.of(context).hintColor,
                ),
              ),
            ],
          );
  }
}
