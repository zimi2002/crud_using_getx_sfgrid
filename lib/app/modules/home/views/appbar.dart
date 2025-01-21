// custom_appbar.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sfgrid/app/modules/home/controllers/home_controller.dart';
import 'package:sfgrid/app/modules/home/views/DialogBox.dart';

class CustomAppBar extends GetView<HomeController> {
  final String title;

  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green, // Background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0), // Square shape
              ),
              minimumSize: const Size(40, 40), // Fixed size
            ),
            onPressed: () {
              controller.setupControllers();
              // Show dialog
              showDialog(context: context, builder: (context) => DialogBox());

              // Show snackbar
            },
            child: const Text(
              'Add NEW USER', // White text inside the button
              style: TextStyle(
                color: Colors.white, // Text color
                fontWeight: FontWeight.bold, // Bold text
              ),
            ),
          ),
        ),
      ],
    );
  }
}
