import 'dart:async';

import 'package:flutter_restapi_with_bloc/features/posts/model/post_data_ui_model.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_restapi_with_bloc/features/posts/repos/posts_repo.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvents>(postsInitialFetchEvents);
    on<PostAddEvent>(postAddEvent);
  }

  FutureOr<void> postsInitialFetchEvents(
      PostsInitialFetchEvents event, Emitter<PostsState> emit) async {
    emit(PostsFetchingLoadingState());
    List<PostDataUiModel> posts = await PostsRepo.fetchPost();
    emit(PostFetchingSuccessfulState(posts: posts));
  }

  FutureOr<void> postAddEvent(
      PostAddEvent event, Emitter<PostsState> emit) async {
    bool success = await PostsRepo.addPost();
    if (success) {
      emit(PostsAdditionSuccessState());
    } else {
      emit(PostsAdditionErrorState());
    }
  }
}
