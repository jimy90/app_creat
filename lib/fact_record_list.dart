import 'dart:convert';
import 'dart:js_util';

import 'package:app_creat/app_url.dart';
import 'package:app_creat/model_sample_file.dart';
import 'package:http/http.dart' as http;

class statesServices{

Future <Contries> FactRecordList ()async{

final response = await http.get(Uri.parse(appUrl.worldstatesApi));

if(response.statusCode==200){

var data = jsonDecode(response.body);

return Contries.fromJson(data);
}else{

 throw Exception('Error');
}
}


Future <List<dynamic>> ContriesListApi() async{
  var data;

final response = await http.get(Uri.parse(appUrl.countriesList));

if(response.statusCode==200){

 data = jsonDecode(response.body);

return data;


}else{

 throw Exception('Error');
}
}


  
}









