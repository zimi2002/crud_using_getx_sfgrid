import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sfgrid/app/modules/home/views/appbar.dart';
import 'package:sfgrid/app/modules/home/views/sfgrid.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetResponsiveView<HomeController> {
  @override
  Widget? builder() {
    if (screen.isDesktop) {
      return _Desktop();
    } else if (screen.isTablet) {
      return _TabletSize();
    } else if (screen.isPhone) {
      return _MobileSize();
    } else {
      return _Default();
    }
  }

  Widget _Desktop() {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: CustomAppBar(title: "USER_DATA")),
      body: Column(
        children: [Expanded(child: SFGrid())],
      ),
    );
  }

  Widget _Default() {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: CustomAppBar(title: "USER_DATA")),
      body: Column(
        children: [
          Expanded(child: SFGrid()),
          Text(
            "Other Size",
          )
        ],
      ),
    );
  }

  Widget _MobileSize() {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: CustomAppBar(title: "USER_DATA")),
      body: Column(
        children: [
          Expanded(child: SFGrid()),
          Text(
            "Mobile Size",
          )
        ],
      ),
    );
  }

  Widget _TabletSize() {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: CustomAppBar(title: "USER_DATA")),
      body: Column(
        children: [
          Expanded(child: SFGrid()),
          Text(
            "Tablet Size",
          )
        ],
      ),
    );
  }
}
