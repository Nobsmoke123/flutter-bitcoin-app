import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkService {

    NetworkService({ @required this.url });

    final String url;

    Future<dynamic> getData() async{
        try{
            http.Response response =  await http.get(this.url);
//        Check for the status code
            if(response.statusCode == 200){
                String data = response.body;
                var decodedData = jsonDecode(data);
                return decodedData;
            }else{
                print('Something went wrong in the networking class');
                print(response.statusCode);
            }
        }catch(e){
            print('An error occurred $e');
        }
    }
}