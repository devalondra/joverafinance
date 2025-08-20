import 'package:jovera_finance/utilities/api/api_abstract.dart';
import 'package:jovera_finance/utilities/constants/app_enums.dart';
import 'package:dio/dio.dart' as mp;

class MainDrawerProvider {
  Future<void> editProfile({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,
    required mp.FormData data,
  }) async {
    await ApiAbstract(apiName: '/api/auth/update-profile', formData: data).put(
      optionsEnum: OptionsEnum.auth,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> changePassword({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,
    String? newPassword,

    String? currentPassword,
  }) async {
    await ApiAbstract(
      apiName: '/api/auth/change-password',
      data: {"newPassword": newPassword, "currentPassword": currentPassword},
    ).put(
      optionsEnum: OptionsEnum.auth,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> deleteAccount({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,

    String? reason,
  }) async {
    await ApiAbstract(
      apiName: '/api/auth/delete-account',
      data: {"reason": reason},
    ).delete(
      optionsEnum: OptionsEnum.auth,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
