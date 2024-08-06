import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/app_color.dart';
import 'package:todo_app/auth/login/login_screen.dart';
import 'package:todo_app/home/setteng/setteng_tab.dart';
import 'package:todo_app/home/tasks/add_task_buttom.dart';
import 'package:todo_app/home/tasks/task_list.dart';
import 'package:todo_app/provider/list_provider.dart';

import '../provider/app_config_provider.dart';
import '../provider/auth_user_provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var authProvider = Provider.of<AuthUserProvider>(context);
    var listProvider = Provider.of<ListProvider>(context);
    var user = authProvider.currentUser;
    return Scaffold(
      backgroundColor: provider.isDarkMode()
          ? AppColors.backgroundDarkColor
          : AppColors.backgroundLightColor,
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              AppLocalizations.of(context)!.title_bar,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              width: 10,
            ),
            if (user != null)
              Text(
                '{${user.name ?? 'User'}} ',
                style: Theme.of(context).textTheme.titleSmall,
              ),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                listProvider.tasksList = [];
                authProvider.currentUser = null;
                Navigator.of(context)
                    .pushReplacementNamed(LoginScreen.RoutName);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        color: provider.isDarkMode()
            ? AppColors.blackDarkColor
            : AppColors.whiteColor,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              selectedIndex = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  label: AppLocalizations.of(context)!.task_list),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: AppLocalizations.of(context)!.setting,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTaskButtomSheet();
        },
        child: Icon(
          Icons.add,
          size: 35,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Container(
            color: AppColors.primaryColor,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Expanded(child: selectedIndex == 0 ? TaskList() : SettingTab()),
        ],
      ),
    );
  }

  void addTaskButtomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => AddTaskButtom());
  }
}
