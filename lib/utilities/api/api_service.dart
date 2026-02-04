import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/auth/login/model/users.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/constants/app_strings.dart';
import 'package:jovera_finance/widgets/app_loading_controller.dart';

class ApiService {
  ApiService(this.ref);

  final Ref ref;
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
    final AuthManager authManager = ref.read(authManagerProvider.notifier);

    try {
      await httpClient
          .get('$baseUrl/api/auth/me', options: getApiOptionsWithAuth(token))
          .then((response) {
            if (kDebugMode) {
              print(response);
            }
            if (response.statusCode == 200) {
              if (kDebugMode) {
                print(response);
              }
              authManager.setUser(AppUser.fromJson(response.data)..token = token);
              authManager.login();
            }
          });
    } on DioException catch (e) {
      if (kDebugMode) print(e);
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

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(ref);
});

Options getApiOptions() {
  return Options(
    headers: {
      'accept': '*/*',
      'Content-Type': 'application/json',
      'Connection': 'keep-alive',
    },
  );
}
