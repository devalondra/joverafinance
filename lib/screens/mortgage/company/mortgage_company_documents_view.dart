import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/mortgage/controller/mortgage_controller.dart';
import 'package:jovera_finance/screens/mortgage/common/property_details_view.dart';
import 'package:jovera_finance/screens/mortgage/widget/upload_document_widget.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class MortgageCompanyDocumentsView extends GetView<MortgageController> {
  const MortgageCompanyDocumentsView({super.key});

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
                    onTap: () => controller.selectTradeLicenseDocument(context),
                    text: "Trade License",
                    filePath:
                        controller.tradeLicenseDocument.value.filePath ?? "",
                    isPdf:
                        controller.tradeLicenseDocument.value.fileName
                            ?.endsWith('pdf') ??
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
                    text: "Etihad Bureau + Company",
                    onTap: () => controller.selectEtihadDocument(context),
                    filePath:
                        controller.etihadBureauDocument.value.filePath ?? "",
                    isPdf:
                        controller.etihadBureauDocument.value.fileName
                            ?.endsWith('pdf') ??
                        false,
                  ),
                  UploadDocumentWidget(
                    text: "Last 4 VAT Payments",
                    onTap: () => controller.selectVATDocument(context),
                    filePath:
                        controller.fourVATPaymentsDocument.value.filePath ?? "",
                    isPdf:
                        controller.fourVATPaymentsDocument.value.fileName
                            ?.endsWith('pdf') ??
                        false,
                  ),
                ],
              ),
            ),
          ),

          CustomButton(
            onPressed: () {
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
