import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/model/chat_model.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/widget/file_widget.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class SentMessage extends StatelessWidget {
  const SentMessage({super.key, required this.chatModel});
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(width: fullWidth * 0.2),
        chatModel.fileUrl != ""
            ? SizedBox(
              width: fullWidth * 0.5,
              child: FileWidget(
                filePath: chatModel.fileUrl!,
                isPdf: chatModel.fileUrl!.endsWith(".pdf"),
                onPressed: () {},
              ),
            )
            : Expanded(
              child: Container(
                padding: EdgeInsets.all(fullWidth * 0.03),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(fullWidth * 0.04),
                    bottomRight: Radius.circular(0),
                    bottomLeft: Radius.circular(fullWidth * 0.04),
                    topRight: Radius.circular(fullWidth * 0.04),
                  ),
                ),
                child: MainText(text: chatModel.content ?? ""),
              ),
            ),
      ],
    ).paddingSymmetric(vertical: fullHeight * 0.01);
  }
}
