
class Color1 {
  String color;
  
  Color1({
    required this.color,
  });

 factory Color1.fromJson(dynamic json) {
    return Color1(color:json['color'] as String);
  }
  @override
  String toString() {
    return '{ ${this.color} }';
  }
}
