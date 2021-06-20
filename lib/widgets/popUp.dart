import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:production_entry/theme.dart';

void showAlertPopup(BuildContext context, String title, String detail) async {
  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child,
    );
  }

  return showDemoDialog<Null>(
      context: context,
      child: NativeDialog(
        title: title,
        content: detail,
        actions: <NativeDialogAction>[
          NativeDialogAction(
              text: 'OK',
              isDestructive: false,
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ));
}
void showSuccessPopup(BuildContext context, String title, String detail) async {
  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child,
    );
  }

  return showDemoDialog<Null>(
      context: context,
      child: NativeDialog(
        title: title,
        content: detail,
        actions: <NativeDialogAction>[
          NativeDialogAction(
              text: 'OK',
              isDestructive: false,
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (_) => false);
              }),
        ],
      ));
}


void showOfflineDialog(BuildContext context) {
  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child,
    );
  }

  return showDemoDialog<Null>(
      context: context,
      child: NativeDialog(
        title: 'Connection Error',
        content: 'Failed to establish a connection. Please try again.',
        actions: <NativeDialogAction>[
          NativeDialogAction(
              text: 'OK',
              isDestructive: false,
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ));
}
void showTimeOutDialog(BuildContext context) {
  // flutter defined function
  void showDemoDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => child,
    );
  }

  return showDemoDialog<Null>(
      context: context,
      child: NativeDialog(
        title: 'Connection Error',
        content: 'Failed to establish a connection. Please try again.',
        actions: <NativeDialogAction>[
          NativeDialogAction(
              text:'OK',
              isDestructive: false,
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ));
}

void showLoader(BuildContext context, text) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0))),
          content: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SpinKitFadingCircle(
                size: 30.0,
                color: Colors.black,
              ),
              new Padding(padding: EdgeInsets.only(right: 30)),
              new Text(text)
            ],
          ),
        );
      });
}

void dismissLoader(BuildContext context) {
  Navigator.of(context).pop();
}



showSuccessMessage(BuildContext context,message){
  Flushbar(
    title:  "Success",
    message:  message,
    duration:  Duration(seconds: 4),
    margin: EdgeInsets.all(8),
    icon: Icon(
      Icons.check_circle_outline,
      size: 28.0,
      color: Colors.green,
    ),
  )..show(context);
}

showErrorMessage(BuildContext context,message){
  Flushbar(
    title:  "Oops!",
    message:  message,
    duration:  Duration(seconds: 4),
    margin: EdgeInsets.all(8),
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: Colors.red,
    ),
  )..show(context);
}



