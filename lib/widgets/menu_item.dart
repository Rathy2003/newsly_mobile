import 'package:flutter/material.dart';
import 'package:newsly/utils/app_font.dart';


class MenuItem extends StatelessWidget {
  const MenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.onTap
  });

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      enableFeedback: true,
      onTap: () => onTap?.call(),
      contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.withOpacity(0.1))
      ),
      leading: Icon(
        icon,
        color: Colors.black,
        size: 28,
      ),
      title: Text(label,
        style: AppFont.normal,
      ),
      trailing: Icon(Icons.chevron_right),
    );
  }
}