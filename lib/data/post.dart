import 'dart:convert';

class Post{
  int id;
  String name;
  String email;
  int age;

  Post({
    this.id,
    this.name,
    this.email,
    this.age
  });

  factory Post.fromJson(Map<String, dynamic> json){
    return Post(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      age: json['age']
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": id,
      "name": name,
      "email": email,
      "age": age
    };
  }

  @override
  String toString() {
    return 'Post{id: $id, name: $name, email: $email, age: $age}';
  }
}

List<Post> postFromJson(String strJson){
  final str = json.decode(strJson);
  return List<Post>.from(str.map((item) {
    return Post.fromJson(item);
  })
  );
}

String postToJson(Post data){
  final dyn = data.toJson();
  return json.encode(dyn);
}