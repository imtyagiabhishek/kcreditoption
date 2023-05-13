import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as Http;
import '../model/error_response.dart';
import '../utils/app_constants.dart';

class ApiClient extends GetxService {
  final String appBaseUrl;
  final SharedPreferences sharedPreferences;
  static const String noInternetMessage =
      'Connection to API server failed due to internet connection';
  final int timeoutInSeconds = 30;

  String? token;
  Map<String, String>? _mainHeaders;

  ApiClient({required this.appBaseUrl, required this.sharedPreferences}) {
    token = sharedPreferences.getString(AppConstants.TOKEN).toString();
    debugPrint('Token: $token');
    updateHeader(token!);
  }

  void updateHeader(String token) {
    _mainHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $token'
    };
  }

  Future<Response> getData(String uri) async {
    try {
      // if(Foundation.kDebugMode) {
      token = sharedPreferences.getString(AppConstants.TOKEN).toString();
      print('====> API Call: $uri\nToken: $token');
      _mainHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };
      print(_mainHeaders);
      // }
      Http.Response _response = await Http.get(
        Uri.parse(appBaseUrl + uri),
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      // if(Foundation.kDebugMode) {
      print(
          '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      // }
      return response;
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postEmailData(dynamic body) async {
    try {
      print(_mainHeaders);
      print(jsonEncode(body));
      Http.Response _response = await Http.post(
        Uri.parse("https://rozgarhai.com/email/api/basic_email"),
        body: jsonEncode(body),
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      // if(Foundation.kDebugMode) {
      print('====> API Response: [${response.statusCode}] \n${response.body}');
      // }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postData(String? uri, dynamic body) async {
    try {
      token = sharedPreferences.getString(AppConstants.TOKEN).toString();
      _mainHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };
      print(_mainHeaders);
      print(jsonEncode(body));
      Http.Response _response = await Http.post(
        Uri.parse(appBaseUrl + uri!),
        body: jsonEncode(body),
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      // if(Foundation.kDebugMode) {
      print(
          '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      // }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> patchData(String uri, dynamic body) async {
    try {
      token = sharedPreferences.getString(AppConstants.TOKEN).toString();
      print('====> API Call: $uri\nToken: $token');
      _mainHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };
      print(jsonEncode(body).toString());
      print(_mainHeaders);
      Http.Response _response = await Http.patch(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      print(_response.body.toString());
      Response response = handleResponse(_response);
      // if(Foundation.kDebugMode) {
      print(
          '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      // }
      return response;
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postMultipartData(String uri, Map<String, String> body,
      List<MultipartBody> multipartBody) async {
    try {
      if (Foundation.kDebugMode) {
        token = sharedPreferences.getString(AppConstants.TOKEN).toString();
        print('====> API Call: $uri\nToken: $token');
        _mainHeaders = {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        };
        print(_mainHeaders);
      }
      Http.MultipartRequest _request =
          Http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      _request.headers.addAll(_mainHeaders!);
      for (MultipartBody multipart in multipartBody) {
        if (multipart.file != null) {
          if (Foundation.kIsWeb) {
            Uint8List _list = await multipart.file.readAsBytes();
            Http.MultipartFile _part = Http.MultipartFile(
              multipart.key,
              multipart.file.readAsBytes().asStream(),
              _list.length,
              filename: basename(multipart.file.path),
              contentType: MediaType('image', 'jpg'),
            );
            _request.files.add(_part);
          } else {
            File _file = File(multipart.file.path);
            _request.files.add(Http.MultipartFile(
              multipart.key,
              _file.readAsBytes().asStream(),
              _file.lengthSync(),
              filename: _file.path.split('/').last,
            ));
          }
        }
      }
      _request.fields.addAll(body);
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        print(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return const Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postImageData(
      String uri, MultipartBody multipartBody) async {
    try {
      token = sharedPreferences.getString(AppConstants.TOKEN).toString();

      _mainHeaders = {
        // 'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
        print(_mainHeaders);
      }
      var _request = Http.MultipartRequest('PUT', Uri.parse(appBaseUrl + uri));
      _request.headers.addAll(_mainHeaders!);
      //  for(MultipartBody multipart in multipartBody) {
      if (multipartBody.file != null) {
        if (Foundation.kIsWeb) {
          Uint8List _list = await multipartBody.file.readAsBytes();
          Http.MultipartFile _part = Http.MultipartFile(
            multipartBody.key,
            multipartBody.file.readAsBytes().asStream(),
            _list.length,
            filename: basename(multipartBody.file.path),
            contentType: MediaType('image', 'jpg'),
          );
          _request.files.add(_part);
        } else {
          File _file = File(multipartBody.file.path);
          print(multipartBody.file.path);
          print(multipartBody.key);
          /*Http.MultipartFile.fromPath(multipartBody.key, _file.path ).then((value) =>
                _request.files.add( value));*/

          _request.files.add(Http.MultipartFile(multipartBody.key,
              _file.readAsBytes().asStream(), _file.lengthSync(),
              filename: _file.path.split('/').last,
              contentType: MediaType('image', 'jpeg')));
        }
      }
      //  }
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        print(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> postImageData2(
      String uri, MultipartBody multipartBody) async {
    try {
      token = sharedPreferences.getString(AppConstants.TOKEN).toString();

      _mainHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
        print(_mainHeaders);
      }
      Http.MultipartRequest _request =
          Http.MultipartRequest('POST', Uri.parse(appBaseUrl + uri));
      _request.headers.addAll(_mainHeaders!);
      //  for(MultipartBody multipart in multipartBody) {
      if (multipartBody.file != null) {
        if (Foundation.kIsWeb) {
          Uint8List _list = await multipartBody.file.readAsBytes();
          Http.MultipartFile _part = Http.MultipartFile(
            multipartBody.key,
            multipartBody.file.readAsBytes().asStream(),
            _list.length,
            filename: basename(multipartBody.file.path),
            contentType: MediaType('image', 'jpg'),
          );
          _request.files.add(_part);
        } else {
          File _file = File(multipartBody.file.path);
          _request.files.add(Http.MultipartFile(
            multipartBody.key,
            _file.readAsBytes().asStream(),
            _file.lengthSync(),
            filename: _file.path.split('/').last,
          ));
        }
      }
      //  }
      Http.Response _response =
          await Http.Response.fromStream(await _request.send());
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        print(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData(String uri, dynamic body) async {
    try {
      token = sharedPreferences.getString(AppConstants.TOKEN).toString();
      print('====> API Call: $uri\nToken: $token');
      _mainHeaders = {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      };
      print(_mainHeaders);

      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl + uri),
        body: jsonEncode(body),
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        print(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> putData2(String uri) async {
    try {
      print('====> API Call: $uri\nToken: $token');

      Http.Response _response = await Http.put(
        Uri.parse(appBaseUrl + uri),
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        print(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Future<Response> deleteData(String uri) async {
    try {
      if (Foundation.kDebugMode) {
        print('====> API Call: $uri\nToken: $token');
      }
      Http.Response _response = await Http.delete(
        Uri.parse(appBaseUrl + uri),
        headers: _mainHeaders,
      ).timeout(Duration(seconds: timeoutInSeconds));
      Response response = handleResponse(_response);
      if (Foundation.kDebugMode) {
        print(
            '====> API Response: [${response.statusCode}] $uri\n${response.body}');
      }
      return response;
    } catch (e) {
      return Response(statusCode: 1, statusText: noInternetMessage);
    }
  }

  Response handleResponse(Http.Response response) {
    dynamic _body;
    try {
      _body = jsonDecode(response.body);
    } catch (e) {}
    Response _response = Response(
      body: _body != null ? _body : response.body,
      bodyString: response.body.toString(),
      headers: response.headers,
      statusCode: response.statusCode,
      statusText: response.reasonPhrase,
    );
    if (_response.statusCode != 200 &&
        _response.body != null &&
        _response.body is! String) {
      if (_response.body.toString().startsWith('{"statusCode":')) {
        Errors _errorResponse = Errors.fromJson(_response.body);
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _errorResponse.message);
      } else if (_response.body.toString().startsWith('{message')) {
        _response = Response(
            statusCode: _response.statusCode,
            body: _response.body,
            statusText: _response.body['message']);
      }
    } else if (_response.statusCode != 200 && _response.body == null) {
      _response = Response(statusCode: 0, statusText: noInternetMessage);
    }
    return _response;
  }
}

class MultipartBody {
  String key;
  XFile file;

  MultipartBody(this.key, this.file);
}
