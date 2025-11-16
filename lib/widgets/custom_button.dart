import 'package:flutter/material.dart';
import 'package:newsly/utils/app_color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    this.onPressed,
    this.isDisabled = false
  });

  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final VoidCallback? onPressed;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: isDisabled ? Color(AppColor.disabledColor).withOpacity(0.5) : backgroundColor
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(isDisabled ? Color(AppColor.disabledColor).withOpacity(0.5) : backgroundColor),
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
          elevation: WidgetStatePropertyAll(0),
        ),
              
        onPressed: () => onPressed != null && !isDisabled ? onPressed!() : null,
        child: Text(label,style: TextStyle(color: textColor),),
      ),
    );
  }
}