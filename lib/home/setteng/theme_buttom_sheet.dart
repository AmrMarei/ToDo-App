import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_color.dart';

import '../../provider/app_config_provider.dart';

class ThemeButtomSheet extends StatefulWidget {
  @override
  State<ThemeButtomSheet> createState() => _ThemeButtomSheetState();
}

class _ThemeButtomSheetState extends State<ThemeButtomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: EdgeInsets.all(30),
      color: provider.isDarkMode()
          ? AppColors.blackDarkColor
          : AppColors.backgroundLightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.dark);
            },
            child: provider.isDarkMode()
                ? getSelectedItemWidget(AppLocalizations.of(context)!.dark)
                : getUnselectedItemWidget(
                    AppLocalizations.of(context)!.dark, provider),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              provider.changeTheme(ThemeMode.light);
            },
            child: provider.isDarkMode()
                ? getUnselectedItemWidget(
                    AppLocalizations.of(context)!.light, provider)
                : getSelectedItemWidget(AppLocalizations.of(context)!.light),
          ),
        ],
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.primaryColor,
              ),
        ),
        Icon(
          Icons.check,
          size: 30,
          color: AppColors.primaryColor,
        )
      ],
    );
  }

  Widget getUnselectedItemWidget(String text, AppConfigProvider provider) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context)!.textTheme.bodyLarge?.copyWith(
                color: provider.isDarkMode()
                    ? AppColors.whiteColor
                    : AppColors.blackColor,
              ),
        ),
      ],
    );
  }
}
