import 'package:flutter/material.dart';
import '../configs/color/color.dart';

PreferredSizeWidget appBar(BuildContext context , String title) {
  return AppBar(
    backgroundColor: tsawBlue,
    title: Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );
}