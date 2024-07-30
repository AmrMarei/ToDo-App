import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../app_color.dart';
import '../../provider/app_config_provider.dart';

class EditTaskScreen extends StatefulWidget {
  static const String routeName = 'edit_screen';

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.title_bar),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: provider.isDarkMode()
            ? AppColors.backgroundDarkColor // Dark mode background color
            : AppColors.backgroundLightColor, // Light mode background color
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: AppColors.primaryColor,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              Container(
                margin: EdgeInsets.all(12),
                padding: EdgeInsets.all(16),
                height: MediaQuery.of(context).size.height * 0.7,
                decoration: BoxDecoration(
                  color: provider.isDarkMode()
                      ? AppColors
                          .blackDarkColor // Dark mode content background color
                      : AppColors.whiteColor,
                  // Light mode content background color
                  borderRadius:
                      BorderRadius.circular(16), // Added border radius
                ),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.edit_task,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: provider.isDarkMode()
                                ? AppColors.whiteColor
                                : AppColors.blackColor,
                          ),
                    ),
                    Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: AppLocalizations.of(context)!.this_is,
                                hintStyle: TextStyle(
                                  color: provider.isDarkMode()
                                      ? AppColors.whiteColor
                                      : AppColors.blackColor,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(context)!.task_detail,
                                hintStyle: TextStyle(
                                  color: provider.isDarkMode()
                                      ? AppColors.whiteColor
                                      : AppColors.blackColor,
                                ),
                              ),
                              maxLines: 4,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              AppLocalizations.of(context)!.select_date,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                    color: provider.isDarkMode()
                                        ? AppColors.whiteColor
                                        : AppColors.blackColor,
                                  ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextButton(
                              onPressed: () {
                                showCalender();
                              },
                              child: Text(
                                '${selectedDate.day}/${selectedDate.month}/'
                                '${selectedDate.year}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: provider.isDarkMode()
                                          ? AppColors.whiteColor
                                          : AppColors.blackColor,
                                    ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.primaryColor,
                                // Set the primary color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 24), // Internal padding
                              ),
                              child: Text(
                                AppLocalizations.of(context)!.save,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    selectedDate = chosenDate ?? selectedDate;
    setState(() {});
  }
}
