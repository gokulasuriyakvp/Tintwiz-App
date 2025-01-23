// import 'package:flutter/material.dart';
//
// class Demo extends StatefulWidget {
//   @override
//   _DemoState createState() => _DemoState();
// }
//
// class _DemoState extends State<Demo> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             width: double.infinity,
//             height: 100,
//             decoration: BoxDecoration(
//               color: Colors.white,
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     // Show a custom sliding menu from top to bottom
//                     Navigator.of(context).push(_TopToBottomPageRoute());
//                   },
//                   child: Row(
//                     children: [
//                       Icon(Icons.menu),
//                       Text("TinWize"),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   children: [
//                     Icon(Icons.notifications),
//                     CircleAvatar(
//                       backgroundColor: Colors.grey.shade300,
//                       child: Icon(Icons.person),
//                     ),
//                     Icon(Icons.arrow_drop_down),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _TopToBottomPageRoute extends PageRouteBuilder {
//   _TopToBottomPageRoute()
//       : super(
//     pageBuilder: (context, animation, secondaryAnimation) => TopToBottomSheet(),
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       // Slide transition from top to bottom
//       const begin = Offset(0.0, -1.0);
//       const end = Offset.zero;
//       const curve = Curves.easeInOut;
//       var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//       var offsetAnimation = animation.drive(tween);
//
//       return SlideTransition(position: offsetAnimation, child: child);
//     },
//   );
// }
//
// class TopToBottomSheet extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent, // Transparent background for the sliding sheet
//       body: Container(
//         height: 300,
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//         ),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   Icon(Icons.home, color: Colors.indigo),
//                   SizedBox(width: 10),
//                   Text("Home", style: TextStyle(fontSize: 18)),
//                 ],
//               ),
//             ),
//             // Add more items here as needed
//           ],
//         ),
//       ),
//     );
//   }
// }
//
