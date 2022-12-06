import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../shared/constants.dart';

class MoviesApi {
  Future<Map<String, dynamic>> getMoviesApi() async {
    String url = "${baseUrl}popular?api_key=$tmdbKey";

    var headers = {
      "Content-Type": "application/json",
    };
    try {
      var response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 30));
      if (response.statusCode != 200) {
        return {"Err_Flag": true, "Message": "Something went wrong"};
      }
      return {"Err_Flag": false, "Values": response.body};
    } on TimeoutException {
      return {"Err_Flag": true, "Message": "Server Time out"};
    } on SocketException {
      return {"Err_Flag": true, "Message": "No internet access"};
    } catch (e) {
      return {"Err_Flag": true, "Message": "Something went wrong"};
    }
  }
  Future<Map<String, dynamic>> getMovieDetailsApi(String id) async {
    String url = "${baseUrl}$id?api_key=$tmdbKey";

    var headers = {
      "Content-Type": "application/json",
    };
    try {
      var response = await http
          .get(Uri.parse(url), headers: headers)
          .timeout(const Duration(seconds: 30));
      if (response.statusCode != 200) {
        return {"Err_Flag": true, "Message": "Something went wrong"};
      }
      return {"Err_Flag": false, "Values": response.body};
    } on TimeoutException {
      return {"Err_Flag": true, "Message": "Server Time out"};
    } on SocketException {
      return {"Err_Flag": true, "Message": "No internet access"};
    } catch (e) {
      return {"Err_Flag": true, "Message": "Something went wrong"};
    }
  }
}
