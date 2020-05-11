part of 'comments_bloc.dart';

abstract class CommentsState {
  const CommentsState();

  // @override
  // List<Object> get props => [];
}

class CommentsInitial extends CommentsState {}

class CommentsLoading extends CommentsState {}

class CommentsLoaded extends CommentsState {
  final List<Comment> comments;

  const CommentsLoaded(this.comments);

  // @override
  // List<Object> get props => [comments];
}

class CommentsFailure extends CommentsState {
  final String errMsg;

  const CommentsFailure(this.errMsg);

  // @override
  // List<Object> get props => [errMsg];
}
