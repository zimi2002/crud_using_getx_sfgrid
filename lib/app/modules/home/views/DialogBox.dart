import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Model_class.dart';
import '../controllers/home_controller.dart';

class DialogBox extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Obx(() => Text(controller.isEditing.value
          ? "Edit User Details"
          : "Enter User Details")),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: controller.id_controller,
              decoration: const InputDecoration(labelText: "ID"),
              keyboardType: TextInputType.number,
              enabled: !controller.isEditing.value,
            ),
            TextField(
              controller: controller.name_controller,
              decoration: const InputDecoration(labelText: "Name"),
            ),
            TextField(
              controller: controller.age_controller,
              decoration: const InputDecoration(labelText: "Age"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: controller.mark_controller,
              decoration: const InputDecoration(labelText: "Mark"),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            TextField(
              controller: controller.address_controller,
              decoration: const InputDecoration(labelText: "Address"),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            ListUser updatedUser = ListUser(
                id: int.tryParse(controller.id_controller.text) ?? 0,
                name: controller.name_controller.text,
                age: int.tryParse(controller.age_controller.text) ?? 0,
                mark: double.tryParse(controller.mark_controller.text) ?? 0.0,
                address: controller.address_controller.text);
            if (controller.isEditing.value &&
                controller.selectedUser.value != null) {
              controller.updateUser(
                  controller.selectedUser.value!.id, updatedUser);
            } else {
              controller.addUser(updatedUser);
            }
            Navigator.of(context).pop();
          },
          child:
              Obx(() => Text(controller.isEditing.value ? "Update" : "Save")),
        ),
      ],
    );
  }
}
