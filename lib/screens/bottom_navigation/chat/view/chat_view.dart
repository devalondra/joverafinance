import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/controller/chat_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/widget/file_preview.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/widget/recieved_message.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/widget/sent_message.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Background(
      appLoadingController: controller.appLoadingController,
      child: Scaffold(
        resizeToAvoidBottomInset: true,

        backgroundColor: AppColors.backgroundColor,
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                   
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainText(text: "Admin".tr),

                        MainText(text: "Online".tr, fontSize: 12),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    controller.getAllMessages();
                  },
                  child: Icon(Icons.refresh, color: AppColors.lightGrey),
                ),
              ],
            ),
            SizedBox(height: fullHeight * 0.02),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  itemCount: controller.messages.length,
                  itemBuilder:
                      (context, index) =>
                          controller.messages[index].senderId ==
                                  controller.userId
                              ? SentMessage(
                                chatModel: controller.messages[index],
                              )
                              : RecievedMessage(
                                chatModel: controller.messages[index],
                              ),
                ),
              ),
            ),
            Obx(
              () => Align(
                alignment: Alignment.topRight,
                child: Visibility(
                  visible: controller.selectedFilePath.value.isNotEmpty,
                  child: FilePreview(
                    filePath: controller.selectedFilePath.value,
                    isPdf: controller.selectedFilePath.value.endsWith(".pdf"),
                    onPressed: () {
                      controller.selectedFilePath.value = "";
                      controller.update();
                    },
                  ).paddingSymmetric(vertical: fullHeight * 0.01),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Form(
                    key: formKey,
                    child: CustomTextField(
                      contentPadding: EdgeInsets.only(
                        top: fullHeight * 0.01,
                        bottom: fullHeight * 0.01,
                        left: fullHeight * 0.01,
                        right: fullHeight * 0.01,
                      ),
                      controller: controller.textController.value,
                      textColor: AppColors.darkGrey,
                      hintText: "Send message".tr,
                      validator: (value) {
                        return AppValidators().textValidation(value);
                      },
                      label: false,
                      border: true,
                      bgColor: AppColors.white,
                      hintStyle: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 16,
                      ),
                      borderRadius: fullWidth * 0.04,
                      suffixIcon: InkWell(
                        onTap: () => controller.selectFile(context),
                        child: Icon(Icons.file_present_outlined),
                      ),
                      borderColor: AppColors.backgroundColor,
                    ),
                  ),
                ),
                SizedBox(width: fullWidth * 0.02),
                InkWell(
                  onTap: () {
                    if (controller.selectedFilePath.value.isNotEmpty) {
                      controller.sendMessage();
                    } else {
                      if (formKey.currentState!.validate()) {
                        controller.sendMessage();
                      }
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.all(fullWidth * 0.03),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                    child: Center(
                      child: Icon(Icons.send_outlined, color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ).paddingSymmetric(
          horizontal: horizontalPagePadding,
          vertical: verticalPagePadding,
        ),
      ),
    );
  }
}
