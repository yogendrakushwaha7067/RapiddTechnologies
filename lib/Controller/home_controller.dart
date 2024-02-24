import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../Model/course_model.dart';

class HomeController extends GetxController{
  List<CourseModel> listcourse=[];
 // CourseModel courseModel=CourseModel();
  bool isdataloading=false;

  getCourse() async {
    var request = http.Request('GET', Uri.parse('https://fakestoreapi.com/products?limit=5'));

    isdataloading=true;
    update();
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     // print(jsonDecode(await response.stream.bytesToString()));
      // for(var i in jsonDecode(await response.stream.bytesToString())){
      //   print("${i}");
      // }
      //courseModel=CourseModel.fromJson(jsonDecode(await response.stream.bytesToString()));

      jsonDecode(await response.stream.bytesToString()).forEach((i){

      listcourse.add(CourseModel.fromJson(i));
      });
      isdataloading=false;
      update();
    }
    else {
    print(response.reasonPhrase);
    isdataloading=false;
    update();
    }

  }


  getCourse1() async {
    var request = http.Request('GET', Uri.parse('https://fakestoreapi.com/products?limit=5'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(jsonDecode(await response.stream.bytesToString()));
      // for(var i in jsonDecode(await response.stream.bytesToString())){
      //   print("${i}");
      // }
      //courseModel=CourseModel.fromJson(jsonDecode(await response.stream.bytesToString()));

      jsonDecode(await response.stream.bytesToString()).forEach((i){

        listcourse.add(CourseModel.fromJson(i));
      });

    }
    else {
      print(response.reasonPhrase);

    }

  }


}