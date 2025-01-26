// // ignore_for_file: deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CustomLogoutListTile extends StatelessWidget {
//   final String profileTitleText;
//   final VoidCallback onTap;
//   // final String profileLeadingIconName;

//   const CustomLogoutListTile({
//     super.key,
//     required this.profileTitleText,
//     required this.onTap,
//     // required this.profileLeadingIconName,
//     required Icon icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ListTile(
//       onTap: onTap,
//       contentPadding:
//           const EdgeInsets.symmetric(vertical: 3.0, horizontal: 16.0),
//       // Adjust vertical padding here
//       leading: Align(
//         alignment: Alignment.center,
//         child: Icon(
//           icon.icon, 
//           size: 24,
//           // color: theme.iconTheme.color,
//           color: Colors.black,
//         ),
//       ),

//       //  SvgPicture.asset(
//       //   "lib/assets/svg/$profileLeadingIconName.svg",
//       //   height: 28,
//       //   width: 28,
//       //   fit: BoxFit.cover,
//       //   color: Colors.white,
//       // ),
//       title: Text(profileTitleText),
//       titleTextStyle: GoogleFonts.montserrat(
//         fontSize: 17,
//         fontWeight: FontWeight.w600,
//         color: Colors.white,
//       ),
//       trailing: const Icon(
//         size: 26,
//         Icons.arrow_forward_rounded,
//         color: Colors.white,
//       ),
//     );
//   }
// }
