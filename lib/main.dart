import 'package:bloc_api/blocs/post_bloc/post_bloc.dart';
import 'package:bloc_api/blocs/post_bloc/post_events.dart';
import 'package:bloc_api/blocs/post_bloc/post_states.dart';
import 'package:bloc_api/repository/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MaterialApp(
    home: BlocProvider(
      create: (context) => PostBloc(InitialState(), PostRepository()),
      child: PostUi(),
    ),
  ));
}

class PostUi extends StatefulWidget {
  @override
  _PostUiState createState() => _PostUiState();
}

class _PostUiState extends State<PostUi> {
  PostBloc bloc;

  @override
  void initState() {
    bloc = BlocProvider.of<PostBloc>(context);
    bloc.add(DoFetchEvent());
    super.initState();
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<PostBloc, PostStates>(
          builder: (context, state) {
            if (state is InitialState) {
              return CircularProgressIndicator();
            } else if (state is LoadingState) {
              return CircularProgressIndicator();
            } else if (state is FetchSuccsess) {
              return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(state.posts[index].title),
                      subtitle: Text(state.posts[index].body),
                    );
                  });
            } else if (state is ErrorState) {
              return ErrorWidget(state.message.toString());
            }
          },
        ),
      ),
    );
  }
}
