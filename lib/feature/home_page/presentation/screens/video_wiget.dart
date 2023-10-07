import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddittask/core/image_manager.dart';
import 'package:reddittask/feature/home_page/presentation/bloc/home_event.dart';
import 'package:reddittask/feature/home_page/presentation/widget/write_comment.dart';
import 'package:video_player/video_player.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';
import '../widget/comments_widget.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool comment = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      ),
    );
    _controller.setVolume(1);
    _controller.play();
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: comment == false
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          comment = false;
                          // print(comment);
                        });
                      },
                      child: FutureBuilder(
                        future: _initializeVideoPlayerFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Center(
                              child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: VideoPlayer(
                                  _controller,
                                ),
                              ),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                    ),
                    comment == true ? const CommentsWidget() : const SizedBox(),
                  ],
                ),
                comment == false
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                          ),
                                          child: Image.network(
                                            "https://cdn-icons-png.flaticon.com/512/1384/1384067.png",
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        const Text(
                                          "user name ",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          .7,
                                      child: const Text(
                                        "here we will put the caption for the post and this caption will be in muilt line  not will be in single line",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<HomeBloc>(context)
                                            .add(VoteUpEvent());
                                      },
                                      child: Image(
                                        image: AssetImage(
                                          state.voteUp
                                              ? ImageManager.upArrowFilled
                                              : ImageManager.upArrow,
                                        ),
                                        width: 30,
                                        height: 30,
                                        color: state.voteUp
                                            ? Colors.orange
                                            : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      state.votesCount.toString(),
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<HomeBloc>(context)
                                            .add(VoteDownEvent());
                                      },
                                      child: Image(
                                        image: AssetImage(
                                          state.voteDown
                                              ? ImageManager.downArrowFilled
                                              : ImageManager.downArrow,
                                        ),
                                        width: 30,
                                        height: 30,
                                        color: state.voteDown
                                            ? Colors.blue
                                            : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          comment = !comment;
                                          // print(comment);
                                        });
                                      },
                                      child: const Icon(
                                        Icons.message_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // If the video is playing, pause it.
                                      if (state.playAndPause == true) {
                                        BlocProvider.of<HomeBloc>(context)
                                            .add(PlayAndPauseVideoEvent());
                                        _controller.pause();
                                      } else {
                                        BlocProvider.of<HomeBloc>(context)
                                            .add(PlayAndPauseVideoEvent());
                                        // If the video is paused, play it.
                                        _controller.play();
                                      }
                                    });
                                  },
                                  child: Icon(
                                    state.playAndPause == true
                                        ? Icons.pause
                                        : Icons.play_arrow,
                                    color: Colors.white,
                                  ),
                                ),
                                Expanded(
                                  // width: 200,
                                  child: VideoProgressIndicator(
                                    _controller,
                                    padding: const EdgeInsets.only(
                                        right: 20, left: 20),
                                    allowScrubbing: true,
                                    colors: const VideoProgressColors(
                                      playedColor: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  "${_controller.value.duration.inMinutes} : ${_controller.value.duration.inSeconds}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      // If the video is playing, pause it.
                                      if (state.muteVideo == true) {
                                        BlocProvider.of<HomeBloc>(context)
                                            .add(MuteVideoEvent());
                                        _controller.setVolume(0);
                                      } else {
                                        BlocProvider.of<HomeBloc>(context)
                                            .add(MuteVideoEvent());
                                        // If the video is paused, play it.
                                        _controller.setVolume(1);
                                      }
                                    });
                                  },
                                  child: Icon(
                                    state.muteVideo == true
                                        ? Icons.volume_up_rounded
                                        : Icons.volume_off,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : const WriteComment(),
              ],
            ),
          );
        },
      ),
    );
  }
}
