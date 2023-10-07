import 'package:reddittask/feature/home_page/domain/entities/comment_entity.dart';

class HomeState {
  bool playAndPause;
  bool muteVideo;
  bool voteUp;
  bool voteDown;
  int votesCount;
  List<CommentEntity> comments;
  bool writeComment;

  HomeState({
    this.playAndPause = true,
    this.muteVideo = true,
    this.voteUp = false,
    this.voteDown = false,
    this.writeComment = false,
    this.votesCount = 387,
    this.comments = const [],
  });

  HomeState copyWith({
    bool? playAndPause,
    bool? muteVideo,
    bool? voteUp,
    bool? voteDown,
    bool? writeComment,
    int? votesCount,
    List<CommentEntity>? comments,
  }) {
    return HomeState(
      playAndPause: playAndPause ?? this.playAndPause,
      muteVideo: muteVideo ?? this.muteVideo,
      voteUp: voteUp ?? this.voteUp,
      voteDown: voteDown ?? this.voteDown,
      votesCount: votesCount ?? this.votesCount,
      writeComment: writeComment ?? this.writeComment,
      comments: comments ?? this.comments,
    );
  }
}
