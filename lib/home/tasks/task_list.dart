import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home/tasks/task_list_item.dart';

import '../../provider/app_config_provider.dart';

class TaskList extends StatefulWidget {
  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    var isDarkMode = provider.isDarkMode();
    return Column(
      children: [
        EasyDateTimeLine(
          locale: provider.appLanguage,
          initialDate: DateTime.now(),
          onDateChange: (selectedDate) {},
          headerProps: EasyHeaderProps(
            monthPickerType: MonthPickerType.dropDown,
            dateFormatter: DateFormatter.fullDateDMonthAsStrY(),
            // Use default settings for header
          ),
          dayProps: EasyDayProps(
            dayStructure: DayStructure.dayStrDayNumMonth,
            activeDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: isDarkMode
                      ? [Color(0xff2c3e50), Color(0xff4ca1af)]
                      : [Color(0xff3371FF), Color(0xff8426D6)],
                ),
              ),
              // textStyle is removed here
            ),
            inactiveDayStyle: DayStyle(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
              ),
              // textStyle is removed here
            ),
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return TaskListItem();
            },
            itemCount: 30,
          ),
        ),
      ],
    );
  }
}