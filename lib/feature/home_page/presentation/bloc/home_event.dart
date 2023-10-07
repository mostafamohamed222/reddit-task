abstract class HomeEvent {}

class PlayAndPauseVideoEvent extends HomeEvent {}

class MuteVideoEvent extends HomeEvent {}

class VoteUpEvent extends HomeEvent {}

class VoteDownEvent extends HomeEvent {}

class VoteUpCommentEvent extends HomeEvent {
  int commentId;
  VoteUpCommentEvent({required this.commentId});
}

class VoteDownCommetEvent extends HomeEvent {
  int commentId;
  VoteDownCommetEvent({required this.commentId});
}

class WriteCommentEvent extends HomeEvent {}

class CreateNewComment extends HomeEvent {
  String commentText;
  CreateNewComment({required this.commentText});
}

class DeleteCommentEvent extends HomeEvent {
  int commentId;
  DeleteCommentEvent({required this.commentId});
}
