import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/models/country_list_response_model/datum.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/view_model/patient_details_screen_view_model.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';

class CountriesBottomsheet extends StatefulWidget {
  final Function? getCountry;
  final List<CountriesData> list;
  const CountriesBottomsheet({Key? key, this.getCountry, required this.list})
    : super(key: key);

  @override
  State<CountriesBottomsheet> createState() => _CountriesBottomsheetState();
}

class _CountriesBottomsheetState extends State<CountriesBottomsheet> {
  TextEditingController searchTextController = TextEditingController();
  late PatientdetailsViewModel patientdetailsViewModel;
  List<CountriesData>? searchCountryList;
  List<String> countryList = [];
  @override
  void initState() {
    patientdetailsViewModel = context.read<PatientdetailsViewModel>();
    searchCountryList = patientdetailsViewModel.countriesData;

    for (var i = 0; i < searchCountryList!.length; i++) {
      countryList.add(searchCountryList![i].countryName.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Country-->${patientdetailsViewModel.countriesData}");
    debugPrint("WIDGET_Country_DATA-->${widget.list}");
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.9,
        expand: true,
        builder: (context, scrollController) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 30.0),
                Text(
                  AppLocalizations.of(context)!.country,
                  style: appTextStyle.copyWith(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10.0),
                Autocomplete(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text.isEmpty) {
                      return const Iterable<String>.empty();
                    } else {
                      return countryList.where(
                        (element) => element.toString().toLowerCase().contains(
                          textEditingValue.text,
                        ),
                      );
                    }
                  },
                  onSelected: (option) {
                    debugPrint("SELECTED_VALUE -- $option");
                    if (option.toString().isEmpty) {
                      searchCountryList = widget.list;
                      setState(() {});
                    } else {
                      searchCountryList = widget.list
                          .where(
                            (element) => element.countryName
                                .toString()
                                .contains(option.toString()),
                          )
                          .toList();
                      setState(() {});
                    }
                  },
                  optionsViewBuilder:
                      (context, Function(String) onSelected, options) {
                        return Column(
                          children: [
                            SizedBox(
                              height: 180,
                              child: Material(
                                type: MaterialType.canvas,
                                elevation: 4,
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: options.length,
                                  itemBuilder: (context, index) {
                                    final option = options.elementAt(index);
                                    return ListTile(
                                      title: Text(option.toString()),
                                      onTap: () {
                                        onSelected(option.toString());
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                  fieldViewBuilder:
                      (
                        context,
                        textEditingController,
                        focusNode,
                        onFieldSubmitted,
                      ) {
                        return TextFormField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          onEditingComplete: onFieldSubmitted,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(
                              context,
                            )!.country_name,
                            filled: true,
                            prefixIcon: const Icon(
                              Icons.search,
                              color: themeBlueColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              searchCountryList = widget.list;
                              setState(() {});
                            } else {
                              searchCountryList = widget.list
                                  .where(
                                    (element) =>
                                        element.toString().contains(value),
                                  )
                                  .toList();
                              debugPrint("ONCHANGE LIST -> $searchCountryList");
                              setState(() {});
                            }
                          },
                        );
                      },
                ),
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    shrinkWrap: true,
                    itemCount: searchCountryList?.length,
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      CountriesData data = searchCountryList![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            widget.getCountry!(
                              data.countryName ?? '',
                              data.countryCode ?? '',
                            );
                            Navigator.pop(context);
                          },
                          child: Text(
                            data.countryName ?? '',
                            style: appTextStyle.copyWith(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

///// SEARCH TEXTFORM FIELD
// TextFormField(
//   controller: searchTextController,
//   onChanged: (value) {
//     if (value.isNotEmpty) {
//       searchCountryList = searchCountryList
//           ?.where(
//             (element) => element.countryName
//                 .toString()
//                 .toLowerCase()
//                 .toUpperCase()
//                 .contains(
//                   searchTextController.text
//                       .toString()
//                       .toLowerCase()
//                       .toUpperCase(),
//                 ),
//           )
//           .toList();
//       setState(() {});
//     } else {
//       searchCountryList = patientdetailsViewModel.countriesData;
//     }
//     debugPrint("Result List Data-->$searchCountryList");
//     setState(() {});
//   },
//   decoration: InputDecoration(
//     hintText: AppLocalizations.of(context)!.country_name,
//     filled: true,
//     prefixIcon: const Icon(
//       Icons.search,
//       color: themeBlueColor,
//     ),
//     border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none),
//     focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(10),
//         borderSide: BorderSide.none),
//   ),
// ),
