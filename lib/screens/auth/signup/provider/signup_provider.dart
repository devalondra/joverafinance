import 'package:jovera_finance/utilities/api/api_abstract.dart';
import 'package:jovera_finance/utilities/constants/app_enums.dart';

class SignupProvider {
  Future<void> signup({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,
    required Map<String,dynamic> data,
  }) async {
    await ApiAbstract(apiName: '/api/users/signup', data: data).post(
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
      apiName: '/api/users/verify-email-otp',
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
      apiName: '/api/users/resend-otp',
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
      apiName: '/api/users/signin',
      data: {"email": email, "password": password},
    ).post(
      optionsEnum: OptionsEnum.login,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
