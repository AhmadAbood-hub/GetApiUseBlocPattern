import 'package:bloc_api/post_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PostRepository {
  Future<List<PostModel>> fetchPosts() async {
    var response = await http.get('https://jsonplaceholder.typicode.com/posts');
    List<PostModel> posts = [ ];
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      data.map((post) => posts.add(PostModel.fromJson(post)));
      return posts;
    }
  }
}
