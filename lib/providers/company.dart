
class Company {
  String comname;
  Company({
    required this.comname,
  });

  
 factory Company.fromJson(dynamic json) {
    return Company(comname:json['company'] as String);
  }
  @override
  String toString() {
    return '{ ${this.comname} }';
  }
}
