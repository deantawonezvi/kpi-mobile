import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:production_entry/api.dart';
import 'package:production_entry/images.dart';
import 'package:production_entry/models/auth-model.dart';
import 'package:production_entry/models/dto/response/tasks.dart';
import 'package:production_entry/pages/tasks/task.dart';
import 'package:production_entry/theme.dart';
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
  TasksResponse tasksResponse;

  void functionInitialise(BuildContext context) {
    setState(() {
      authModel = Provider.of<AuthModel>(context, listen: true);
    });
  }

  getPendingTasks() async {
    try {
      Response response = await Dio(options).post(TASKS,
          data: {
            "user_id": authModel.user.user.id,
          });
      print(response.data);
      return TasksResponse.fromJson(response.data);
    } catch(e){
      print(e);
    }



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
            Text('Tasks',textScaleFactor: 2,),
            FutureBuilder(
              future: getPendingTasks(),
                builder: (context,snapshot){
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: new Center(
                            child: SpinKitFadingCircle(
                              color: Colors.black,
                              size: 30.0,
                            )),
                      ),
                    );
                  }
                  else{
                    return ListView.builder(
                      itemCount: snapshot.data.tasks.length,
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 2,
                          shadowColor: Colors.yellow,
                          child: ListTile(
                            title: Row(
                              children: [
                                Text(snapshot.data.tasks[index].name),
                                Text("(${snapshot.data.tasks[index].status})",style: TextStyle(color: Colors.amber),),
                              ],
                            ),
                            subtitle: Text('Completion: ${((snapshot.data.tasks[index].outputs.length/int.parse(snapshot.data.tasks[index].expectedOutput))*100).toStringAsFixed(2)}%'),
                            trailing: Icon(Icons.arrow_forward_outlined),
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TaskViewPage(
                                            task: snapshot
                                                .data.tasks[index],
                                          )));

                            },
                          ),
                        );
                      },
                    );
                  }


            }),



          ],
        ),
      ),
    );
  }
}
