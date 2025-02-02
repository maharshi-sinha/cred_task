import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiData {
  final double minRange;
  final double maxRange;
  final String creditAmountText;
  final String percentageText;
  final String nikunjText;
  final String subText;
  final String footerText;
  final String ctaText;
  final String key1Text;
  final String repay;
  final String recommendation;
  final List<Map<String, String>> plans;

  ApiData({
    required this.minRange,
    required this.maxRange,
    required this.creditAmountText,
    required this.percentageText,
    required this.nikunjText,
    required this.subText,
    required this.footerText,
    required this.ctaText,
    required this.key1Text,
    required this.repay,
    required this.recommendation,
    required this.plans,
  });

  /// Factory constructor to parse JSON response
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
        footerText: "Stash is instant. Money will be credited within seconds.",
        ctaText: "Proceed to EMI selection",
        key1Text: "credit amount",
        repay: "How do you wish to repay?",
        recommendation: "Choose one of our recommended plans or make your own",
        plans: [],
      );
    }

    final firstItem = items[0]['open_state']['body']['card'];
    final closedState = items[0]['closed_state']['body'];

    // Extract "repay" and "recommendation" from the second item
    final secondItem = (items.length > 1) ? items[1]['open_state']['body'] : null;

    // Extract EMI Plans from the second item
    final List<Map<String, String>> plans = (secondItem?['items'] as List<dynamic>?)
            ?.map((item) => {
                  "emi": item['emi'].toString(),
                  "duration": item['duration'].toString(),
                  "title": item['title'].toString(),
                  "subtitle": item['subtitle'].toString(),
                })
            .toList() ??
        [];

    return ApiData(
      minRange: (firstItem['min_range'] ?? 500).toDouble(),
      maxRange: (firstItem['max_range'] ?? 487891).toDouble(),
      creditAmountText: firstItem['header'] ?? "Credit Amount",
      percentageText: firstItem['description'] ?? "@1.04% monthly",
      nikunjText: items[0]['open_state']['body']['title'] ?? "How much do you need?",
      subText: items[0]['open_state']['body']['subtitle'] ?? "Move the dial and set any amount you need up to ₹487,891",
      footerText: items[0]['open_state']['body']['footer'] ?? "Money will be credited instantly",
      ctaText: items[0]['cta_text'] ?? "Proceed to EMI selection",
      key1Text: closedState['key1'] ?? "credit amount",
      repay: secondItem?['title'] ?? "How do you wish to repay?",
      recommendation: secondItem?['subtitle'] ?? "Choose one of our recommended plans or make your own",
      plans: plans,
    );
  }

  /// Fetch data from the API
  static Future<ApiData?> fetchData() async {
    try {
      final response = await http.get(Uri.parse("https://api.mocklets.com/p6764/test_mint"));
      if (response.statusCode == 200) {
        print('API Response: ${response.body}');
        return ApiData.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
    return null;
  }
}
