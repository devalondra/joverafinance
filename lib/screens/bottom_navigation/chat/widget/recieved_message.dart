import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/model/chat_model.dart';
import 'package:jovera_finance/screens/bottom_navigation/chat/widget/file_widget.dart';
import 'package:jovera_finance/utilities/constants/app_colors.dart';
import 'package:jovera_finance/utilities/constants/app_values.dart';
import 'package:jovera_finance/widgets/main_text.dart';

class RecievedMessage extends StatelessWidget {
  const RecievedMessage({super.key, required this.chatModel});
  final ChatModel chatModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: fullWidth * 0.11,
          width: fullWidth * 0.11,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image:
                chatModel.picture!.startsWith("https")
                    ? DecorationImage(
                      image: NetworkImage(chatModel.picture!),
                      fit: BoxFit.cover,
                    )
                    : null,
            border: Border.all(color: AppColors.darkGrey),
          ),
          child:
              chatModel.picture == ""
                  ? SvgPicture.asset(
                    "assets/icons/profile_icon.svg",
                    fit: BoxFit.cover,
                  )
                  : null,
        ),

        SizedBox(width: fullWidth * 0.02),
        chatModel.fileUrl != ""
            ? SizedBox(
              width: fullWidth * 0.5,
              child: FileWidget(
                filePath: chatModel.fileUrl!,
                isPdf: chatModel.fileUrl!.endsWith(".pdf"),

                onPressed: () {},
              ),
            )
            : Expanded(child: MainText(text: chatModel.content ?? "")),
        SizedBox(width: fullWidth * 0.2),
      ],
    ).paddingSymmetric(vertical: fullHeight * 0.01);
  }
}
