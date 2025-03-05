import 'package:get/get.dart';
import '../../data/model/employee_model.dart';
import '../../data/repositories/employee_repository.dart';

class EmployeeListController extends GetxController {
  final EmployeeRepository repository;
  var employees = <EmployeeModel>[].obs;
  var filterByDesignation = ''.obs;
  var filterByLocation = ''.obs;

  EmployeeListController(this.repository);

  void loadEmployees() {
    employees.assignAll(repository.getAllEmployees());
  }


  void filterEmployees() {
    var allEmployees = repository.getAllEmployees();

    print("Total employees before filtering: ${allEmployees.length}");

    if (filterByDesignation.value.isNotEmpty) {
      allEmployees = allEmployees.where((e) => e.designation == filterByDesignation.value).toList();
    }
    if (filterByLocation.value.isNotEmpty) {
      allEmployees = allEmployees.where((e) => e.location == filterByLocation.value).toList();
    }

    print("Total employees after filtering: ${allEmployees.length}");

    employees.assignAll(allEmployees);
  }



  void deleteEmployee(String id) {
    repository.deleteEmployee(id);
    loadEmployees(); // Ensure list refreshes after deletion
  }

   Map<String, int> getDepartmentWiseCount() {
    var departmentCounts = <String, int>{};
    for (var employee in employees) {
      departmentCounts[employee.department] = (departmentCounts[employee.department] ?? 0) + 1;
    }
    return departmentCounts;
  }

   Map<String, int> getLocationWiseCount() {
    var locationCounts = <String, int>{};
    for (var employee in employees) {
      locationCounts[employee.location] = (locationCounts[employee.location] ?? 0) + 1;
    }
    return locationCounts;
  }


  @override
  void onInit() {
    loadEmployees();
    super.onInit();
  }
}
