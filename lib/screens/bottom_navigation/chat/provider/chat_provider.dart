import 'package:jovera_finance/utilities/api/api_abstract.dart';
import 'package:jovera_finance/utilities/constants/app_enums.dart';
import 'package:dio/dio.dart' as mp;

class ChatProvider {
  Future<void> getAllMessages({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiAbstract(apiName: '/api/chat/messages').get(
      optionsEnum: OptionsEnum.auth,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> sendFile({
    required mp.FormData data,
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiAbstract(apiName: '/api/files/upload', formData: data).post(
      optionsEnum: OptionsEnum.auth,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
