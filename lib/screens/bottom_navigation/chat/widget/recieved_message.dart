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
    if (!hasFile && !hasText) return const SizedBox();

    return Row(
      children: [
        buildAvatar(),
        SizedBox(width: fullWidth * 0.02),
        hasFile
            ? buildFileWidget()
            : Expanded(child: MainText(text: chatModel.text ?? "")),
        SizedBox(width: fullWidth * 0.2),
      ],
    ).paddingSymmetric(vertical: fullHeight * 0.01);
  }

  Widget buildAvatar() {
    return Container(
      height: fullWidth * 0.11,
      width: fullWidth * 0.11,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image:
            hasSenderImage
                ? DecorationImage(
                  image: NetworkImage(chatModel.senderImage!),
                  fit: BoxFit.cover,
                )
                : null,
        border: Border.all(color: AppColors.darkGrey),
      ),
      child:
          (chatModel.senderImage ?? "").isEmpty
              ? SvgPicture.asset(
                "assets/icons/profile_icon.svg",
                fit: BoxFit.cover,
              )
              : null,
    );
  }

  Widget buildFileWidget() {
    return SizedBox(
      width: fullWidth * 0.5,
      child: FileWidget(
        filePath: chatModel.fileUrl!,
        isPdf: chatModel.fileUrl!.endsWith(".pdf"),
        onPressed: () {},
      ),
    );
  }

  bool get hasFile =>
      chatModel.fileUrl != null && chatModel.fileUrl!.startsWith("https");

  bool get hasText => (chatModel.text?.isNotEmpty ?? false);

  bool get hasSenderImage => (chatModel.senderImage ?? "").startsWith("https");
  //@override
  // Widget build(BuildContext context) {
  //   return (!(chatModel.fileUrl?.startsWith("https") ?? false)) &&
  //           (chatModel.text?.isEmpty ?? false)
  //       ? SizedBox()
  //       : Row(
  //         children: [
  //           Container(
  //             height: fullWidth * 0.11,
  //             width: fullWidth * 0.11,
  //             decoration: BoxDecoration(
  //               shape: BoxShape.circle,
  //               image:
  //                   (chatModel.senderImage ?? "").startsWith("https")
  //                       ? DecorationImage(
  //                         image: NetworkImage(chatModel.senderImage!),
  //                         fit: BoxFit.cover,
  //                       )
  //                       : null,
  //               border: Border.all(color: AppColors.darkGrey),
  //             ),
  //             child:
  //                 (chatModel.senderImage ?? "").isEmpty
  //                     ? SvgPicture.asset(
  //                       "assets/icons/profile_icon.svg",
  //                       fit: BoxFit.cover,
  //                     )
  //                     : null,
  //           ),

  //           SizedBox(width: fullWidth * 0.02),
  //           chatModel.fileUrl != null &&
  //                   chatModel.fileUrl!.isNotEmpty &&
  //                   (chatModel.fileUrl?.startsWith("https") ?? false)
  //               ? SizedBox(
  //                 width: fullWidth * 0.5,
  //                 child: FileWidget(
  //                   filePath: chatModel.fileUrl!,
  //                   isPdf: chatModel.fileUrl!.endsWith(".pdf"),

  //                   onPressed: () {},
  //                 ),
  //               )
  //               : Expanded(child: MainText(text: chatModel.text ?? "")),
  //           SizedBox(width: fullWidth * 0.2),
  //         ],
  //       ).paddingSymmetric(vertical: fullHeight * 0.01);
  // }
}
