import 'package:get/get.dart';
import '../modules/employee_list/employee_list_screen.dart';
import '../modules/employee_list/employee_list_binding.dart';
import '../modules/employee_details/employee_details_screen.dart';

class Routes {
  static const String EMPLOYEE_LIST = '/employeeList';
  static const String EMPLOYEE_DETAILS = '/employeeDetails';
}

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.EMPLOYEE_LIST,
      page: () => EmployeeListScreen(),
      binding: EmployeeListBinding(),
    ),
    GetPage(
      name: Routes.EMPLOYEE_DETAILS,
      page: () => EmployeeDetailsScreen(),
      binding: EmployeeListBinding(),
    ),
  ];
}
