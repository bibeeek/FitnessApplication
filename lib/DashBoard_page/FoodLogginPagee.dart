import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'dart:math';

import 'ServingSize.dart';

class FoodSearchPage extends StatefulWidget {
  final String meal; // e.g. 'breakfast', 'lunch', 'dinner'
  const FoodSearchPage({super.key, required this.meal});

  @override
  State<FoodSearchPage> createState() => _FoodSearchPageState();
}

class _FoodSearchPageState extends State<FoodSearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _results = [];
  bool _loading = false;

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

    final key = '$secret&'; // No token secret
    final hmacSha1 = Hmac(sha1, utf8.encode(key));
    final signatureBytes = hmacSha1.convert(utf8.encode(baseString)).bytes;
    return base64Encode(signatureBytes);
  }

  Future<void> _searchFood(String query) async {
    if (query.isEmpty) return;
    setState(() {
      _loading = true;
      _results = [];
    });

    final url = 'https://platform.fatsecret.com/rest/server.api';

    final oauthParams = {
      'oauth_consumer_key': consumerKey,
      'oauth_nonce': _generateNonce(),
      'oauth_signature_method': 'HMAC-SHA1',
      'oauth_timestamp': (DateTime.now().millisecondsSinceEpoch ~/ 1000).toString(),
      'oauth_version': '1.0',
      'method': 'foods.search',
      'search_expression': query,
      'format': 'json',
    };

    final signature = _generateSignature('GET', url, oauthParams, consumerSecret);
    oauthParams['oauth_signature'] = signature;

    final uri = Uri.parse(url).replace(queryParameters: oauthParams);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final foodList = data['foods']?['food'];
      if (foodList != null) {
        final List<Map<String, dynamic>> parsedResults = [];
        if (foodList is List) {
          parsedResults.addAll(foodList.take(10).cast<Map<String, dynamic>>());
        } else if (foodList is Map<String, dynamic>) {
          parsedResults.add(foodList);
        }

        setState(() {
          _results = parsedResults;
        });
      }
    }
    setState(() => _loading = false);
  }

  void _onFoodTap(Map<String, dynamic> foodItem) {
    final String name = foodItem['food_name'] ?? 'Unnamed';
    final String id = foodItem['food_id'].toString();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ServingInputPage(
          meal: widget.meal,
          foodId: foodItem['food_id'].toString(),
          foodName: foodItem['food_name'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],

     

      appBar: AppBar(

        title: Text("Add food to ${widget.meal}",),
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
        backgroundColor:Color.fromRGBO(0, 130, 83, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (val) {
                if (val.length > 2) _searchFood(val); // basic debounce trigger
              },
              decoration: InputDecoration(
                labelText: 'Search food',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                suffixIcon: Icon(Icons.search),
                suffixIconColor: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            if (_loading)
              Center(child: CircularProgressIndicator())
            else if (_results.isEmpty)
              Text('No results yet')
            else
              Expanded(
                child: Card(
                  color: Colors.blueGrey[50],


                 elevation: 0,

                  child: ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (_, index) {
                      final food = _results[index];
                      return ListTile(

                        tileColor:  Color.fromRGBO(0, 130, 83, 1),
                        titleTextStyle: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
                        subtitleTextStyle: TextStyle(color: Colors.white),
                        leading: Icon(Icons.fastfood,color: Colors.white,),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19.0),
                          side: BorderSide(color:Colors.blueGrey.shade50, width: 4.0),
                        ),
                        title: Text(food['food_name'] ?? 'No name'),
                        subtitle: Text(food['brand_name'] ?? ''),
                        trailing: Icon(Icons.arrow_forward_ios,color: Colors.white,),
                        onTap: () => _onFoodTap(food),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
