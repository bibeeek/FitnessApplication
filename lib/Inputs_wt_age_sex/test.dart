// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../provider_classes/Inputs_provider/all_inputs_provider.dart';
//
// class Test extends StatefulWidget {
//   const Test({super.key});
//
//   @override
//   State<Test> createState() => _TestState();
// }
//
// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     final pro = Provider.of<AllInputsProvider>(context);
//
//     double currentWeight = pro.getCurrentWeight;
//     double targetWeight = pro.getTargetWeight ?? currentWeight; // fallback to current if null
//     double lostWeight = currentWeight - targetWeight;
//
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Text('hh'),
//               Text('Current Weight: ${currentWeight.toStringAsFixed(1)}'),
//               Text('Target Weight: ${targetWeight.toStringAsFixed(1)}'),
//               Text('Lost Weight: ${lostWeight.toStringAsFixed(1)}'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
