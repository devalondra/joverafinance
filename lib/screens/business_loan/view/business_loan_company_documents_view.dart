import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/business_loan/controller/business_loan_controller.dart';
import 'package:jovera_finance/screens/business_loan/view/business_loan_summary_view.dart';
import 'package:jovera_finance/screens/business_loan/widget/upload_document_widget.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class BusinessLoanCompanyDocumentsView extends GetView<BusinessLoanController> {
  const BusinessLoanCompanyDocumentsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Column(
        children: [
          Obx(
            () => Expanded(
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
                    filePath:
                        controller.tradeLicenseDocument.value.filePath ?? "",
                    isPdf:
                        controller.tradeLicenseDocument.value.fileName
                            ?.endsWith('pdf') ??
                        false,
                  ),
                  UploadDocumentWidget(
                    text: "Last 12 months Bank statement",
                    onTap:
                        () => controller.selectBankStatementDocument(context),
                    filePath:
                        controller.bankStatementDocument.value.filePath ?? "",
                    isPdf:
                        controller.bankStatementDocument.value.fileName
                            ?.endsWith('pdf') ??
                        false,
                  ),
                  UploadDocumentWidget(
                    text: "Memorandum",
                    onTap: () => controller.selectMemorandumDocument(context),
                    filePath:
                        controller.memorandumDocument.value.filePath ?? "",
                    isPdf:
                        controller.memorandumDocument.value.fileName?.endsWith(
                          'pdf',
                        ) ??
                        false,
                  ),
                ],
              ),
            ),
          ),

          CustomButton(
            onPressed: () {
              final missingDocuments = <String>[
                if (controller
                        .tradeLicenseDocument
                        .value
                        .filePath
                        ?.isNotEmpty !=
                    true)
                  "Trade License",
                if (controller
                        .bankStatementDocument
                        .value
                        .filePath
                        ?.isNotEmpty !=
                    true)
                  "Last 12 months Bank statement",
                if (controller.memorandumDocument.value.filePath?.isNotEmpty !=
                    true)
                  "Memorandum",
              ];

              if (missingDocuments.isNotEmpty) {
                appTools.showErrorSnackBar(
                  "Please upload the following documents: ${missingDocuments.join(', ')}",
                );
                return;
              }

              Get.to(() => BusinessLoanSummaryView());
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
