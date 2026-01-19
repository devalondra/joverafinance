import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/screens/mortgage/common/property_details_view.dart';
import 'package:jovera_finance/screens/mortgage/widget/upload_document_widget.dart';
import 'package:jovera_finance/utilities/authentication/auth_manager.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class MortgagePersonalDocumentsView extends GetView<MortgageController> {
  const MortgagePersonalDocumentsView({super.key});

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
                    title: "Required Documents",
                  ),
                  SizedBox(height: fullHeight * 0.05),
                  UploadDocumentWidget(
                    onTap: () => controller.selectPassportDocument(context),
                    text: "Passport",
                    filePath: controller.passportDocument.value.filePath ?? "",
                    isPdf:
                        controller.passportDocument.value.fileName?.endsWith(
                          'pdf',
                        ) ??
                        false,
                  ),
                  UploadDocumentWidget(
                    onTap: () => controller.selectEmiratesIdDocument(context),
                    text: "Emirates ID",
                    filePath:
                        controller.emiratesIdDocument.value.filePath ?? "",
                    isPdf:
                        controller.emiratesIdDocument.value.fileName?.endsWith(
                          'pdf',
                        ) ??
                        false,
                  ),

                  UploadDocumentWidget(
                    onTap:
                        () =>
                            controller.selectSalaryCertificateDocument(context),
                    text: "Valid Salary Certificate",
                    filePath:
                        controller.salaryCertificateDocument.value.filePath ??
                        "",
                    isPdf:
                        controller.salaryCertificateDocument.value.fileName
                            ?.endsWith('pdf') ??
                        false,
                  ),
                  UploadDocumentWidget(
                    text: "Last 6 months Bank statement",
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
                    text: "Credit Bureau Report",
                    onTap: () => controller.selectEtihadDocument(context),
                    filePath:
                        controller.etihadBureauDocument.value.filePath ?? "",
                    isPdf:
                        controller.etihadBureauDocument.value.fileName
                            ?.endsWith('pdf') ??
                        false,
                  ),
                ],
              ),
            ),
          ),

          CustomButton(
            onPressed: () {
              final missingDocuments = <String>[
                if (controller.passportDocument.value.filePath?.isNotEmpty !=
                    true)
                  "Passport",
                if (controller.emiratesIdDocument.value.filePath?.isNotEmpty !=
                    true)
                  "Emirates ID",
                if (controller
                        .salaryCertificateDocument
                        .value
                        .filePath
                        ?.isNotEmpty !=
                    true)
                  "Valid Salary Certificate",
                if (controller
                        .bankStatementDocument
                        .value
                        .filePath
                        ?.isNotEmpty !=
                    true)
                  "Last 6 months Bank statement",
                if (controller
                        .etihadBureauDocument
                        .value
                        .filePath
                        ?.isNotEmpty !=
                    true)
                  "Credit Bureau Report",
              ];

              if (missingDocuments.isNotEmpty) {
                appTools.showErrorSnackBar(
                  "Please upload the following documents: ${missingDocuments.join(', ')}",
                );
                return;
              }

              Get.to(() => PropertyDetailsView());
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
