import 'dart:ui';

enum GreenPicker {
  p0(Color(0xffdcffdf)),
  p10(Color(0xffc8ffcc)),
  p20(Color(0xffadffb4)),
  p30(Color(0xff7bff86)),
  p40(Color(0xff1bff2e)),
  p50(Color(0xff00ed14)),
  p60(Color(0xff00d913)),
  p70(Color(0xff00c611)),
  p80(Color(0xff00b10f)),
  p90(Color(0xff00960d)),
  p100(Color(0xff00960d)),
  chipTab(Color(0xffafe1ba)),
  background(Color(0xffedffed));

  const GreenPicker(this.color);
  final Color color;

  static Color getGreenFor(int index) {
    switch (index) {
      case 0: return GreenPicker.p0.color;
      case 1: return GreenPicker.p10.color;
      case 2: return GreenPicker.p20.color;
      case 3: return GreenPicker.p30.color;
      case 4: return GreenPicker.p40.color;
      case 5: return GreenPicker.p50.color;
      case 6: return GreenPicker.p60.color;
      case 7: return GreenPicker.p70.color;
      case 8: return GreenPicker.p80.color;
      case 9: return GreenPicker.p90.color;
      case 10: return GreenPicker.p100.color;
      default: throw ArgumentError;
    }
  }
}