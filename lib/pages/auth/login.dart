import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:production_entry/api.dart';
import 'package:production_entry/images.dart';
import 'package:production_entry/models/auth-model.dart';
import 'package:production_entry/models/user.dart';
import 'package:production_entry/widgets/buttonLoader.dart';
import 'package:production_entry/widgets/popUp.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  bool passwordVisible = false;
  bool authenticationStatus = false;
  final formKey = GlobalKey<FormState>();
  final mEmailController = TextEditingController();
  final mPasswordController = TextEditingController();
  final mEmailFocusNode = FocusNode();
  final mPasswordFocusNode = FocusNode();
  String mEmail, mPassword;
  var responseData;
  AuthModel _authModel = new AuthModel();

  User _authenticatedUser;
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
    final _auth = Provider.of<AuthModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Image.asset(
                    logo,
                    width: 200,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 1,
                      textInputAction: TextInputAction.next,
                      focusNode: mEmailFocusNode,
                      autovalidate: mEmailController.text.length > 0,
                      onFieldSubmitted: (val) {
                        mEmailFocusNode.unfocus();
                        FocusScope.of(context).requestFocus(mPasswordFocusNode);
                      },
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.black),
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(),
                          )),
                      onSaved: (val) => mEmail = val,
                      validator: (val) {
                        if (val.length == 0) {
                          return "Email cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      controller: mEmailController),
                  SizedBox(height: 20),
                  TextFormField(
                      obscureText: !passwordVisible,
                      focusNode: mPasswordFocusNode,
                      controller: mPasswordController,
                      autovalidate: mPasswordController.text.length > 0,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: _login,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black),
                          border: new OutlineInputBorder(
                            borderSide: new BorderSide(),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              !passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              // Update the state i.e. toggle the state of passwordVisible variable
                              setState(() {
                                passwordVisible = !passwordVisible;
                              });
                            },
                          )),
                      onSaved: (val) => mPassword = val,
                      validator: (val) {
                        if (val.length == 0) {
                          return "Password cannot be empty";
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () async {
                        await _login();

                      },
                      child: Padding(
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        child: isLoading
                            ? ButtonLoader()
                            : Text('Login',
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
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    FocusScope.of(context).unfocus();

    setState(() {
      isLoading = true;
    });

    try{
      var buildInfo = await DeviceInfoPlugin().androidInfo;
      var model = buildInfo.model;
      var manufacturer = buildInfo.brand;
      var imei = await ImeiPlugin.getImei();
      Response response = await Dio(options).post(LOGIN,
          data: {
            "email": mEmail,
            "password": mPassword
          });
      setState(() {
        isLoading = false;
      });

      try{
        var loginResponse = jsonDecode(response.data);
        responseData = loginResponse;
      } catch(e){
        responseData = response.data;
      }

      if(responseData['code'] != '00'){
        showErrorMessage(context, responseData['description']??responseData['message']);
        return;
      }
      setState(() {
        authenticationStatus = true;
        _authenticatedUser = User.fromJson(response.data);
        authModel.login(user: _authenticatedUser);
      });
    }on DioError catch (e){
      print(e);
      setState(() {
        isLoading = false;
      });
      showErrorMessage(context, "Something went wrong. Please try again");

    }
  }
}
