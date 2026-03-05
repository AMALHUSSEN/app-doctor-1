import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealth_hcp/l10n/app_localizations.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/models/city_list_response_model/city_data.dart';
import 'package:smarthealth_hcp/Features/PatientDetails/view_model/patient_details_screen_view_model.dart';
import 'package:smarthealth_hcp/constants/color_consts.dart';
import 'package:smarthealth_hcp/constants/style_consts.dart';

class CitiesBottomsheet extends StatefulWidget {
  final Function? getCity;
  final List<CityData> list;
  const CitiesBottomsheet({Key? key, this.getCity, required this.list})
    : super(key: key);

  @override
  State<CitiesBottomsheet> createState() => _CitiesBottomsheetState();
}

class _CitiesBottomsheetState extends State<CitiesBottomsheet> {
  TextEditingController searchTextController = TextEditingController();
  late PatientdetailsViewModel patientdetailsViewModel;
  List<CityData>? searchCityList;
  List<String> cityList = [];

  @override
  void initState() {
    patientdetailsViewModel = context.read<PatientdetailsViewModel>();
    searchCityList = patientdetailsViewModel.cityData;

    for (var i = 0; i < searchCityList!.length; i++) {
      cityList.add(searchCityList![i].title.toString());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("Cities-->${patientdetailsViewModel.cityData}");
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
                  AppLocalizations.of(context)!.city,
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
                      return cityList.where(
                        (element) => element.toString().toLowerCase().contains(
                          textEditingValue.text,
                        ),
                      );
                    }
                  },
                  onSelected: (option) {
                    debugPrint("SELECTED_VALUE -- $option");
                    if (option.toString().isEmpty) {
                      searchCityList = widget.list;
                      setState(() {});
                    } else {
                      searchCityList = widget.list
                          .where(
                            (element) => element.title.toString().contains(
                              option.toString(),
                            ),
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
                              searchCityList = widget.list;
                              setState(() {});
                            } else {
                              searchCityList = widget.list
                                  .where(
                                    (element) =>
                                        element.toString().contains(value),
                                  )
                                  .toList();
                              debugPrint("ONCHANGE LIST -> $searchCityList");
                              setState(() {});
                            }
                          },
                        );
                      },
                ),

                // TextFormField(
                //   controller: searchTextController,
                //   onChanged: (value) {
                //     if (value.isNotEmpty) {
                //       searchCityList = searchCityList!
                //           .where(
                //             (element) => element.title
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
                //     } else {
                //       searchCityList = patientdetailsViewModel.cityData;
                //     }
                //     debugPrint("Result List Data-->$searchCityList");
                //     setState(() {});
                //   },
                //   decoration: InputDecoration(
                //     hintText: AppLocalizations.of(context)!.city_name,
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
                const SizedBox(height: 20.0),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    shrinkWrap: true,
                    itemCount: searchCityList?.length,
                    controller: scrollController,
                    itemBuilder: (BuildContext context, int index) {
                      CityData data = searchCityList![index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: GestureDetector(
                          onTap: () {
                            widget.getCity!(data.title ?? '', data.id ?? 0);
                            Navigator.pop(context);
                          },
                          child: Text(
                            data.title ?? '',
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
