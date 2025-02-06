import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:admin_panel/config/storage/session_manager.dart';
import 'package:http/http.dart' as httpClient;
import 'package:logger/logger.dart';

import '../../core/exception/app_exception.dart';
import 'base_api_service.dart';

class NetworkService implements BaseApiService {
  var _logger = Logger();

  static const _BASE_URL = "https://logiculas.me/";

  @override
  Future<dynamic> callGetApi(String endpoint) async {
    final _token = await SessionManager().getToken();
    dynamic jsonResponse;
    try {
      final response = await httpClient.get(
        Uri.parse(_BASE_URL + endpoint),
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $_token",
        },
      ).timeout(const Duration(seconds: 60));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Time out try again');
    }
    return jsonResponse;
  }

  @override
  Future<dynamic> callPostApi(String endpoint, dynamic data) async {
    final _token = await SessionManager().getToken();
    dynamic jsonResponse;
    try {
      final response = await httpClient
          .post(Uri.parse(_BASE_URL + endpoint),
              headers: {
                "Accept": "application/json",
                "Authorization": "Bearer $_token",
                "Content-Type":
                    "application/json", // Important for JSON payloads
              },
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 60));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Time out try again');
    } catch (error) {
      _logger.e(error.toString());
      throw Exception("Something went wrong");
    }
    return jsonResponse;
  }


  @override
  Future callDeleteApi(String endpoint) async{
    final _token = await SessionManager().getToken();
    dynamic jsonResponse;
    try {
      final response = await httpClient
          .delete(Uri.parse(_BASE_URL + endpoint),
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $_token",
            "Content-Type":
            "application/json", // Important for JSON payloads
          })
          .timeout(const Duration(seconds: 60));
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw NoInternetException('');
    } on TimeoutException {
      throw FetchDataException('Time out try again');
    } catch (error) {
      _logger.e(error.toString());
      throw Exception("Something went wrong");
    }
    return jsonResponse;
  }

  dynamic returnResponse(httpClient.Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic responseData = jsonDecode(response.body);
      _logger.i("${response.statusCode}\n ${response.body}");
      return responseData;
    } else {
      dynamic responseData = jsonDecode(response.body);
      _logger.e("${response.statusCode}\n${response.body}");
      return responseData;
    }
  }

}
