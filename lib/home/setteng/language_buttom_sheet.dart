import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_color.dart';

import '../../provider/app_config_provider.dart';

class LanguageButtomSheet extends StatefulWidget {
  @override
  State<LanguageButtomSheet> createState() => _LanguageButtomSheetState();
}

class _LanguageButtomSheetState extends State<LanguageButtomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      padding: EdgeInsets.all(20),
      color: provider.isDarkMode()
          ? AppColors.blackDarkColor
          : AppColors.backgroundLightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: () {
              provider.changeLanguage('en');
            },
            child: provider.appLanguage == 'en'
                ? getSelectedItemWidget(AppLocalizations.of(context)!.english)
                : getUnselectedItemWidget(
                    AppLocalizations.of(context)!.english, provider),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              provider.changeLanguage('ar');
            },
            child: provider.appLanguage == 'ar'
                ? getSelectedItemWidget(AppLocalizations.of(context)!.arabic)
                : getUnselectedItemWidget(
                    AppLocalizations.of(context)!.arabic, provider),
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
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: provider.isDarkMode()
                    ? AppColors.whiteColor
                    : AppColors.blackColor,
              ),
        ),
      ],
    );
  }
}
