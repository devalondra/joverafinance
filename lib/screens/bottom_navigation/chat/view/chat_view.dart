import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/controller/chat_controller.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/model/my_lead.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/widget/file_preview.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/widget/recieved_message.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/widget/sent_message.dart';
import 'package:jovera_finance/screens/business_loan/widget/background_decoration.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_validators.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/utilities/extensions/widget_extensions.dart';
import 'package:jovera_finance/utilities/localization/string_extensions.dart';
import 'package:jovera_finance/widgets/background.dart';
import 'package:jovera_finance/widgets/custom_text_field.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class ChatView extends ConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(chatControllerProvider.notifier);
    ref.watch(chatControllerProvider);
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
                    buildAvatar(controller),
                    SizedBox(width: fullWidth * 0.02),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainText(
                          text: controller.sender?.senderName ?? "Jovera".tr,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: Icon(Icons.menu, color: AppColors.grey),
                ),
              ],
            ),
            SizedBox(height: fullHeight * 0.02),

            controller.leads.isEmpty
                ? SizedBox()
                : BackgroundDecoration(
                  child: DropdownButtonFormField<MyLead>(
                    dropdownColor: AppColors.black2,
                    isExpanded: true,
                    iconEnabledColor: AppColors.grey,

                    items:
                        controller.leads
                            .map(
                              (lead) => DropdownMenuItem(
                                value: lead,
                                child: MainText(
                                  text: lead.leadType ?? "",
                                  color: AppColors.grey,
                                ),
                              ),
                            )
                            .toList(),
                    onChanged: (v) {
                      controller.selectedLead = v;
                    },
                    decoration: InputDecoration(
                      fillColor: AppColors.black2,
                      alignLabelWithHint: true,
                      labelStyle: TextStyle(
                        color: AppColors.grey,
                        fontSize: 14,
                      ),
                      isDense: true,

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.black2),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.black2),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    hint: MainText(
                      text: "Choose",
                      color: AppColors.lightGrey,
                    ),
                  ),
                ),

            Expanded(
              child: RefreshIndicator.adaptive(
                onRefresh: () async {
                  await controller.getAllMessages();
                },
                child:
                    controller.messages.isEmpty
                        ? ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: fullHeight * 0.25,
                                ),
                                child: MainText(text: "No messages yet"),
                              ),
                            ),
                          ],
                        )
                        : ListView.builder(
                          controller: controller.scrollController,
                          shrinkWrap: true,
                          physics: const AlwaysScrollableScrollPhysics(),

                          itemCount: controller.messages.length,
                          itemBuilder:
                              (context, index) =>
                                  controller.messages[index].recipientModel ==
                                          "Client"
                                      ? RecievedMessage(
                                        chatModel: controller.messages[index],
                                      )
                                      : SentMessage(
                                        chatModel: controller.messages[index],
                                      ),
                        ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Visibility(
                visible: controller.selectedFilePath.isNotEmpty,
                child: FilePreview(
                  filePath: controller.selectedFilePath,
                  isPdf: controller.selectedFilePath.endsWith(".pdf"),
                  onPressed: () {
                    controller.selectedFilePath = "";
                  },
                ).paddingSymmetric(vertical: fullHeight * 0.01),
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
                      controller: controller.textController,
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
                    if (controller.selectedFilePath.isNotEmpty) {
                      controller.sendFile();
                    } else {
                      if (formKey.currentState!.validate()) {
                        controller.sendMessageViaSocket();
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

  Widget buildAvatar(ChatController controller) {
    return Container(
      height: fullWidth * 0.131,
      width: fullWidth * 0.131,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image:
            controller.hasSenderImage
                ? DecorationImage(
                  image: NetworkImage(controller.sender!.senderImage!),
                  fit: BoxFit.cover,
                )
                : null,
        border: Border.all(color: AppColors.darkGrey),
      ),
      child:
          (controller.sender?.senderImage ?? "").isEmpty
              ? SvgPicture.asset(
                "assets/icons/profile_icon.svg",
                fit: BoxFit.cover,
              )
              : null,
    );
  }
}
