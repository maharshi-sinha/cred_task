import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:intl/intl.dart';

class CustomGauge extends StatefulWidget {
  final double value;
  final double minValue;
  final double maxValue;
  final Function(double) onValueChanged;
  final String creditAmountText;
  final String percentageText;
  final String footerText;

  const CustomGauge({
    super.key,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.onValueChanged,
    required this.creditAmountText,
    required this.percentageText,
    required this.footerText,
  });

  @override
  State<CustomGauge> createState() => _CustomGaugeState();
}

class _CustomGaugeState extends State<CustomGauge> {
  late double _currentValue;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.value.clamp(widget.minValue, widget.maxValue); 
  }

  void _updateValue(double newValue) {
    setState(() {
      // Apply modulus to create the effect of circular motion
      _currentValue = widget.minValue + ((newValue - widget.minValue) % (widget.maxValue - widget.minValue));
    });
    widget.onValueChanged(_currentValue);
  }

  @override
  Widget build(BuildContext context) {
    // Format value using Indian currency format
    String formattedValue = NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: 0, // No decimal places
    ).format(_currentValue);

    return Container(
      height: 500,
      width: 500,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circular Gauge with Text Inside
          SizedBox(
            height: 400,
            width: 400,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Circular Gauge
                SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                      startAngle: 270,
                      endAngle: 270,
                      minimum: widget.minValue,
                      maximum: widget.maxValue,
                      showLabels: false,
                      showTicks: false,
                      radiusFactor: 0.85,
                      axisLineStyle: const AxisLineStyle(
                        thickness: 18,
                        color: Color(0xfffcd9c0),
                        thicknessUnit: GaugeSizeUnit.logicalPixel,
                      ),
                      pointers: <GaugePointer>[
                        RangePointer(
                          value: _currentValue, // Use updated value
                          width: 18,
                          sizeUnit: GaugeSizeUnit.logicalPixel,
                          color: const Color(0xffe3a67b),
                          cornerStyle: CornerStyle.bothCurve,
                        ),
                        MarkerPointer(
                          value: _currentValue,
                          markerType: MarkerType.circle,
                          color: Colors.black,
                          markerHeight: 40,
                          markerWidth: 40,
                          enableDragging: true,
                          onValueChanged: _updateValue, // Update value during dragging
                        ),
                      ],
                    ),
                  ],
                ),
                // Text Inside Gauge
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.creditAmountText,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      formattedValue,
                      style: GoogleFonts.poppins(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      widget.percentageText,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              textAlign: TextAlign.center,
              widget.footerText,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
