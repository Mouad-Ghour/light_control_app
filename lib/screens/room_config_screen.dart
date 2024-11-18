import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/room_model.dart';
import '../providers/room_provider.dart';
import 'package:flutter/services.dart';

class RoomConfigScreen extends StatefulWidget {
  final RoomModel room;

  RoomConfigScreen({required this.room});

  @override
  _RoomConfigScreenState createState() => _RoomConfigScreenState();
}

class _RoomConfigScreenState extends State<RoomConfigScreen> {
  late RoomModel room;
  late TextEditingController powerController;

  @override
  void initState() {
    super.initState();
    room = RoomModel(
      name: widget.room.name,
      isOn: widget.room.isOn,
      isOutOfOrder: widget.room.isOutOfOrder,
      intensity: widget.room.intensity,
      lightType: widget.room.lightType,
      power: widget.room.power,
    );
    powerController = TextEditingController(text: room.power.toString());
  }

  void _saveChanges() {
    final roomProvider = Provider.of<RoomProvider>(context, listen: false);
    roomProvider.updateRoom(room);
  }

  @override
  Widget build(BuildContext context) {
    // Removed the provider from here as we now call it directly when saving
    return Scaffold(
      appBar: AppBar(title: Text('Configure ${room.name}')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Out of Order Checkbox
            CheckboxListTile(
              title: Text('Out of Order'),
              value: room.isOutOfOrder,
              onChanged: (value) {
                setState(() {
                  room.isOutOfOrder = value!;
                  if (room.isOutOfOrder) {
                    room.isOn = false;
                    room.intensity = 0.0;
                  }
                });
                _saveChanges();
              },
            ),
            // Light State Slider (Disabled if Out of Order)
            Slider(
              value: room.intensity,
              onChanged: room.isOutOfOrder
                  ? null
                  : (value) {
                      setState(() {
                        room.intensity = value;
                        room.isOn = value > 0;
                      });
                      _saveChanges();
                    },
              min: 0.0,
              max: 1.0,
              divisions: 100,
              label: '${(room.intensity * 100).round()}%',
            ),
            // Light Type Dropdown
            DropdownButton<String>(
              value: room.lightType,
              items: ['LED', 'Halogen'].map((String type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(type),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  room.lightType = value!;
                });
                _saveChanges();
              },
            ),
            // Power Input Field
            TextField(
              controller: powerController,
              decoration: InputDecoration(labelText: 'Power (lumens)'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  room.power = int.tryParse(value) ?? room.power;
                });
                _saveChanges();
              },
            ),
            SizedBox(height: 16),
            // Copy to Clipboard Button
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(
                    text:
                        'Room: ${room.name}, Type: ${room.lightType}, Power: ${room.power} lumens',
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Copied to clipboard!')),
                );
              },
              child: Text('Copy to Clipboard'),
            ),
          ],
        ),
      ),
    );
  }
}
