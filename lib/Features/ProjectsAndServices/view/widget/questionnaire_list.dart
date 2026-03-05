import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/questionnaire_response_bean/datum.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/model/questionnaire_response_bean/option.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view/widget/customcheck_box.dart';
import 'package:smarthealth_hcp/Features/ProjectsAndServices/view_model/select_project_view_model.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';

class QuestionNaireList extends StatefulWidget {
  final int? vouchedId;
  final Function? questionCallBack;

  const QuestionNaireList({Key? key, this.vouchedId, this.questionCallBack})
      : super(key: key);

  @override
  State<QuestionNaireList> createState() => _QuestionNaireListState();
}

class _QuestionNaireListState extends State<QuestionNaireList> {
// Variables
  bool isLoading = true;
  List<int> selectedQuestionnaires = [];
  List<dynamic> getRequest = [];
  Map request = {};
  List<QuestionnaireData> questionnaireData = [];
  List<Option> questionList = [];
  late SelectProjectViewModel selectProjectViewModel;
  int selectedEmoji = 0;
  int selectedChecboxId = 0;
  int selectedRadioButtonId = 0;

  List<int> selectedIds = [];
  _selectedIds(List<int> ids) {
    debugPrint("IDS--> $ids");
    selectedIds = ids;
  }

  _getData(int id, Map<dynamic, dynamic> request) {
    if (getRequest.contains(request)) {
      getRequest.remove(request);
      debugPrint("CONTAINS_REMOVE-> $getRequest");
      getRequest.add(request);
      debugPrint("CONTAINS_REMOVE ADDD-> $getRequest");
    } else {
      getRequest.add(request);
      debugPrint("ADDD-> $getRequest");
    }
    widget.questionCallBack!(getRequest);
  }

  @override
  Widget build(BuildContext context) {
    selectProjectViewModel =
        Provider.of<SelectProjectViewModel>(context, listen: false);
    questionnaireData = selectProjectViewModel.questionnaireData;
    debugPrint("QUESTIONNAIRE_DATA--> $questionnaireData");

    return ListView.builder(
      // shrinkWrap: true,
      padding: const EdgeInsets.only(bottom: 80.0),
      itemCount: questionnaireData.length,
      itemBuilder: (BuildContext context, int index) {
        final data = questionnaireData[index];
        questionList = data.options ?? [];
        debugPrint("QUESTIONLIST--> $questionList");
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: selectedQuestionnaires.contains(data.id)
                        ? themeBlueColor
                        : Colors.grey),
                borderRadius: BorderRadius.circular(5.0)),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              child: Row(
                children: [
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title ?? '',
                          style: appTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.0,
                          ),
                        ),
                        CustomCheckBox(
                          questionnaireData: questionnaireData[index],
                          callBack: _getData,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
