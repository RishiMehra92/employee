import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'employee_list_controller.dart';
import '../employee_details/employee_details_screen.dart';

class EmployeeListScreen extends StatelessWidget {
  final EmployeeListController controller = Get.find<EmployeeListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employee List")),
      body: Column(
        children: [
          Obx(() => DropdownButton<String>(
            value: controller.filterByLocation.value.isEmpty ? null : controller.filterByLocation.value,
            hint: Text("Filter by Location"),
            onChanged: (value) {
              controller.filterByLocation.value = value ?? '';
              controller.filterEmployees();
            },
            items: ["All", "New York", "Los Angeles", "Chicago"]
                .map((e) => DropdownMenuItem<String>(
              value: e == "All" ? '' : e,
              child: Text(e),
            ))
                .toList(),
          ),

          ),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: controller.employees.length,
              itemBuilder: (context, index) {
                var employee = controller.employees[index];
                return ListTile(
                  title: Text(employee.name),
                  subtitle: Text("${employee.designation} - ${employee.location}"),
                  onTap: () => Get.to(() => EmployeeDetailsScreen(employee: employee)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => controller.deleteEmployee(employee.id),
                  ),
                );
              },
            )),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.to(() => EmployeeDetailsScreen()),
      ),
    );
  }
}
