import 'package:bloc_api/blocs/post_bloc/post_events.dart';
import 'package:bloc_api/blocs/post_bloc/post_states.dart';
import 'package:bloc_api/repository/post_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBloc extends Bloc<PostEvents, PostStates> {
  PostRepository repo;

  PostBloc(PostStates initialState, this.repo) : super(initialState);

  @override
  Stream<PostStates> mapEventToState(PostEvents event) async* {
    if (event is DoFetchEvent) {
      yield LoadingState();
      try {
        var posts = await repo.fetchPosts();
        yield FetchSuccsess(posts: posts);
      } catch (e) {
        yield ErrorState(message: e.toString());
      }
    }
  }
}
