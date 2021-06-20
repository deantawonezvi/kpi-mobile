import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:production_entry/models/dto/response/tasks.dart';

class TaskOutputPage extends StatefulWidget {
  final Task task;
  const TaskOutputPage({Key key, this.task}) : super(key: key);

  @override
  _TaskOutputPageState createState() => _TaskOutputPageState();
}

class _TaskOutputPageState extends State<TaskOutputPage> {
  var scannedItems = <String>[];

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
            scannedItems.add(barcodeScanRes);
          });
        },
        child: Icon(FontAwesome5Solid.barcode),
      )
          : SizedBox(),
    );
  }
}
