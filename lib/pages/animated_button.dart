import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;
  final List<Color> gradientColors;

  const AnimatedButton({
    required this.onPressed,
    required this.label,
    required this.gradientColors,
    Key? key,
  }) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  bool _isButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isButtonPressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isButtonPressed = false;
        });
        widget.onPressed();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: _isButtonPressed ? 180 : 200,
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: widget.gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: _isButtonPressed
              ? []
              : [
                  BoxShadow(
                    color: Colors.black26,
                    offset: Offset(0, 4),
                    blurRadius: 10,
                  ),
                ],
        ),
        alignment: Alignment.center,
        child: Text(
          widget.label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
