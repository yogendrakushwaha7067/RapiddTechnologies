import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar(
    {
    required String message,
    int duration = 2,
    bool isForError = false}) {
  Get.closeAllSnackbars();

  return Get.showSnackbar(
    GetSnackBar(
      borderRadius: 12,
      snackStyle: SnackStyle.FLOATING,
      duration: Duration(seconds: duration),
      backgroundColor: isForError ? Colors.red : Colors.green,
      titleText: Text(
        isForError  ? "Error" : "Success",
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 17),
      ),
      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
    ),
  );
}
