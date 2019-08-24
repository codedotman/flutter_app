
class News {
  int id;
  String title;
  String description;
  String image;
  String createdAt;
  String updatedAt;

  News({this.id, this.title, this.description, this.image, this.createdAt, this.updatedAt});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}