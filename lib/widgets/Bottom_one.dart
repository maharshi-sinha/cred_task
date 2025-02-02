import 'package:flutter/material.dart';

class BottomModal {
  static void showDraggableBottomSheet(BuildContext context, String key1Text, String value) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          behavior: HitTestBehavior.opaque,
          child: DraggableScrollableSheet(
            initialChildSize: 0.85,
            minChildSize: 0.85,
            maxChildSize: 1.0,
            builder: (context, scrollController) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xff0e1e36),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    // Display key1Text dynamically
                    Positioned(
                      left: 25,
                      child: Text(
                        "$key1Text",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Selected Value: $value", // Value is now a string
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
