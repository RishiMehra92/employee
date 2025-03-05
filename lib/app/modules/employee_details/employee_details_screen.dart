import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/model/employee_model.dart';
import '../employee_list/employee_list_controller.dart';

class EmployeeDetailsScreen extends StatelessWidget {
  final EmployeeModel? employee;

  EmployeeDetailsScreen({this.employee});

  final _formKey = GlobalKey<FormState>(); // Form Key for validation
  final TextEditingController nameController = TextEditingController();
  final TextEditingController designationController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (employee != null) {
      nameController.text = employee!.name;
      designationController.text = employee!.designation;
      locationController.text = employee!.location;
    }

    return Scaffold(
      appBar: AppBar(title: Text(employee == null ? "Add Employee" : "Edit Employee")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form( // Wrap with Form
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Name is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: designationController,
                decoration: InputDecoration(labelText: "Designation"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Designation is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: locationController,
                decoration: InputDecoration(labelText: "Location"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Location is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text("Save"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      var controller = Get.find<EmployeeListController>();

                      var newEmployee = EmployeeModel(
                        id: employee?.id ?? DateTime.now().toString(),
                        name: nameController.text.trim(),
                        designation: designationController.text.trim(),
                        location: locationController.text.trim(),
                        department: "IT",
                      );

                      if (employee == null) {
                        controller.repository.addEmployee(newEmployee);
                      } else {
                        controller.repository.updateEmployee(newEmployee); // Ensure update method exists
                      }

                      controller.loadEmployees(); // Refresh employee list after save
                      Get.back();
                    }
                  }

              ),
            ],
          ),
        ),
      ),
    );
  }
}
