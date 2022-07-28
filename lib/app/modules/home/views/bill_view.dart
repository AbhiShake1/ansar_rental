import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BillView extends GetView {
  const BillView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BillView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'BillView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
