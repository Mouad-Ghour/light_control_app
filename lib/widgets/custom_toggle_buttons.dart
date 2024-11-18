import 'package:flutter/material.dart';

class CustomToggleButtons extends StatefulWidget {
  final Function onOffPressed;
  final Function onOnPressed;

  const CustomToggleButtons({
    Key? key,
    required this.onOffPressed,
    required this.onOnPressed,
  }) : super(key: key);

  @override
  _CustomToggleButtonsState createState() => _CustomToggleButtonsState();
}

class _CustomToggleButtonsState extends State<CustomToggleButtons> {
  bool isOnSelected = false;

  void _onOffPressed() {
    setState(() {
      isOnSelected = false;
    });
    widget.onOffPressed();
  }

  void _onOnPressed() {
    setState(() {
      isOnSelected = true;
    });
    widget.onOnPressed();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.purple.shade50,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.purple),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min, // Ensure the Row sizes itself to its children
        children: [
          // Off Button
          InkWell(
            onTap: _onOffPressed,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: isOnSelected ? Colors.transparent : Colors.purple,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Ensure the Row sizes itself to its children
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/light_off_purple.png',
                    width: 24,
                    height: 24,
                    color: isOnSelected ? Colors.purple : Colors.white,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'Off',
                    style: TextStyle(
                      color: isOnSelected ? Colors.purple : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // On Button
          InkWell(
            onTap: _onOnPressed,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              decoration: BoxDecoration(
                color: isOnSelected ? Colors.purple : Colors.transparent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min, // Ensure the Row sizes itself to its children
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/light_on_purple.png',
                    width: 24,
                    height: 24,
                    color: isOnSelected ? Colors.grey : Colors.purple,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'On',
                    style: TextStyle(
                      color: isOnSelected ? Colors.grey : Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
