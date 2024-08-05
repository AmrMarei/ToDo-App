import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/tasks.dart';
import 'package:todo_app/provider/auth_user_provider.dart';

import '../../app_color.dart';
import '../../firebase_utils.dart';
import '../../provider/app_config_provider.dart';
import '../../provider/list_provider.dart';

class AddTaskButtom extends StatefulWidget {
  @override
  State<AddTaskButtom> createState() => _AddTaskButtomState();
}

class _AddTaskButtomState extends State<AddTaskButtom> {
  var selectedDate = DateTime.now();
  var formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  late ListProvider listProvider;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    listProvider = Provider.of<ListProvider>(context);
    return Container(
      color: provider.isDarkMode()
          ? AppColors.blackDarkColor
          : AppColors.backgroundLightColor,
      padding: EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.add_task,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: provider.isDarkMode()
                      ? AppColors.whiteColor
                      : AppColors.blackColor),
            ),
            Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        onChanged: (text) {
                          title = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_inter_tit;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enter_task,
                          hintStyle: TextStyle(
                              color: provider.isDarkMode()
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        onChanged: (text) {
                          description = text;
                        },
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return AppLocalizations.of(context)!
                                .please_inter_des;
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.enter_des,
                          hintStyle: TextStyle(
                              color: provider.isDarkMode()
                                  ? AppColors.whiteColor
                                  : AppColors.blackColor),
                        ),
                        maxLines: 4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        AppLocalizations.of(context)!.select_date,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: provider.isDarkMode()
                                ? AppColors.whiteColor
                                : AppColors.blackColor),
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
                                      : AppColors.blackColor),
                        ),
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        addTask();
                      },
                      child: Text(
                        AppLocalizations.of(context)!.add,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    )
                  ],
                ))
          ],
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

  void addTask() {
    if (formKey.currentState?.validate() == true) {
      Task task = Task(
          title: title,
          description: description,
          dateTime: selectedDate,
          isDone: true);

      var authProvider = Provider.of<AuthUserProvider>(context, listen: false);
      FirebaseUtils.addTaskToFireStore(task, authProvider.currentUser!.id!)
          .then((value) {
        print('task added successfully');
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        Navigator.pop(context);
      }).timeout(Duration(seconds: 1), onTimeout: () {
        print('task added successfully');
        listProvider.getAllTasksFromFireStore(authProvider.currentUser!.id!);
        Navigator.pop(context);
      });
    }
  }
}
