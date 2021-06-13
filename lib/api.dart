import 'package:dio/dio.dart';

BaseOptions options = new BaseOptions(
    baseUrl: "http://127.0.0.1:8000/api",
    connectTimeout: 10000,
    receiveTimeout: 5000,
    );

const String LOGIN = '/login';
