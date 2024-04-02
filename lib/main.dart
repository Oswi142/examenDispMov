import 'package:flutter/material.dart';
import 'package:flutter_exam/models/post_model.dart';
import 'package:flutter_exam/services/post_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Posts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PostListPage(),
    );
  }
}

class PostListPage extends StatefulWidget {
  @override
  _PostListPageState createState() => _PostListPageState();
}

class _PostListPageState extends State<PostListPage> {
  late List<Post> _posts;
  final PostService _postService = PostService();

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    List<Post> posts = await _postService.getPosts();
    setState(() {
      _posts = posts;
    });
  }

  void _ratePost(Post post, int stars) {
    setState(() {
      post.rate(stars);
    });
  }

  void _filterByTopRatedPosts() {
    setState(() {
      _posts.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
      _posts = _posts.where((post) => post.rating == _posts.first.rating).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Posts'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: _filterByTopRatedPosts,
          ),
        ],
      ),
      body: _posts != null
          ? ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_posts[index].title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_posts[index].body),
                        SizedBox(height: 10),
                        Text('Calificación: ${_posts[index].rating ?? "No calificado"}'),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.star),
                              onPressed: () => _ratePost(_posts[index], 1),
                              color: _posts[index].rating == 1 ? Colors.yellow : Colors.grey,
                            ),
                            IconButton(
                              icon: Icon(Icons.star),
                              onPressed: () => _ratePost(_posts[index], 2),
                              color: _posts[index].rating == 2 ? Colors.yellow : Colors.grey,
                            ),
                            IconButton(
                              icon: Icon(Icons.star),
                              onPressed: () => _ratePost(_posts[index], 3),
                              color: _posts[index].rating == 3 ? Colors.yellow : Colors.grey,
                            ),
                            IconButton(
                              icon: Icon(Icons.star),
                              onPressed: () => _ratePost(_posts[index], 4),
                              color: _posts[index].rating == 4 ? Colors.yellow : Colors.grey,
                            ),
                            IconButton(
                              icon: Icon(Icons.star),
                              onPressed: () => _ratePost(_posts[index], 5),
                              color: _posts[index].rating == 5 ? Colors.yellow : Colors.grey,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
