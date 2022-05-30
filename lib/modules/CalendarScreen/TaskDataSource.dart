import 'package:final_todo2/modules/CalendarScreen/Event.dart';
import 'package:final_todo2/shared/constants/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TaskDataSource extends CalendarDataSource{
  TaskDataSource(appointments){
    this.appointments = appointments;
  }

  getEvent(int index) => appointments![index];

  // @override
  // DateTime getStartTime(int index) {
  //   // TODO: implement getStartTime
  //   return getEvent(index);
  // }
  //
  // @override
  // DateTime getEndTime(int index) {
  //   // TODO: implement getEndTime
  //   return getEvent(index);
  // }

  // @override
  // String getSubject(int index) => getEvent(index)['title'];
}