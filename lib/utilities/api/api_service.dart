import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/auth/login/model/users.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_strings.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';

class ApiService {
  static final Dio httpClient = Dio();
  static String baseUrl = baseURL;
  AppLoadingController appLoadingController = AppLoadingController();

  Future<ApiService> init() async {
    return this;
  }

  String getEndPointURL(String apiName) {
    return '$baseUrl/$apiName';
  }

  Future<void> getUserDataByToken(String token) async {
    AuthManager authManager = Get.find();

    try {
      await httpClient
          .get('$baseUrl/api/auth/me', options: getApiOptionsWithAuth(token))
          .then((response) {
            if (response.statusCode == 200) {
              print(response);
              authManager.appUser.value = AppUser.fromJson(
                response.data,
              )..token = token;
              authManager.login();
            }
          });
    } on DioException {
      appTools.showErrorSnackBar(
        'Some thing went wrong. Please check your internet connection.',
        timer: 1,
      );
    }
  }

  Options loginApiOptions() {
    return Options(
      sendTimeout: Duration(milliseconds: 18 * 1000),
      receiveTimeout: Duration(milliseconds: 18 * 1000),
      responseType: ResponseType.plain,
      headers: {'accept': '*/*', 'Content-Type': 'application/json'},
    );
  }

  Options getApiOptionsWithAuth(String token) {
    return Options(
      sendTimeout: Duration(milliseconds: 18 * 1000),
      receiveTimeout: Duration(milliseconds: 18 * 1000),
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
}

Options getApiOptions() {
  return Options(
    headers: {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    },
  );
}
