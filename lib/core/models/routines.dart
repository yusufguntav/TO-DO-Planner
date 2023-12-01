import 'package:to_do_app/core/variables/enums.dart';

class RoutineModel {
  String? id;
  String? name;
  List<WeekDay>? selectedDays;
  RoutineModel({this.id, this.name, this.selectedDays});
}
