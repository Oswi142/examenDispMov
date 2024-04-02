import 'package:dio/dio.dart';
import 'package:flutter_exam/models/post_model.dart';

class PostService {
  final Dio _dio = Dio();

  Future<List<Post>> getPosts() async {
    try {
      Response response = await _dio.get('https://jsonplaceholder.typicode.com/posts');
      List<dynamic> responseData = response.data;
      List<Post> posts = responseData.map((json) => Post.fromJson(json)).toList();
      return posts;
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }
}
