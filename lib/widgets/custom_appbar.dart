import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String title2;
  final Color? color;
  final bool showBackButton;
  final bool alignCenter;
  final Widget? trailing;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.title2,
    this.color,
    this.showBackButton = false,
    this.alignCenter = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color?.withOpacity(0.3) ?? Colors.blue.shade200,
            color ?? Colors.blueAccent,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 40),
        child: Row(
          mainAxisAlignment:
              alignCenter ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            if (showBackButton)
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            const SizedBox(width: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Text(
                  title2,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ],
            ),
            if (trailing != null) ...[
              const Spacer(),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        100,
      );
}
