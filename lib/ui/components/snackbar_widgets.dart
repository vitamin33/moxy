import 'package:flutter/material.dart';

SnackBar snackBarWhenFailure({required String snackBarFailureText}) {
  return SnackBar(
    content: Text(snackBarFailureText),
    backgroundColor: Colors.red,
  );
}

SnackBar snackBarWhenSuccess({required String snackBarSuccessText}) {
  return SnackBar(
    content: Text(snackBarSuccessText),
    backgroundColor: Colors.green,
  );
}
