import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddittask/feature/home_page/domain/entities/comment_entity.dart';
import 'package:reddittask/feature/home_page/presentation/bloc/home_event.dart';
import 'package:reddittask/feature/home_page/presentation/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState()) {
    on<PlayAndPauseVideoEvent>(_playAndPauseVideo);
    on<MuteVideoEvent>(_muteVideo);
    on<VoteUpEvent>(_voteUp);
    on<VoteDownEvent>(_voteDown);
    on<WriteCommentEvent>(_writeComment);
    on<CreateNewComment>(_createNewComment);
    on<VoteUpCommentEvent>(_voteUpComment);
    on<VoteDownCommetEvent>(_voteDownComment);
    on<DeleteCommentEvent>(_deleteComment);
  }
  static get(BuildContext context) => BlocProvider.of<HomeBloc>(context);

  FutureOr<void> _playAndPauseVideo(
      PlayAndPauseVideoEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(playAndPause: !state.playAndPause));
  }

  FutureOr<void> _muteVideo(MuteVideoEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(muteVideo: !state.muteVideo));
  }

  FutureOr<void> _voteDown(VoteDownEvent event, Emitter<HomeState> emit) {
    // check if vote up before vote down count-2 , already vote down remove it else vote down
    if (state.voteUp == true) {
      emit(state.copyWith(
          voteUp: false, voteDown: true, votesCount: state.votesCount - 2));
    } else if (state.voteDown == true) {
      emit(state.copyWith(voteDown: false, votesCount: state.votesCount + 1));
    } else {
      emit(state.copyWith(voteDown: true, votesCount: state.votesCount - 1));
    }
  }

  FutureOr<void> _voteUp(VoteUpEvent event, Emitter<HomeState> emit) {
    // check if vote down before vote down count+2 , already vote up remove it else vote up
    if (state.voteDown == true) {
      emit(state.copyWith(
          voteUp: true, voteDown: false, votesCount: state.votesCount + 2));
    } else if (state.voteUp == true) {
      emit(state.copyWith(voteUp: false, votesCount: state.votesCount - 1));
    } else {
      emit(state.copyWith(voteUp: true, votesCount: state.votesCount + 1));
    }
  }

  FutureOr<void> _voteUpComment(
      VoteUpCommentEvent event, Emitter<HomeState> emit) {
    // find the comment first
    int index =
        state.comments.indexWhere((element) => element.id == event.commentId);
    List<CommentEntity> ret = state.comments;
    if (ret[index].votedown == true) {
      ret[index] = ret[index].copyWith(
          voteUp: true,
          votedown: false,
          numberOfVotes: ret[index].numberOfVotes + 2);
    } else if (ret[index].voteUp == true) {
      ret[index] = ret[index]
          .copyWith(voteUp: false, numberOfVotes: ret[index].numberOfVotes - 1);
    } else {
      ret[index] = ret[index]
          .copyWith(voteUp: true, numberOfVotes: ret[index].numberOfVotes + 1);
    }

    emit(state.copyWith(comments: ret));
  }

  FutureOr<void> _voteDownComment(
      VoteDownCommetEvent event, Emitter<HomeState> emit) {
    int index =
        state.comments.indexWhere((element) => element.id == event.commentId);
    List<CommentEntity> ret = state.comments;
    if (ret[index].voteUp == true) {
      ret[index] = ret[index].copyWith(
          voteUp: false,
          votedown: true,
          numberOfVotes: ret[index].numberOfVotes - 2);
    } else if (ret[index].votedown == true) {
      ret[index] = ret[index].copyWith(
          votedown: false, numberOfVotes: ret[index].numberOfVotes + 1);
    } else {
      ret[index] = ret[index].copyWith(
          votedown: true, numberOfVotes: ret[index].numberOfVotes - 1);
    }

    emit(state.copyWith(comments: ret));
  }

  FutureOr<void> _writeComment(
      WriteCommentEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(writeComment: !state.writeComment));
  }

  FutureOr<void> _createNewComment(
      CreateNewComment event, Emitter<HomeState> emit) {
    List<CommentEntity> ret = state.comments;
    if (ret.length == 0) {
      CommentEntity newComment = CommentEntity(
        commentText: event.commentText,
        image: "https://cdn-icons-png.flaticon.com/512/1384/1384067.png",
        numberOfVotes: 1,
        time: "1h",
        userName: "mostafa mohamed",
        voteUp: true,
        votedown: false,
        id: 1,
      );
      emit(state.copyWith(comments: [newComment]));
    } else {
      int newId = ret.last.id + 1;
      CommentEntity newComment = CommentEntity(
        commentText: event.commentText,
        image: "https://cdn-icons-png.flaticon.com/512/1384/1384067.png",
        numberOfVotes: 1,
        time: "1h",
        userName: "mostafa mohamed",
        voteUp: true,
        votedown: false,
        id: newId,
      );
      ret.add(newComment);
      emit(state.copyWith(comments: ret));
    }
  }

  FutureOr<void> _deleteComment(
      DeleteCommentEvent event, Emitter<HomeState> emit) {
    List<CommentEntity> ret = state.comments;

    ret.removeWhere((element) => element.id == event.commentId);
    emit(state.copyWith(comments: ret));
  }
}
