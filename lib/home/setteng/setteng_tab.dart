import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_color.dart';
import 'package:todo_app/home/setteng/theme_buttom_sheet.dart';

import '../../provider/app_config_provider.dart';
import 'language_buttom_sheet.dart';

class SettingTab extends StatefulWidget {
  @override
  State<SettingTab> createState() => _SettingTabState();
}

class _SettingTabState extends State<SettingTab> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: provider.isDarkMode()
                      ? AppColors.whiteColor
                      : AppColors.blackColor,
                ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showLanguageButtomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: provider.isDarkMode()
                    ? AppColors.blackDarkColor
                    : AppColors.whiteColor,
                border: Border.all(color: AppColors.primaryColor, width: 2),
                borderRadius: BorderRadius.circular(1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appLanguage == 'en'
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context)!.textTheme.titleSmall!.copyWith(
                        color: provider.isDarkMode()
                            ? AppColors.primaryColor
                            : AppColors.primaryColor),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 35,
                    color: provider.isDarkMode()
                        ? AppColors.primaryColor
                        : AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            AppLocalizations.of(context)!.theme_mode,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: provider.isDarkMode()
                      ? AppColors.whiteColor
                      : AppColors.blackDarkColor,
                ),
          ),
          SizedBox(
            height: 15,
          ),
          InkWell(
            onTap: () {
              showThemwButtomSheet();
            },
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: provider.isDarkMode()
                    ? AppColors.blackDarkColor
                    : AppColors.whiteColor,
                border: Border.all(color: AppColors.primaryColor, width: 2),
                borderRadius: BorderRadius.circular(1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.isDarkMode()
                        ? AppLocalizations.of(context)!.dark
                        : AppLocalizations.of(context)!.light,
                    style: Theme.of(context)!.textTheme.titleSmall!.copyWith(
                        color: provider.isDarkMode()
                            ? AppColors.primaryColor
                            : AppColors.primaryColor),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 35,
                    color: provider.isDarkMode()
                        ? AppColors.primaryColor
                        : AppColors.primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showLanguageButtomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => LanguageButtomSheet(),
    );
  }

  void showThemwButtomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ThemeButtomSheet(),
    );
  }
}
