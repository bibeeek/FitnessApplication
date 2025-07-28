import 'package:fitnessapp/STEPCOUNTER/stepcounterprovider.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pedometer/pedometer.dart';
import 'package:provider/provider.dart';

class StepCounterWidget extends StatefulWidget {
  const StepCounterWidget({super.key});

  @override
  State<StepCounterWidget> createState() => _StepCounterWidgetState();
}

class _StepCounterWidgetState extends State<StepCounterWidget> {
  late Stream<StepCount> _stepCountStream;

  @override
  void initState() {
    super.initState();
    _initializeStepTracking();
  }

  Future<void> _initializeStepTracking() async {
    await _requestPermission();
    await context.read<StepProvider>().loadSavedData();

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen((StepCount event) {
      context.read<StepProvider>().updateSteps(event.steps);
    }).onError((error) {
      debugPrint("Pedometer Error: $error");
    });
  }

  Future<void> _requestPermission() async {
    if (!await Permission.activityRecognition.isGranted) {
      await Permission.activityRecognition.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    final stepProvider = context.watch<StepProvider>();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(Icons.directions_walk, size: 36, color: Colors.blue.shade700),
                const SizedBox(width: 12),
                Text(
                  "Steps Today",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade900,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              '${stepProvider.stepsToday}',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade900,
              ),
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: stepProvider.progress,
              backgroundColor: Colors.blue.shade100,
              color: Colors.blue.shade600,
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Text(
              stepProvider.percentageText,
              style: TextStyle(
                fontSize: 14,
                color: Colors.blue.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
