import 'package:jovera_finance/utilities/api/api_abstract.dart';
import 'package:jovera_finance/utilities/constants/app_enums.dart';
import 'package:dio/dio.dart' as mp;
class SignupProvider {
  Future<void> signup({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,
    required mp.FormData data,
    
  }) async {
    await ApiAbstract(apiName: '/api/auth/register', formData: data).post(
      optionsEnum: OptionsEnum.login,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> verifyOtp({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,
    String? otp,
    String? email,
  }) async {
    await ApiAbstract(
      apiName: '/api/auth/verify-otp',
      data: {"email": email, "otp": otp},
    ).post(
      optionsEnum: OptionsEnum.login,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> resendOtp({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,

    String? email,
  }) async {
    await ApiAbstract(
      apiName: '/api/auth/resend-otp',
      data: {"email": email},
    ).post(
      optionsEnum: OptionsEnum.login,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> secretLogin({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,
    String? password,
    String? email,
  }) async {
    await ApiAbstract(
      apiName: '/api/auth/login',
      data: {"identifier": email, "password": password},
    ).post(
      optionsEnum: OptionsEnum.login,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
