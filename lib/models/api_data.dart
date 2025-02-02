import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiData {
  final String nikunjText;
  final String subText;
  final double minRange;
  final double maxRange;
  final String creditAmountText;
  final String percentageText;
  final String footerText;
  final String ctaText;
  final String key1Text; 
  final String repay;// New field to store "key1"
  final String recommandation; // New field to store "repay"

  ApiData({
    required this.minRange,
    required this.maxRange,
    required this.creditAmountText,
    required this.percentageText,
    required this.nikunjText,
    required this.subText,
    required this.footerText,
    required this.ctaText,
    required this.key1Text, // Add this to the constructor
    required this.repay, // Add this to the constructor
    required this.recommandation, // Add this to the constructor
  });

  factory ApiData.fromJson(Map<String, dynamic> json) {
    final items = json['items'] as List<dynamic>?;

    if (items == null || items.isEmpty) {
      return ApiData(
        minRange: 500.0,
        maxRange: 487891.0,
        creditAmountText: "Credit Amount",
        percentageText: "@1.04% monthly",
        nikunjText: "How much do you need?",
        subText: "Move the dial and set any amount you need up to ₹487,891",
        footerText: "stash is instant. money will be credited within seconds.",
        ctaText: "Proceed to EMI selection",
        key1Text: "credit amount", // Default value for key1 if data is empty
        repay: "how do you wish to repay?", // Default value for repay if data is empty
        recommandation: "choose one of our recommended plans or make your own" ,
      );
    }

    final firstItem = items[0]['open_state']['body']['card'];
    final closedState = items[0]['closed_state']['body'];
    final secondItem = items[1]['open_state']['body']['items'];

    return ApiData(
      minRange: (firstItem['min_range'] ?? 500).toDouble(),
      maxRange: (firstItem['max_range'] ?? 487891).toDouble(),
      creditAmountText: firstItem['header'] ?? "Credit Amount",
      percentageText: firstItem['description'] ?? "@1.04% monthly",
      nikunjText: items[0]['open_state']['body']['title'] ?? "How much do you need?",
      subText: items[0]['open_state']['body']['subtitle'] ?? "Move the dial and set any amount you need up to ₹487,891",
      footerText: items[0]['open_state']['body']['footer'] ?? "Money will be credited instantly",
      ctaText: items[0]['cta_text'] ?? "Proceed to EMI selection",
      key1Text: closedState['key1'] ?? "credit amount", // Extracting "key1" from closed_state
      repay: secondItem['title'] ?? "how do you wish to repay?",// Extracting "repay" from closed_state
      recommandation: secondItem['subtitle'] ?? "choose one of our recommended plans or make your own", // Extracting "recommandation" from closed_state
    );
  }

  static Future<ApiData?> fetchData() async {
    try {
      final response = await http.get(Uri.parse("https://api.mocklets.com/p6764/test_mint"));
      if (response.statusCode == 200) {
        print('API Response: ${response.body}');  // Log to check API response
        return ApiData.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return null;
  }
}
