class Category{
  final int? id;
  final String name;
  final String? createdAt;
  final String? updatedAt;

  Category({this.id,required this.name,this.createdAt,this.updatedAt});
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}