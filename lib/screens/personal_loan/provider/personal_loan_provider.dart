import 'package:jovera_finance/utilities/api/api_abstract.dart';
import 'package:jovera_finance/utilities/constants/app_enums.dart';
import 'package:dio/dio.dart' as mp;

class PersonalLoanProvider {
  Future<void> applyPersonalLoan({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,
    required mp.FormData data,
  }) async {
    await ApiAbstract(apiName: '/api/leads/create-lead', formData: data).post(
      optionsEnum: OptionsEnum.auth,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
