import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_exam/models/post_model.dart';

class PostCubit extends Cubit<List<Post>> {
  final List<Post> posts;

  PostCubit(this.posts) : super(posts);

  void filterByTopRatedPosts() {
    if (state.isNotEmpty && state.every((post) => post.rating != null)) {
      state.sort((a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
      emit(state.where((post) => post.rating == state.first.rating).toList());
    }
  }

  void resetFilter() {
    emit(posts);
  }
}
