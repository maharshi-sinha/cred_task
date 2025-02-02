import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class QuestionAppBar extends StatelessWidget {
  const QuestionAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: const Color(0xff172045),
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Center(
        child: FaIcon(
          FontAwesomeIcons.question,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}

class XMarkAppBar extends StatelessWidget {
  const XMarkAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: const Color(0xff172045),
        borderRadius: BorderRadius.circular(50),
      ),
      child: const Center(
        child: FaIcon(
          FontAwesomeIcons.xmark,
          color: Colors.white,
          size: 25,
        ),
      ),
    );
  }
}
