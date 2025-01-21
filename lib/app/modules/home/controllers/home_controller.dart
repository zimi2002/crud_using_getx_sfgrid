import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sfgrid/Model_class.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  RxList<ListUser> list_users = <ListUser>[].obs;
  late TextEditingController id_controller;
  late TextEditingController name_controller;
  late TextEditingController age_controller;
  late TextEditingController mark_controller;
  late TextEditingController address_controller;
  Rxn<ListUser> selectedUser =
      Rxn<ListUser>(); // Holds the selected user for editing
  RxBool isEditing = false.obs;
  RxBool isSortedAscending = true.obs; // Track sorting direction
  final storage = GetStorage();

  @override
  void onInit() {
    loadDataFromStorage();
    super.onInit();
    id_controller = TextEditingController();
    name_controller = TextEditingController();
    age_controller = TextEditingController();
    mark_controller = TextEditingController();
    address_controller = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    id_controller.dispose();
    name_controller.dispose();
    age_controller.dispose();
    mark_controller.dispose();
    address_controller.dispose();
    super.onClose();
  }

  void addUser(ListUser user) {
    list_users.add(user);
    saveDataToStorage();
    print("User added: ${user.toJson()}");
  }

  void saveDataToStorage() {
    List<Map<String, dynamic>> userListJson =
        list_users.map((user) => user.toJson()).toList();
    storage.write("users", userListJson);
    print("Data saved to storage");
  }

  void loadDataFromStorage() {
    List<dynamic>? storedUsers = storage.read<List<dynamic>>("users");
    if (storedUsers != null) {
      list_users.value =
          storedUsers.map((user) => ListUser.fromJson(user)).toList();
      print("Data loaded from storage${storedUsers}");
    }
  }

  void updateUser(int id, ListUser updatedUser) {
    int index = list_users.indexWhere((user) => user.id == id);
    if (index != -1) {
      list_users[index] = updatedUser; // Update user at the specific index
      saveDataToStorage();
      print("User updated: ${updatedUser.toJson()}");
    }
  }

  void deleteUserById(int id) {
    list_users.removeWhere((user) => user.id == id);
  }

  void setupControllers({ListUser? user}) {
    if (user != null) {
      isEditing.value = true; // Editing mode
      selectedUser.value = user;
      id_controller.text = user.id.toString();
      name_controller.text = user.name;
      age_controller.text = user.age.toString();
      mark_controller.text = user.mark.toString();
      address_controller.text = user.address;
    } else {
      isEditing.value = false; // Adding mode
      selectedUser.value = null;
      id_controller.clear();
      name_controller.clear();
      age_controller.clear();
      mark_controller.clear();
      address_controller.clear();
    }
  }

  void sortByMarks() {
    if (isSortedAscending.value) {
      list_users.sort((a, b) => a.mark.compareTo(b.mark)); // Ascending order
    } else {
      list_users.sort((a, b) => b.mark.compareTo(a.mark)); // Descending order
    }
    isSortedAscending.value =
        !isSortedAscending.value; // Toggle sorting direction
    list_users.refresh(); // Notify listeners to update the UI
    print(
        "List sorted by marks in ${isSortedAscending.value ? "ascending" : "descending"} order");
  }
}
