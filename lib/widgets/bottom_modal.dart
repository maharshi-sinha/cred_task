import 'package:cred_task/Pages/Subscription_Card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomModal {
  static void showDraggableBottomSheet(
    BuildContext context,
    String key1Text,
    String value,
    String repay,
    String recommandation, // Add this parameter to receive the repay value
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.85,
          minChildSize: 0.85,
          maxChildSize: 1.0,
          builder: (context, scrollController) {
            return Container(
              width: MediaQuery.of(context).size.width, // Full width
              decoration: const BoxDecoration(
                color: Color(0xff0e1e36),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title Section
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          key1Text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "₹$value",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // **Main Content Area**
                  Expanded(
                    child: Container(
                      width: double.infinity, // Ensure full width
                      decoration: const BoxDecoration(
                        color: Color(0xff172d4f),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(height: 20),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                repay, // Display the repay value here
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              recommandation,
                              style: GoogleFonts.poppins(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            SubsCard(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
