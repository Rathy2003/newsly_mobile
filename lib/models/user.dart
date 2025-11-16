class User{
  int? id;
  String? username;
  String? email;
  String? profile;
  String? token;

  User(this.id, this.username,this.email, this.token,this.profile);
  factory User.fromJson(Map<String, dynamic> json) => User(json['id'], json['username'], json['email'], json['token'], json['full_image_path']);
}