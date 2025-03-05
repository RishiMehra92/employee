import 'package:hive/hive.dart';
part 'employee_model.g.dart'; // Auto-generated file

@HiveType(typeId: 0)
class EmployeeModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String designation;

  @HiveField(3)
  final String location;

  @HiveField(4)
  final String department;

  EmployeeModel({
    required this.id,
    required this.name,
    required this.designation,
    required this.location,
    required this.department,
  });
}
