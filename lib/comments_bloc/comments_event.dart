part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();
}

class FetchComments extends CommentsEvent {
  @override
  List<Object> get props => null;
}

class RefreshComments extends CommentsEvent {
  @override
  List<Object> get props => null;
}

class AddComment extends CommentsEvent {
  final String content;

  const AddComment(this.content);
  
  @override
  List<Object> get props => [content];
}