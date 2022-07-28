import 'package:flutter/material.dart';

import 'package:get/get.dart';

class UsersView extends GetView {
  const UsersView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UsersView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'UsersView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
