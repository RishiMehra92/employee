import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../data/model/employee_model.dart';

class LocalStorageService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(EmployeeModelAdapter());

    // Open Box
    await Hive.openBox<EmployeeModel>('employees');

    // Add Dummy Data if Box is Empty
    if (employeeBox.isEmpty) {
      addDummyEmployees();
    }
  }

  static Box<EmployeeModel> get employeeBox => Hive.box<EmployeeModel>('employees');

  static List<EmployeeModel> getEmployees() {
    return employeeBox.values.toList();
  }

  static void addEmployee(EmployeeModel employee) {
    employeeBox.put(employee.id, employee);
  }

  static void updateEmployee(EmployeeModel employee) {
    employeeBox.put(employee.id, employee);
  }

  static void deleteEmployee(String id) {
    employeeBox.delete(id);
  }

  static void addDummyEmployees() {
    List<EmployeeModel> dummyEmployees = [
      EmployeeModel(id: '1', name: 'John Doe', designation: 'Software Engineer', location: 'New York', department: 'IT'),
      EmployeeModel(id: '2', name: 'Jane Smith', designation: 'Product Manager', location: 'San Francisco', department: 'Management'),
      EmployeeModel(id: '3', name: 'Alice Johnson', designation: 'HR Manager', location: 'Chicago', department: 'Human Resources'),
      EmployeeModel(id: '4', name: 'Bob Brown', designation: 'Sales Executive', location: 'Los Angeles', department: 'Sales'),
      EmployeeModel(id: '5', name: 'Charlie Green', designation: 'UX Designer', location: 'Seattle', department: 'Design'),
    ];

    for (var employee in dummyEmployees) {
      employeeBox.put(employee.id, employee);
    }
  }
}
