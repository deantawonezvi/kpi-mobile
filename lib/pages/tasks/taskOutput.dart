import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:production_entry/api.dart';
import 'package:production_entry/models/dto/response/tasks.dart';
import 'package:production_entry/widgets/popUp.dart';

class TaskOutputPage extends StatefulWidget {
  final Task task;
  const TaskOutputPage({Key key, this.task}) : super(key: key);

  @override
  _TaskOutputPageState createState() => _TaskOutputPageState();
}

class _TaskOutputPageState extends State<TaskOutputPage> {
  var scannedItems = <String>[];

  var responseData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Task Outputs"),
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.task.outputs.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('${widget.task.outputs[index].outputType}'),
                    subtitle: Text('${widget.task.outputs[index].outputValue}'),
                  ),
                );
              },
            )
          ],
        ),

      ),
      floatingActionButton: widget.task.startedDate != null
          ? FloatingActionButton(
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              "#ffffff", "Cancel", true, ScanMode.DEFAULT);

          setState(() {
            _showPrompt(barcodeScanRes);
          });
        },
        child: Icon(FontAwesome5Solid.barcode),
      )
          : SizedBox(),
    );
  }

  _showPrompt(item) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Confirm'),
        content: new Text('Are you sure you want to add $item?'),
        actions: <Widget>[
          new TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          new TextButton(
            onPressed: (){
              Navigator.of(context).pop(false);
              _sendRequest(item);
              },
            child: new Text('Yes'),
          ),
        ],
      ),
    ) ??
        false;
  }


  Future<void> _sendRequest(item) async {
    showLoader(context, "Please wait...");


    try{

      Response response = await Dio(options).post(TASK_OUTPUT,
          data: {
            "task_id": widget.task.id,
            "output_value": item
          });
      dismissLoader(context);

      try{
        var loginResponse = jsonDecode(response.data);
        responseData = loginResponse;
      } catch(e){
        responseData = response.data;
      }

      if(responseData['code'] != '00'){
        showErrorMessage(context, "Something went wrong. Please try again");
        return;
      }

      showSuccessMessage(context, "You have accepted the task");
      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);

    }on DioError catch (e){
      print(e);
      dismissLoader(context);
      showErrorMessage(context, "Something went wrong. Please try again");

    }




  }
}
