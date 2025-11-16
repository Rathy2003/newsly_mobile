class News{
  int? id;
  String title;
  String description;
  String content;
  int categoryId;
  String categoryName;
  String fullImagePath;
  String postedAt;

  News({
    this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.categoryId,
    required this.categoryName,
    required this.fullImagePath,
    required this.postedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    content: json["content"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    fullImagePath: json["full_image_path"],
    postedAt: json["posted_at"],
  );
}