class MySlider {
  int id;
  String titleensm;
  String titleenbig;
  String titlear;
  String image;
  MySlider({
    required this.id,
    required this.titleensm,
    required this.titleenbig,
    required this.titlear,
    required this.image,
  });
  factory MySlider.fromJson(dynamic json) {
    return MySlider(
        id: json['id'] as int,
        titleensm: json['title_en_sm'] as String,
        titleenbig: json['title_en_big'] as String,
        titlear: json['title_ar'] as String,
        image: json['image'] as String);
  }

  @override
  String toString() {
    return 'mySlider(id: $id, titleensm: $titleensm, titleenbig: $titleenbig, titlear: $titlear, image: $image)';
  }
}
