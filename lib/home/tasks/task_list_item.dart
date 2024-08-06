import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/provider/auth_user_provider.dart';
import 'package:todo_app/provider/list_provider.dart';

import '../../app_color.dart';
import '../../model/tasks.dart';
import '../../provider/app_config_provider.dart';
import 'edit_task_screen.dart';

class TaskListItem extends StatelessWidget {
  Task task;

  TaskListItem({required this.task});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    var authProvider = Provider.of<AuthUserProvider>(context);
    return Container(
      margin: EdgeInsets.all(12),
      child: Slidable(
        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),
          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              onPressed: (context) {
                FirebaseUtils.deleteTaskFromFireStore(
                        task, authProvider.currentUser!.id!)
                    .then((value) {
                  print('Task deleted successfully');
                  listProvider
                      .getAllTasksFromFireStore(authProvider.currentUser!.id!);
                }).timeout(Duration(milliseconds: 500), onTimeout: () {
                  print('Task deleted successfully');
                  listProvider
                      .getAllTasksFromFireStore(authProvider.currentUser!.id!);
                });
              },
              backgroundColor: AppColors.redColor,
              foregroundColor: AppColors.whiteColor,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          extentRatio: 0.25,
          // A motion is a widget used to control how the pane animates.
          motion: const DrawerMotion(),
          // All actions are defined in the children parameter.
          children: [
            SlidableAction(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              onPressed: (context) {
                // edit task
                Navigator.of(context)
                    .pushNamed(EditTaskScreen.routeName, arguments: task);
              },
              backgroundColor: AppColors.greenColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: provider.isDarkMode()
                  ? AppColors.blackDarkColor
                  : AppColors.whiteColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.all(12),
                  color: task.isDone
                      ? AppColors.primaryColor
                      : AppColors.greenColor,
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: 2,
                ),
                SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        task.title,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              color: task.isDone
                                  ? AppColors.primaryColor
                                  : AppColors.greenColor,
                            ),
                      ),
                      Text(
                        task.description,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: task.isDone
                                      ? AppColors.primaryColor
                                      : AppColors.greenColor,
                                ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      task.isDone
                          ? AppColors.primaryColor
                          : AppColors.greenColor,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  onPressed: !(task.isDone)
                      ? null // Make the button disabled if the task is done
                      : () {
                          task.isDone = false; // Mark task as done
                          FirebaseUtils.updateTaskInFireStore(
                                  task, authProvider.currentUser!.id!)
                              .then((value) {
                            listProvider.getAllTasksFromFireStore(
                                authProvider.currentUser!.id!);
                          }).timeout(Duration(milliseconds: 500),
                                  onTimeout: () {
                            listProvider.getAllTasksFromFireStore(
                                authProvider.currentUser!.id!);
                          });
                        },
                  child: task.isDone
                      ? Icon(Icons.check, size: 30)
                      : Text(
                          AppLocalizations.of(context)!.done,
                          style: TextStyle(color: AppColors.whiteColor),
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
