
class Imagee {
  String image;
  Imagee({
    required this.image,
  });
  



 factory Imagee.fromJson(dynamic json) {
    return Imagee(image:json!['image'] as String);
  }
  @override
  String toString() {
    return '{ ${this.image} }';
  }
}
