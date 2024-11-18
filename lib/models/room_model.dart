class RoomModel {
  String name;
  bool isOn;
  bool isOutOfOrder;
  double _intensity; // from 0.0 to 1.0
  String lightType; // e.g., 'LED', 'Halogen'
  int power; 

  RoomModel({
    required this.name,
    this.isOn = true,
    this.isOutOfOrder = false,
    double intensity = 1.0,
    this.lightType = 'LED',
    this.power = 1000,
  }) : _intensity = intensity;

  double get intensity => isOutOfOrder ? 0.0 : _intensity;

  set intensity(double value) {
    if (!isOutOfOrder) {
      _intensity = value;
      isOn = value > 0;
    }
  }
}
