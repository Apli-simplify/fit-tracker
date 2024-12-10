import 'package:flutter/material.dart';

import '../common/colo_extension.dart';

class RoundIconButton extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hitText;
  final String icon;
  final Widget? rightIcon;
  final bool obscureText;
  final EdgeInsets? margin;
  final VoidCallback? onTap; // Added onTap for triggering actions
  const RoundIconButton({
    super.key,
    required this.hitText,
    required this.icon,
    this.controller,
    this.margin,
    this.keyboardType,
    this.obscureText = false,
    this.rightIcon,
    this.onTap, // Constructor accepts onTap callback
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap, // Trigger the onTap callback when tapped
        child: AbsorbPointer(
          child: Container(
            margin: margin,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(15)),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  hintText: hitText,
                  suffixIcon: rightIcon,
                  prefixIcon: Container(
                      alignment: Alignment.center,
                      width: 20,
                      height: 20,
                      child: Image.asset(
                        icon,
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                        color: TColor.gray,
                      )),
                  hintStyle: TextStyle(color: TColor.gray, fontSize: 12)),
            ),
          ),
        ));
  }
}
