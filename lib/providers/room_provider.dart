import 'package:flutter/material.dart';
import '../models/room_model.dart';

class RoomProvider with ChangeNotifier {
  List<RoomModel> _rooms = [
    RoomModel(name: 'Entrance'),
    RoomModel(name: 'Office 1'),
    RoomModel(name: 'Office 2'),
    RoomModel(name: 'Supply Room', isOutOfOrder: true),
  ];


  List<RoomModel> get rooms => _rooms;

  void updateRoom(RoomModel room) {
    int index = _rooms.indexWhere((r) => r.name == room.name);
    if (index != -1) {
      _rooms[index] = room;
      notifyListeners();
    }
  }

  void turnAllOff() {
    for (var room in _rooms) {
      if (!room.isOutOfOrder) {
        room.isOn = false;
        room.intensity = 0.0;
      }
    }
    notifyListeners();
  }

  void turnAllOn() {
    for (var room in _rooms) {
      if (!room.isOutOfOrder) {
        room.isOn = true;
        room.intensity = 1.0;
      }
    }
    notifyListeners();
  }
}
