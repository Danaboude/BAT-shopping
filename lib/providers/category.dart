class Category {
  int categoryid;
  String title;
  String logo;

  Category({
    required this.categoryid,
    required this.title,
    required this.logo,
  });
  Category.fromJson(Map<String, dynamic> json)
      : categoryid = json["id"],
        logo = json["logo"],
        title = json["title"];
}
