// ignore_for_file: deprecated_member_use

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as mp;
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_enums.dart';
import 'package:jovera_finance/utilities/constants/app_strings.dart';

class ApiAbstract {
  final String url = baseURL;
  final String apiName;
  final Map<String, dynamic>? data;
  final String? singleValue;
  final mp.FormData? formData;
  final Map<String, dynamic>? queryParameters;

  final AuthManager authManager = Get.find();

  ApiAbstract({
    required this.apiName,
    this.data,
    this.formData,
    this.singleValue,
    this.queryParameters,
  });

  String get getEndPointURL => '$url$apiName';
  Dio _dio() {
    return Dio();
  }

  Future<void> get({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
    CancelToken? cancelToken,
    OptionsEnum? optionsEnum,
  }) async {
    try {
      await _dio()
          .get(
            getEndPointURL,
            options: getOptions(optionsEnum),
            queryParameters: queryParameters,
            data: data,
            cancelToken: cancelToken,
          )
          .then((response) {
            if (onSuccess != null) onSuccess(response);
          });
    } on DioError catch (error) {
      if (error.response != null) {
        if (error.response?.statusCode == 400) {
          if (authManager.isLogged.value) {
            if (onError != null) onError(error);
            // await authManager.logOut();
            // appTools.showErrorSnackBar('pleaseSignIn'.tr);
          } else {
            if (onError != null) onError(error);
          }
        } else {
          if (onError != null) onError(error);
        }
      } else {
        if (onError != null) onError(error);
      }
    }
  }

  Future<void> post({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
    CancelToken? cancelToken,
    OptionsEnum? optionsEnum,
  }) async {
    debugPrint(getEndPointURL);
    try {
      beforeSend?.call();
      await _dio()
          .post(
            getEndPointURL,
            data: singleValue ?? formData ?? data,
            queryParameters: queryParameters,
            options: getOptions(
              optionsEnum,
              fcm: await appTools.getFCMTokenForDevice(),
            ),
            cancelToken: cancelToken,
          )
          .then((response) {
            if (onSuccess != null) onSuccess(response);
          });
    } on DioError catch (error) {
      if (error.response != null) {
        if (error.response?.statusCode == 401) {
          if (onError != null) onError(error);
        } else {
          if (onError != null) onError(error);
        }
      } else {
        if (onError != null) onError(error);
      }
    } finally {}
  }

  Future<void> patch({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
    CancelToken? cancelToken,
    OptionsEnum? optionsEnum,
  }) async {
    debugPrint(getEndPointURL);
    try {
      beforeSend?.call();
      await _dio()
          .patch(
            getEndPointURL,
            data: singleValue ?? formData ?? data,
            queryParameters: queryParameters,
            options: getOptions(
              optionsEnum,
              fcm: await appTools.getFCMTokenForDevice(),
            ),
            cancelToken: cancelToken,
          )
          .then((response) {
            if (onSuccess != null) onSuccess(response);
          });
    } on DioError catch (error) {
      if (error.response != null) {
        if (error.response?.statusCode == 401) {
          if (onError != null) onError(error);
        } else {
          if (onError != null) onError(error);
        }
      } else {
        if (onError != null) onError(error);
      }
    } finally {}
  }

  Future<void> delete({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
    CancelToken? cancelToken,
    OptionsEnum? optionsEnum,
  }) async {
    debugPrint(getEndPointURL);
    try {
      beforeSend?.call();
      await _dio()
          .delete(
            getEndPointURL,
            data: singleValue ?? formData ?? data,
            queryParameters: queryParameters,
            options: getOptions(
              optionsEnum,
              fcm: await appTools.getFCMTokenForDevice(),
            ),
            cancelToken: cancelToken,
          )
          .then((response) {
            if (onSuccess != null) onSuccess(response);
          });
    } on DioError catch (error) {
      if (error.response != null) {
        if (error.response?.statusCode == 401) {
          if (onError != null) onError(error);
        } else {
          if (onError != null) onError(error);
        }
      } else {
        if (onError != null) onError(error);
      }
    } finally {}
  }

  Future<void> put({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
    CancelToken? cancelToken,
    OptionsEnum? optionsEnum,
  }) async {
    try {
      debugPrint(getEndPointURL.toString());
      debugPrint(
        (queryParameters ?? singleValue ?? formData ?? data).toString(),
      );
      await _dio()
          .put(
            getEndPointURL,
            data: singleValue ?? formData ?? data,

            queryParameters: queryParameters,
            options: getOptions(optionsEnum),
            cancelToken: cancelToken,
          )
          .then((response) {
            if (onSuccess != null) onSuccess(response);
          });
    } on DioError catch (error) {
      if (error.response != null) {
        if (error.response?.statusCode == 401) {
        } else {
          appTools.showErrorSnackBar(
            appTools.errorMessage(error) ?? 'Opps, Something went wrong',
            timer: 1,
          );
          if (onError != null) onError(error);
        }
      } else {
        if (onError != null) onError(error);
      }
    }
  }

  // Future<void> delete({
  //   Function()? beforeSend,
  //   Function(dynamic data)? onSuccess,
  //   Function(dynamic error)? onError,
  //   CancelToken? cancelToken,
  //   OptionsEnum? optionsEnum,
  // }) async {
  //   callApi(
  //     () async {
  //       await _dio()
  //           .delete(
  //             getEndPointURL,
  //             data: singleValue ?? formData ?? data,
  //             options: getOptions(optionsEnum),
  //             cancelToken: cancelToken,
  //           )
  //           .then((response) {
  //             if (onSuccess != null) onSuccess(response);
  //           });
  //     },
  //     beforeSend: beforeSend,
  //     cancelToken: cancelToken,
  //     onError: onError,
  //     onSuccess: onSuccess,
  //     optionsEnum: optionsEnum,
  //   );
  // }

  Future<void> callApi(
    Function func, {
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
    CancelToken? cancelToken,
    OptionsEnum? optionsEnum,
  }) async {
    try {
      func();
    } on DioError catch (error) {
      if (error.response != null) {
        if (error.response?.statusCode == 401) {
          if (authManager.isLogged.value) {
            // await authManager.logOut();
            // appTools.showErrorSnackBar('pleaseSignIn'.tr);
          } else {
            if (onError != null) onError(error);
          }
        } else {
          if (onError != null) onError(error);
        }
      } else {
        if (onError != null) onError(error);
      }
    }
  }

  Options apiOptionsWithAuth({String? fcm}) {
    return Options(
      headers: {
        'fcmToken': fcm,
        'Authorization': 'Bearer ${authManager.getToken()}',
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
    );
  }

  Options apiOptionsForgetPassword({String? fcm}) {
    return Options(
      headers: {
        'fcmToken': fcm,
        'Authorization': 'Bearer ${authManager.getToken()}',
        'Accept-Language': 'ar',
      },
    );
  }

  Options apiOptions({String? fcm}) {
    return Options(
      // sendTimeout: 30,
      // receiveTimeout: 30,
      headers: {
        'fcmToken': fcm,
        'accept': '/',
        'Content-Type': 'application/json-patch+json',
      },
    );
  }

  Options? getOptions(OptionsEnum? optionsEnum, {String? fcm}) {
    switch (optionsEnum) {
      case OptionsEnum.auth:
        return apiOptionsWithAuth(fcm: fcm);
      case OptionsEnum.loginOtp:
        return apiOptionsForgetPassword(fcm: fcm);

      case OptionsEnum.login:
        return loginApiOptions();

      case OptionsEnum.normal:
        return apiOptions(fcm: fcm);
      default:
        return null;
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
}
