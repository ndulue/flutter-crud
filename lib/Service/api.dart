import 'package:fluttercrud/data/post.dart';
import 'package:http/http.dart' as http;
String baseUrl = "http://127.0.0.1:300";

Future<List<Post>> getPosts() async {
  final response = await http.get("$baseUrl/posts");
  return postFromJson(response.body);
}

Future<http.Response> createPost(Post post) async {
  final response = await http.post(
      "$baseUrl/posts",
      headers: {
        "content-type": "application/json"
      },
      body: postToJson(post),
  );
  return response;
}

Future<http.Response> updatePost(Post post) async {
  final response = await http.put(
    "$baseUrl/posts/${post.id}",
    headers: {
      "content-type": "application/json"
    },
    body: postToJson(post),
  );
  return response;
}

Future<http.Response> deletePost(int id) async{
  final response = await http.delete(
    "$baseUrl/posts/$id",
  );
  return response;
}
