import 'package:flutter/material.dart';

Widget buildLoadingScreen() {
  return Scaffold(
    backgroundColor: Colors.grey,
    body: Center(
      child: CircularProgressIndicator(),
    ),
  );
}