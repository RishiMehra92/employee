import 'package:get/get.dart';
import 'employee_list_controller.dart';
import '../../data/repositories/employee_repository.dart';

class EmployeeListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EmployeeListController>(() => EmployeeListController(EmployeeRepository()));
  }
}
