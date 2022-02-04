
import 'package:http/http.dart' as http;

class Repository{

var url = "https://nigerianbanks.xyz";

httpget() async{
  return await http.get(Uri.parse(url));
}

 // String _baseURL = "http://192.168.43.95:9000/api";
  String _baseURL = "https://app.farmerstable.store/api";
 //String _baseURL = "http://farm.burujtech.com/api";
 

  httpGet(String apiEndpoint) async{

    return await http.get(Uri.parse(_baseURL + "/" + apiEndpoint));
}

  httpPost(String apiEndpoint, data) async{

    return await http.post(Uri.parse(_baseURL + "/" + apiEndpoint), body:data);
  }

}



