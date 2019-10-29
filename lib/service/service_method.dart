import 'package:dio/dio.dart';
import 'dart:async';
import '../config/service_url.dart';
import 'dart:convert';

// 获取商品的信息
Future request(barcode) async{
  try {
    print('开始获取信息');
    Response response;
    Dio dio=new Dio();
    String barCode=barcode.toString();
    var data={"barcode":barCode};
    print(data);
    response=await dio.get(servicePath["getBookInfoByISBN"] + barCode);
    print(response.data['title']);
    print(response.toString());
    JsonDecoder decoder = new JsonDecoder();
    Map<String, dynamic> decoded = decoder.convert(response.toString());
    print(decoded['title']);
    return decoded;
  } catch (e) {
    return print('ERROR:=========>${e}');
  }
}