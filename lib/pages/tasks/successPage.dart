import 'package:flutter/material.dart';

class SuccessPage extends StatefulWidget {
  const SuccessPage({Key key}) : super(key: key);

  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Success"),
        brightness: Brightness.dark,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Icon(Icons.check_circle, color: Colors.green,size: 30,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Success!!',textScaleFactor: 3,),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamedAndRemoveUntil(context, '/home', (_) => false);

                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 15),
                      child: Text('DONE',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 17.0,
                              fontWeight: FontWeight.bold)),
                    ),
                    style: ButtonStyle(

                      backgroundColor:
                      MaterialStateProperty.all<Color>(
                          Color(0XFF000000).withOpacity(0.8)),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(5.0),
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
              ),

            ],
          ),
        ),
      ),
    );
  }
}
