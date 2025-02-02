import 'package:flutter/material.dart';

class SubsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
    
        SizedBox(height: 16),
        _buildPlanCard("₹4,247", "12 months", true),
        _buildPlanCard("₹5,580", "9 months", false, isRecommended: true),
        _buildPlanCard("₹8,247", "6 months", false),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {}, // Add navigation or logic
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          child: Text("Create your own plan", style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }

  Widget _buildPlanCard(String price, String duration, bool isSelected, {bool isRecommended = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? Colors.brown.shade800 : Colors.purple.shade700,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(price + "/mo", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              Text("for $duration", style: TextStyle(color: Colors.white70)),
            ],
          ),
          if (isRecommended)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(

                color: Color.fromRGBO(255, 255, 255, 0.2),

                borderRadius: BorderRadius.circular(12),
              ),
              child: Text("Recommended", style: TextStyle(color: Colors.white, fontSize: 12)),
            ),
        ],
      ),
    );
  }
}
