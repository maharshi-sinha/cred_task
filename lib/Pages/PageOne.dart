import 'package:flutter/material.dart';
import '../../models/api_data.dart';
import '../../widgets/custom_gauge.dart';
import '../../widgets/bottom_modal.dart'; // Import the BottomModal class
import '../../widgets/app_bar_widget.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:intl/intl.dart'; // Import intl for currency formatting

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  double _value = 500;  // Keep _value as a double
  ApiData? _apiData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    ApiData? data = await ApiData.fetchData();
    if (data != null) {
      setState(() {
        _apiData = data;
        _value = data.minRange;
      });
    }
  }

  // Function to format value to Indian currency format
  String formatIndianCurrency(double value) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'en_IN', // Indian locale
      symbol: '', // No symbol for currency, you can change if you want to display INR symbol
      customPattern: '#,##,##0', // Pattern for Indian currency
    );
    return currencyFormatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (_apiData == null) {
      return Scaffold(
        backgroundColor: Color(0xff071324),
        body: Center(
          child: LoadingAnimationWidget.horizontalRotatingDots(
            color: Color(0xffe3a67b),
            size: 65,
          ),
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff071324),
        body: Column(
          children: [
            /// ✅ **App Bar Section**
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
                horizontal: screenWidth * 0.05,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  XMarkAppBar(),
                  QuestionAppBar(),
                ],
              ),
            ),

            /// ✅ **Main Content**
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xff0e1e36),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: screenHeight * 0.03,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// ✅ **Title Text**
                      Text(
                        _apiData!.nikunjText,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.005),

                      /// ✅ **Sub Text**
                      Text(
                        _apiData!.subText,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.03),

                      /// ✅ **Gauge Widget (Ensures No Overlap)**
                      Expanded(
                        child: Center(
                          child: CustomGauge(
                            value: _value, // Pass _value as a double here
                            minValue: _apiData!.minRange,
                            maxValue: _apiData!.maxRange,
                            onValueChanged: (newValue) {
                              setState(() {
                                _value = newValue;
                              });
                            },
                            creditAmountText: _apiData!.creditAmountText,
                            percentageText: _apiData!.percentageText,
                            footerText: _apiData!.footerText,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// ✅ **Fixed Bottom Container with Dynamic Button Text**
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: double.infinity, // Ensures full width
                child: GestureDetector(
                  onTap: () {
                    // Pass both key1Text and the formatted value (_value) as a string
                    BottomModal.showDraggableBottomSheet(
                      context,
                      _apiData!.key1Text,
                      formatIndianCurrency(_value),
                      _apiData!.repay,
                      _apiData!.recommandation, // Format the value in Indian currency style
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    decoration: const BoxDecoration(
                      color: Color(0xff473bf5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _apiData?.ctaText ?? "Proceed to EMI selection", // ✅ Null check applied
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
