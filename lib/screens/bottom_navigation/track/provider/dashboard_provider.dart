import 'package:jovera_finance/utilities/api/api_abstract.dart';
import 'package:jovera_finance/utilities/constants/app_enums.dart';

class DashboardProvider {
  Future<void> getMyVisaApplications({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,
  }) async {
    await ApiAbstract(apiName: '/api/leads/get-my-leads').get(
      optionsEnum: OptionsEnum.auth,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }

  Future<void> getLeadById({
    Function()? beforeSend,
    Function(dynamic response)? onSuccess,
    Function(dynamic error)? onError,
    required String leadId,
  }) async {
    print("/api/leads/get-my-lead/:$leadId");
    await ApiAbstract(apiName: "/api/leads/get-my-lead/$leadId").get(
      optionsEnum: OptionsEnum.auth,
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (response) => {if (onSuccess != null) onSuccess(response)},
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}
