import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
    baseUrl: "http://powerful-lowlands-50939.herokuapp.com/api",
    connectTimeout: 10000,
    receiveTimeout: 5000,
    );

const String LOGIN = '/login';
const String TASKS = '/tasks';
const String TASK_ACCEPT = '/task/accept';
const String TASK_OUTPUT = '/task/output';
