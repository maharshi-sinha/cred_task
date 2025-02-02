import 'package:cred_task/models/api_data.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SubsCard extends StatefulWidget {
  @override
  _SubsCardState createState() => _SubsCardState();
}

class _SubsCardState extends State<SubsCard> {
  int selectedPlanIndex = 0;
  List<Map<String, String>> plans = [];
  bool isLoading = true; // ✅ Added loading state

  @override
  void initState() {
    super.initState();
    fetchPlans();
  }

  /// Fetch EMI plans from API
  Future<void> fetchPlans() async {
    ApiData? apiData = await ApiData.fetchData();
    if (apiData != null) {
      setState(() {
        plans = apiData.plans;
        isLoading = false; // ✅ Stop loading after data fetch
      });
    } else {
      setState(() {
        isLoading = false; // ✅ Stop loading even if API fails
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isLoading) // ✅ Show loading animation while fetching data
          Center(
            child: LoadingAnimationWidget.horizontalRotatingDots(
              color: const Color(0xffe3a67b),
              size: 50,
            ),
          )
        else if (plans.isEmpty) // ✅ Handle empty state
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "No plans available",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          )
        else // ✅ Show plans once loaded
          SizedBox(
            height: 170,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: plans.length,
              itemBuilder: (context, index) => _buildPlanCard(plans[index], index),
            ),
          ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Colors.white),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          ),
          child: const Text("Create your own plan", style: TextStyle(color: Colors.white, fontSize: 14)),
        ),
      ],
    );
  }

  Widget _buildPlanCard(Map<String, String> plan, int index) {
    bool isSelected = selectedPlanIndex == index;
    return GestureDetector(
      onTap: () => setState(() => selectedPlanIndex = index),
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blueGrey,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildSelectionIndicator(isSelected),
            const SizedBox(height: 16),
            Text(plan["emi"] ?? "", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text("for ${plan["duration"]}", style: const TextStyle(color: Colors.white70, fontSize: 14)),
            const Spacer(),
            Text(plan["subtitle"] ?? "See calculations", style: const TextStyle(color: Colors.white54, fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator(bool isSelected) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: isSelected ? Colors.white : Colors.white54, width: 2),
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              ),
            )
          : null,
    );
  }
}
