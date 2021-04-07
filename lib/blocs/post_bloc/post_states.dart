import 'package:bloc_api/post_model.dart';
import 'package:equatable/equatable.dart';

class PostStates extends Equatable{
  @override
  List<Object> get props => [];
}

class InitialState extends PostStates {}

class LoadingState extends PostStates {}

class FetchSuccsess extends PostStates {
  List<PostModel> posts;
  FetchSuccsess({this.posts});
}

class ErrorState extends PostStates {
  String message;
  ErrorState({this.message});
}


