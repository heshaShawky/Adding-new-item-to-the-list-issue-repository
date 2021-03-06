import 'dart:async';

import 'package:add_issue/comments_repository.dart';
import 'package:add_issue/models/comment_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentsRepository commentsRepository;

  CommentsBloc(this.commentsRepository);
  
  @override
  CommentsState get initialState => CommentsInitial();

  @override
  Stream<CommentsState> mapEventToState(
    CommentsEvent event,
  ) async* {
    final currentState = state;

    if (event is FetchComments) {
      yield CommentsLoading();

      final comments = await commentsRepository.getAllComments(); 

      yield CommentsLoaded(comments);
    } else if (event is RefreshComments) {
      final comments = await commentsRepository.getAllComments(); 

      yield CommentsLoaded(comments);
    } else if (event is AddComment) {
      if (currentState is CommentsLoaded) {

        yield CommentsLoaded([...currentState.comments, Comment(
            body: event.content,
            postId: 2,
            name: '',
            id: 2,
            email: 'test@test.com'
          )]);
      }
    }
    
  }
}
