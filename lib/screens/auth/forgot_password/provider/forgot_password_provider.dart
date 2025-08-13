import 'package:jovera_finance/utilities/api/api_abstract.dart';
import 'package:jovera_finance/utilities/constants/app_enums.dart';

class ForgotPasswordProvider {
  Future<void> forgotPassword({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,

    String? email,
  }) async {
    await ApiAbstract(
      apiName: '/api/users/forgot-password',
      data: {"email": email},
    ).post(
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
      apiName: '/api/users/verify-otp',
      data: {"email": email, "otp": otp},
    ).post(
      optionsEnum: OptionsEnum.login,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> createNewPassword({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,
    String? newPassword,
    String? email,
    String? resetPasswordToken,
  }) async {
   
    await ApiAbstract(
      apiName: '/api/users/reset-password',
      data: {
        "email": email,
        "newPassword": newPassword,
        "resetPasswordToken": resetPasswordToken,
      },
    ).post(
      optionsEnum: OptionsEnum.login,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

}
