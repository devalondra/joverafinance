import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/business_loan/controller/business_loan_controller.dart';
import 'package:jovera_finance/screens/business_loan/view/business_loan_summary_view.dart';
import 'package:jovera_finance/screens/business_loan/widget/upload_document_widget.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_tools.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/navigation/app_navigator.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class BusinessLoanCompanyDocumentsView extends ConsumerWidget {
  const BusinessLoanCompanyDocumentsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(businessLoanControllerProvider.notifier);
    ref.watch(businessLoanControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                CustomPageTitle(
                  back: true,
                  notification: false,
                  title: "Company Information",
                ),
                SizedBox(height: fullHeight * 0.05),
                UploadDocumentWidget(
                  text: "Trade License",
                  onTap: () => controller.selectTradeLicenseDocument(context),
                  filePath: controller.tradeLicenseDocument.filePath ?? "",
                  isPdf:
                      controller.tradeLicenseDocument.fileName?.endsWith(
                        'pdf',
                      ) ??
                      false,
                ),
                UploadDocumentWidget(
                  text: "Last 12 months Bank statement",
                  onTap: () => controller.selectBankStatementDocument(context),
                  filePath: controller.bankStatementDocument.filePath ?? "",
                  isPdf:
                      controller.bankStatementDocument.fileName?.endsWith(
                        'pdf',
                      ) ??
                      false,
                ),
                UploadDocumentWidget(
                  text: "Memorandum",
                  onTap: () => controller.selectMemorandumDocument(context),
                  filePath: controller.memorandumDocument.filePath ?? "",
                  isPdf:
                      controller.memorandumDocument.fileName?.endsWith('pdf') ??
                      false,
                ),
              ],
            ),
          ),

          CustomButton(
            onPressed: () {
              final missingDocuments = <String>[
                if (controller
                        .tradeLicenseDocument
                        .filePath
                        ?.isNotEmpty !=
                    true)
                  "Trade License",
                if (controller
                        .bankStatementDocument
                        .filePath
                        ?.isNotEmpty !=
                    true)
                  "Last 12 months Bank statement",
                if (controller.memorandumDocument.filePath?.isNotEmpty !=
                    true)
                  "Memorandum",
              ];

              if (missingDocuments.isNotEmpty) {
                appTools.showErrorSnackBar(
                  "Please upload the following documents: ${missingDocuments.join(', ')}",
                );
                return;
              }

              AppNavigator.push(const BusinessLoanSummaryView());
            },
            text: "Next",
          ),
          SizedBox(height: fullHeight * 0.05),
        ],
      ).paddingSymmetric(
        horizontal: horizontalPagePadding,
        vertical: verticalPagePadding,
      ),
    );
  }
}
