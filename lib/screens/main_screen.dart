import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/room_provider.dart';
import 'room_config_screen.dart';
import '../widgets/custom_toggle_buttons.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final roomProvider = Provider.of<RoomProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lights',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true, // Center the title if desired
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'All rooms.',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                CustomToggleButtons(
                  onOffPressed: () {
                    roomProvider.turnAllOff();
                  },
                  onOnPressed: () {
                    roomProvider.turnAllOn();
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            // Room List
Expanded(
  child: ListView.builder(
    itemCount: roomProvider.rooms.length,
    itemBuilder: (context, index) {
      final room = roomProvider.rooms[index];

      // Determine the correct icon based on the room's state
      String iconPath;
      if (room.isOutOfOrder) {
        iconPath = 'assets/warning_purple.png';
      } else if (room.intensity > 0) {
        iconPath = 'assets/light_on_purple.png';
      } else {
        iconPath = 'assets/light_off_purple.png';
      }

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            // Icon and Room Name
            Column(
              children: [
                // Icon
                Image.asset(
                  iconPath,
                  width: 32,
                  height: 32,
                ),
                // Room Name
                Text(
                  room.name,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
            SizedBox(width: 8),
            // Slider and Intensity
            Expanded(
              child: Column(
                children: [
                  Slider(
                    value: room.intensity,
                    onChanged: room.isOutOfOrder
                        ? null
                        : (value) {
                            room.intensity = value;
                            room.isOn = value > 0;
                            roomProvider.updateRoom(room);
                          },
                    min: 0.0,
                    max: 1.0,
                    divisions: 100,
                    label: '${(room.intensity * 100).round()}%',
                  ),
                  // Current Intensity Value
                  Text(
                    '${(room.intensity * 100).round()}%',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
            // Settings Button
            IconButton(
              icon: Image.asset(
                'assets/settings_purple.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RoomConfigScreen(room: room),
                  ),
                );
              },
            ),
          ],
        ),
      );
    },
  ),
),
          ],
        ),
      ),
    );
  }
}