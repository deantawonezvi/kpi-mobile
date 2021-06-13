import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:production_entry/images.dart';
import 'package:production_entry/models/auth-model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning,';
    }
    if (hour < 17) {
      return 'Good afternoon,';
    }
    return 'Good evening,';
  }

  var scannedItems = <String>[];

  AuthModel authModel;

  void functionInitialise(BuildContext context) {
    setState(() {
      authModel = Provider.of<AuthModel>(context, listen: true);
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    functionInitialise(context);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Home'),
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            Center(child: Image.asset(logo, width: size.width * 0.4)),
            SizedBox(height: 20),
            Text(greeting()+" "+authModel.user.user.name, textScaleFactor: 1.6,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Divider(thickness: 2,),
            ),
            ListView.builder(
              itemCount: scannedItems.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("Item"),
                    subtitle: Text('${scannedItems[index]}'),
                    onTap: (){
                      print("Send Item");
                    },
                  ),
                );
              },
            )


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
              "#ffffff",
              "Cancel",
              true,
              ScanMode.DEFAULT);

          setState(() {
            scannedItems.add(barcodeScanRes);
          });
        },
        child: Icon(FontAwesome5Solid.barcode),
      ),
    );
  }
}
