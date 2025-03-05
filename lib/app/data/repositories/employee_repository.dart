 import '../../services/local_storage_service.dart';
import '../model/employee_model.dart';

class EmployeeRepository {
  List<EmployeeModel> getAllEmployees() {
    return LocalStorageService.getEmployees();
  }

  void addEmployee(EmployeeModel employee) {
    LocalStorageService.addEmployee(employee);
  }

  void updateEmployee(EmployeeModel employee) {
    LocalStorageService.updateEmployee(employee);
  }

  void deleteEmployee(String id) {
    LocalStorageService.deleteEmployee(id);
  }
}
