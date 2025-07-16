
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:percentages_with_animation/percentages_with_animation.dart';

class home_page extends StatefulWidget {
  const home_page({super.key});

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Today's Goals", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.calendar_today_outlined)),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
            children: [
        // Track Food Card
        Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Row(
        children: [
        Icon(Icons.restaurant_menu, color: Colors.green),
           SizedBox(width: 20),
          Text('Track Food', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.camera)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add_box_outlined, color: Colors.green)),
          ],
        ),
        Row(
            children: [
              SizedBox(height: 12,),

              SizedBox(height: 16),

              CircularPercentage(
                currentPercentage: 14,
                maxPercentage: 100,
                percentageStrokeWidth: 5,
                backgroundStrokeWidth: 5,
                backgroundColor: Colors.grey,
                percentageColor: Colors.green,
              ),
              SizedBox(width: 25,),
              Text('332 of 2,450 Cal', style:  TextStyle(color: Colors.green,fontSize: 20)),
            ]

        ),
        SizedBox(height: 12,),

        const SizedBox(height: 16),
        // Macros
        const _MacroRow(name: "Protein", percent: 14),
        const _MacroRow(name: "Carb", percent: 11),
        const _MacroRow(name: "Fat", percent: 17),
        const _MacroRow(name: "Fibre", percent: 14),
        ],
      ),
    ),
    const SizedBox(height: 16),
    GestureDetector(
    onTap: () {},
    child: Container(
    padding: const EdgeInsets.symmetric(vertical: 14),
    decoration: BoxDecoration(
    color: const Color(0xFFEFF6F4),
    borderRadius: BorderRadius.circular(56),
    ),

    ),
    ),
    const SizedBox(height: 24),
    // Daily track icons

    ],
    ),
    ),

    );
  }
}

class _MacroRow extends StatelessWidget {
  final String name;
  final int percent;

  const _MacroRow({required this.name, required this.percent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 60, child: Text('$name:')),
          Expanded(
            child: LinearProgressIndicator(
              value: percent / 100,
              backgroundColor: Colors.grey.shade200,
              color: Colors.green,
              minHeight: 6,
            ),
          ),
          const SizedBox(width: 10),
          Text('$percent%'),
        ],
      ),
    );
  }
}