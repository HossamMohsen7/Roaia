import "dart:convert";
import "dart:io";

import "package:http/http.dart" as http;
import "package:roaia/models/api_result.dart";
import "package:roaia/models/login_response.dart";

class Api {
  const Api._();

  static const String baseUrl = 'http://www.roaiaofficial.somee.com';

  static Future<ApiResult<LoginResponse>> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/Auth/login'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      return ApiResult.success(
          LoginResponse.fromJson(jsonDecode(response.body)));
    } else {
      return ApiResult.error(response.body);
    }
  }

  static Future<ApiResult<LoginResponse>> register({
    required String firstName,
    required String lastName,
    required String username,
    required String email,
    required String password,
    required bool isAgree,
    required String id,
    File? image,
  }) async {
    final request =
        http.MultipartRequest("POST", Uri.parse('$baseUrl/api/Auth/register'));
    request.fields['FirstName'] = username;
    request.fields['LastName'] = email;
    request.fields['Username'] = password;
    request.fields['BlindId'] = id;
    request.fields['Email'] = email;
    request.fields['Password'] = password;
    request.fields['IsAgree'] = isAgree.toString();

    if (image != null) {
      request.files.add(http.MultipartFile.fromBytes(
          "ImageUrl", image.readAsBytesSync(),
          filename: image.path));
    }

    final response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200) {
      return ApiResult.success(
          LoginResponse.fromJson(jsonDecode(response.body)));
    } else {
      return ApiResult.error(response.body);
    }
  }

  static Future<ApiResult<void>> forgotPassword({
    required String email,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/Auth/SendOTPCode/$email'),
    );
    if (response.statusCode == 200) {
      return ApiResult.success(null);
    } else {
      return ApiResult.error(response.body);
    }
  }

  static Future<ApiResult<void>> checkOtp({
    required String email,
    required String otp,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/Auth/otbVerification'),
      body: jsonEncode({
        'email': email,
        'otpCode': otp,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return ApiResult.success(null);
    } else {
      return ApiResult.error(response.body);
    }
  }

  static Future<ApiResult<void>> resetPassword({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/Auth/resetPassword'),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return ApiResult.success(null);
    } else {
      return ApiResult.error(response.body);
    }
  }
}
