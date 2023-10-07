import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reddittask/feature/home_page/domain/entities/comment_entity.dart';
import 'package:reddittask/feature/home_page/presentation/bloc/home_event.dart';

import '../../../../core/image_manager.dart';
import '../bloc/home_bloc.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, required this.ourComment});

  final CommentEntity ourComment;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color.fromARGB(115, 65, 65, 65)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                ),
                child: Image.network(ourComment.image),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                ourComment.userName,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Text(
                ourComment.id.toString(),
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            ourComment.commentText,
            style: const TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            textDirection: TextDirection.rtl,
            children: [
              GestureDetector(
                onTap: () {
                  BlocProvider.of<HomeBloc>(context)
                      .add(VoteUpCommentEvent(commentId: ourComment.id));
                },
                child: Image(
                  image: AssetImage(
                    ourComment.voteUp
                        ? ImageManager.upArrowFilled
                        : ImageManager.upArrow,
                  ),
                  width: 30,
                  height: 30,
                  color: ourComment.voteUp ? Colors.orange : Colors.white,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                ourComment.numberOfVotes.toString(),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {
                  BlocProvider.of<HomeBloc>(context)
                      .add(VoteDownCommetEvent(commentId: ourComment.id));
                },
                child: Image(
                  image: AssetImage(
                    ourComment.votedown
                        ? ImageManager.downArrowFilled
                        : ImageManager.downArrow,
                  ),
                  width: 30,
                  height: 30,
                  color: ourComment.votedown ? Colors.blue : Colors.white,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                "replay",
                style: TextStyle(color: Colors.white),
              ),
              const Icon(
                Icons.replay,
                color: Colors.white,
              )
            ],
          )
        ],
      ),
    );
  }
}
