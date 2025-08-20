import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/business_loan/controller/business_loan_controller.dart';
import 'package:jovera_finance/screens/business_loan/view/business_loan_company_documents_view.dart';
import 'package:jovera_finance/screens/business_loan/widget/upload_document_widget.dart';

import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/custom_button.dart';
import 'package:jovera_finance/widgets/custom_page_title.dart';

class BusinessLoanDocumentsView extends GetView<BusinessLoanController> {
  const BusinessLoanDocumentsView({super.key});

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
              Get.to(() => BusinessLoanCompanyDocumentsView());
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
