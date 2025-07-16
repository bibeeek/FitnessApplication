import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:math';

import '../FoodApi/DataModels/fooddata.dart';
import '../FoodApi/food-providerclass/foodprovider.dart';

class ServingInputPage extends StatefulWidget {

  final String meal;
  final String foodId;
  final String foodName;

  const ServingInputPage({
    super.key,
    required this.meal,
    required this.foodId,
    required this.foodName,
  });

  @override
  State<ServingInputPage> createState() => _ServingInputPageState();
}

class _ServingInputPageState extends State<ServingInputPage> {
  String _unit = 'g';
  double _servingAmount = 100;
  final TextEditingController _controller = TextEditingController(text: "100");

  List<Map<String, dynamic>> _servingsList = [];
  Map<String, dynamic>? _selectedServing;
  bool _loading = true;

  final String consumerKey = '7dbfae97f4084c5c8022ef6154cb5bb6';
  final String consumerSecret = '16b4afc7ed06403db20436cc2a972f95';

  String _generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final rand = Random();
    return List.generate(length, (_) => charset[rand.nextInt(charset.length)]).join();
  }

  String _percentEncode(String s) {
    return Uri.encodeComponent(s)
        .replaceAll('+', '%20')
        .replaceAll('*', '%2A')
        .replaceAll('%7E', '~');
  }

  String _generateSignature(String method, String url, Map<String, String> params, String secret) {
    final sortedKeys = params.keys.toList()..sort();
    final paramString = sortedKeys
        .map((k) => '${_percentEncode(k)}=${_percentEncode(params[k]!)}')
        .join('&');

    final baseString = [
      method.toUpperCase(),
      _percentEncode(url),
      _percentEncode(paramString),
    ].join('&');

    final key = '$secret&';
    final hmacSha1 = Hmac(sha1, utf8.encode(key));
    final signatureBytes = hmacSha1.convert(utf8.encode(baseString)).bytes;
    return base64Encode(signatureBytes);
  }

  Future<void> _fetchServings() async {
    final url = 'https://platform.fatsecret.com/rest/server.api';

    final oauthParams = {
      'oauth_consumer_key': consumerKey,
      'oauth_nonce': _generateNonce(),
      'oauth_signature_method': 'HMAC-SHA1',
      'oauth_timestamp': (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
      'oauth_version': '1.0',
      'method': 'food.get',
      'food_id': widget.foodId,
      'format': 'json',
    };

    final signature = _generateSignature('GET', url, oauthParams, consumerSecret);
    oauthParams['oauth_signature'] = signature;

    final uri = Uri.parse(url).replace(queryParameters: oauthParams);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final servings = data['food']['servings']['serving'];

      if (servings == null) {
        _servingsList = [];
      } else if (servings is List) {
        // Cast each element safely to Map<String, dynamic>
        _servingsList = servings.map<Map<String, dynamic>>((item) => Map<String, dynamic>.from(item)).toList();
      } else if (servings is Map) {
        _servingsList = [Map<String, dynamic>.from(servings)];
      }

      // Default selected serving is the first one
      _selectedServing = _servingsList.isNotEmpty ? _servingsList[0] : null;

      if (_selectedServing != null) {
        _servingAmount = double.tryParse(_selectedServing!['metric_serving_amount'] ?? '100') ?? 100;
        _controller.text = _servingAmount.toString();
      }

      setState(() => _loading = false);
    }
  }

  Map<String, double> _calculateNutrition() {
    if (_selectedServing == null) return {'calories': 0, 'protein': 0, 'fat': 0, 'carbs': 0};

    final baseAmount = double.tryParse(_selectedServing!['metric_serving_amount'] ?? '100') ?? 100;
    final factor = _servingAmount / baseAmount;

    return {
      'calories': (double.tryParse(_selectedServing!['calories'] ?? '0') ?? 0) * factor,
      'protein': (double.tryParse(_selectedServing!['protein'] ?? '0') ?? 0) * factor,
      'fat': (double.tryParse(_selectedServing!['fat'] ?? '0') ?? 0) * factor,
      'carbs': (double.tryParse(_selectedServing!['carbohydrate'] ?? '0') ?? 0) * factor,
    };
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      final input = double.tryParse(_controller.text);
      if (input != null && input > 0) {
        setState(() => _servingAmount = input);
      }
    });

    _fetchServings();
  }

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context);
    final nutrition = _calculateNutrition();

    final unit = _selectedServing?['metric_serving_unit'] ?? 'g';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.foodName),
        backgroundColor: Colors.green,
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Serving Size:"),
            const SizedBox(height: 8),
            DropdownButton<Map<String, dynamic>>(
              value: _selectedServing,
              items: _servingsList.map((serving) {
                final amount = serving['metric_serving_amount'] ?? serving['serving_amount'];
                final unit = serving['metric_serving_unit'] ?? serving['serving_unit'] ?? '';
                final desc = serving['serving_description'] ?? '';
                final displayText = '$amount $unit ($desc)';
                return DropdownMenuItem(
                  value: serving,
                  child: Text(displayText),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedServing = val;
                    // Reset serving amount to this serving's amount:
                    _servingAmount = double.tryParse(val['metric_serving_amount'] ?? '100') ?? 100;
                    _controller.text = _servingAmount.toString();
                  });
                }
              },
            ),
            const SizedBox(height: 16),
            Text("Enter amount ($_unit):"),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter serving in $unit",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            Text("Nutritional Info", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text("Calories: ${nutrition['calories']!.toStringAsFixed(1)} kcal"),
            Text("Protein: ${nutrition['protein']!.toStringAsFixed(1)} g"),
            Text("Fat: ${nutrition['fat']!.toStringAsFixed(1)} g"),
            Text("Carbs: ${nutrition['carbs']!.toStringAsFixed(1)} g"),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final baseAmount = double.tryParse(_selectedServing!['metric_serving_amount'] ?? '100') ?? 100;
                  final factor = 100 / baseAmount; // Normalize to per 100g

                  mealProvider.addFoodToMeal(
                    widget.meal,
                    MealEntry(
                      food: FoodItem(
                        id: widget.foodId,
                        name: widget.foodName,
                        caloriesPerServing: (double.tryParse(_selectedServing!['calories'] ?? '0') ?? 0) * factor,
                        proteinPerServing: (double.tryParse(_selectedServing!['protein'] ?? '0') ?? 0) * factor,
                        fatPerServing: (double.tryParse(_selectedServing!['fat'] ?? '0') ?? 0) * factor,
                        carbsPerServing: (double.tryParse(_selectedServing!['carbohydrate'] ?? '0') ?? 0) * factor,
                        servingUnit: unit,
                      ),
                      servingAmount: _servingAmount,
                    ),
                  );

                  Navigator.pop(context);
                },
                child: Text("Add to ${widget.meal}"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
