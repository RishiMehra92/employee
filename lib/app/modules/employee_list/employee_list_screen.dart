import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import 'employee_list_controller.dart';
import '../employee_details/employee_details_screen.dart';

class EmployeeListScreen extends StatelessWidget {
  final EmployeeListController controller = Get.find<EmployeeListController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Employee List"),surfaceTintColor: Colors.transparent,),
      body: Column(
        children: [
          SizedBox(height: 16),
          _buildDepartmentChart(),
          SizedBox(height: 16),
          _buildLocationChart(),
          SizedBox(height: 16),
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
          )),
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

  /// Pie Chart - Employees by Department
  Widget _buildDepartmentChart() {
    return Obx(() {
      var data = controller.getDepartmentWiseCount();
      if (data.isEmpty) return SizedBox(); // Hide chart if no data

      return Container(
        height: 200,
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Employees by Department", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Expanded(
                child: PieChart(
                  PieChartData(
                    sections: data.entries.map((e) {
                      return PieChartSectionData(
                        title: "${e.value}",
                        value: e.value.toDouble(),
                        color: _getRandomColor(),
                        radius: 50,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Bar Chart - Employees by Location
  Widget _buildLocationChart() {
    return Obx(() {
      var data = controller.getLocationWiseCount();
      if (data.isEmpty) return SizedBox(); // Hide chart if no data

      return Container(
        height: 200,
        padding: EdgeInsets.all(8),
        child: Card(
          elevation: 3,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Employees by Location", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Expanded(
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
                      bottomTitles: AxisTitles(sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Padding(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(data.keys.elementAt(value.toInt())),
                          );
                        },
                      )),
                    ),
                    barGroups: List.generate(data.length, (index) {
                      return BarChartGroupData(x: index, barRods: [
                        BarChartRodData(toY: data.values.elementAt(index).toDouble(), color: Colors.blue)
                      ]);
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  /// Generates random colors for the pie chart
  Color _getRandomColor() {
    return Colors.primaries[DateTime.now().millisecondsSinceEpoch % Colors.primaries.length];
  }
}
