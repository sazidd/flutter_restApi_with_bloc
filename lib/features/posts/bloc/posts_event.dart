part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class PostsInitialFetchEvents extends PostsEvent {}

class PostAddEvent extends PostsEvent {}
