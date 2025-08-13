
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:jovera_finance/utilities/constants/app_colors.dart';
// import 'package:jovera_finance/utilities/constants/app_values.dart';
// import 'package:jovera_finance/screens/visa/widget/cancel_button.dart';
// import 'package:jovera_finance/screens/visa/widget/submit_button.dart';
// import 'package:jovera_finance/screens/visa/widget/upload_button.dart';

// class FileUploadWidget extends StatelessWidget {
//   const FileUploadWidget({super.key, required this.onTap});
//   final Function() onTap;

//   @override
//   Widget build(BuildContext context) {
//     return DottedBorder(
//       options: RoundedRectDottedBorderOptions(
//         radius: Radius.circular(fullWidth * 0.02),
//         strokeWidth: 2,
//         dashPattern: [4, 5],
//         color: AppColors.darkGrey,
//       ),
//       child: Container(
//         height: fullHeight * 0.2,
//         width: fullWidth,
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             UploadButton(
//               heading: "select your file or drag and drop",
//               subHeading: "png, pdf, jpg, docx accepted",
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 CancelButton(),
//                 SizedBox(width: fullWidth * 0.02),
//                 SubmitButton(onTap: onTap),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
