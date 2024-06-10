import 'package:dio/dio.dart';

class TestProvider {

  Future<String> getTest() async {
    var dio = Dio();
    final response = await dio.get('https://localhost:7214/test');
    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      throw Exception('Failed to load data');
    }
  }

}