import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:production_entry/models/dto/response/tasks.dart';
import 'package:production_entry/widgets/buttonLoader.dart';

class TaskViewPage extends StatefulWidget {
  final Task task;

  const TaskViewPage({Key key, this.task}) : super(key: key);

  @override
  _TaskViewPageState createState() => _TaskViewPageState();
}

class _TaskViewPageState extends State<TaskViewPage> {
  var scannedItems = <String>[];

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.task.name),
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Task Details",
                textScaleFactor: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(),
            ),
            SizedBox(height: 20),

            //Text(((widget.task.outputs.length/widget.task.expectedOutput)*100).toStringAsFixed(2)+"%"),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Table(
                border: TableBorder.all(),
                columnWidths: {
                  0: FractionColumnWidth(.5),
                  1: FractionColumnWidth(.5)
                },
                children: [
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Task Name', textScaleFactor: 1.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.task.name, textScaleFactor: 1.3),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Assigned Date', textScaleFactor: 1.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.task.assignedDate.toLocal().toString(),
                          textScaleFactor: 1.3),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Expected Completion Time',
                          textScaleFactor: 1.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.task.expectedCompletionTime.toString(),
                          textScaleFactor: 1.3),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Expected Output', textScaleFactor: 1.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.task.expectedOutput.toString(),
                          textScaleFactor: 1.3),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Actual Output', textScaleFactor: 1.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.task.outputs.length.toString(),
                          textScaleFactor: 1.3),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Task Status', textScaleFactor: 1.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(widget.task.status, textScaleFactor: 1.3),
                    ),
                  ]),
                  TableRow(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Completion(%)', textScaleFactor: 1.3),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        ((widget.task.outputs.length /
                                        widget.task.expectedOutput) *
                                    100)
                                .toStringAsFixed(2) +
                            "%",
                        textScaleFactor: 1.3,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            SizedBox(height: 20),

            if (widget.task.startedDate == null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () async {
                            await _acceptTask();
                          },
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: isLoading
                          ? ButtonLoader()
                          : Text('Accept Task',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color(0XFF000000).withOpacity(0.8)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide.none)),
                    ),

                    /*color: Color(0XFF5E5E5E).withOpacity(0.8),
                                    elevation: 0,
                                    padding:
                                     EdgeInsets.only(top: 15, bottom: 15),
                                    shape:  RoundedRectangleBorder(
                                        borderRadius:
                                         BorderRadius.circular(30.0))*/
                  ),
                ),
              )
            else
              SizedBox(),
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

  _acceptTask() {}
}
