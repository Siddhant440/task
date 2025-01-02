import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String title;
  final Color? buttonColor;
  final Color? textColor;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.buttonColor,
    this.textColor,
    this.isLoading = false,
  });

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.isLoading ? null : widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.buttonColor ?? Colors.lightBlueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      child: SizedBox(
        width: 170,
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (!widget.isLoading)
              Text(
                widget.title,
                style: TextStyle(
                  color: widget.textColor ?? Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            if (widget.isLoading)
              SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: widget.textColor ?? Colors.white,
                  strokeWidth: 2.0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
