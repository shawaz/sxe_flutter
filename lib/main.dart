import 'package:sxe/app.dart';
import 'package:sxe/utils/app_initializer.dart';
import 'package:flutter/material.dart';

void main() async {
  await AppInitializer.initialize();
  runApp(SXE());
}
