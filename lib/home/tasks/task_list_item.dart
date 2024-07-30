import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../../app_color.dart';
import '../../provider/app_config_provider.dart';
import 'edit_task_screen.dart';

class TaskListItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
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
                // delete task
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
                Navigator.of(context).pushNamed(EditTaskScreen.routeName);
              },
              backgroundColor: AppColors.greenColor,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
            ),
          ],
        ),
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
                color: provider.isDarkMode()
                    ? AppColors.blackDarkColor
                    : AppColors.whiteColor,
                height: MediaQuery.of(context).size.height * 0.1,
                width: 2,
              ),
              SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.primaryColor,
                          ),
                    ),
                    Text(
                      AppLocalizations.of(context)!.description,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: AppColors.primaryColor,
                          ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    AppColors.primaryColor,
                  ),
                  shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {},
                child: Icon(Icons.check, size: 30),
              )
            ],
          ),
        ),
      ),
    );
  }
}
