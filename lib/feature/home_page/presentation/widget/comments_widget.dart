import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';
import 'bottom_sheet_option.dart';
import 'cooment_card.dart';

class CommentsWidget extends StatelessWidget {
  const CommentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Expanded(
          child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.black,
              ),
              child: ListView.builder(
                itemCount: state.comments.length + 1,
                itemBuilder: (context, index) {
                  return index == state.comments.length
                      ? const SizedBox(
                          height: 100,
                        )
                      : GestureDetector(
                          onLongPress: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.black,
                              constraints: BoxConstraints(
                                  minWidth: MediaQuery.of(context).size.width,
                                  maxHeight:
                                      MediaQuery.of(context).size.height * .4),
                              context: context,
                              builder: (context) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    BottomSheetOption(
                                      onTap: () {},
                                      icon: const Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                      text: "share",
                                    ),
                                    BottomSheetOption(
                                      onTap: () {},
                                      icon: const Icon(
                                        Icons.save,
                                        color: Colors.white,
                                      ),
                                      text: "save",
                                    ),
                                    BottomSheetOption(
                                      onTap: () {},
                                      icon: const Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                      ),
                                      text: "stop reply notification",
                                    ),
                                    BottomSheetOption(
                                      onTap: () {},
                                      icon: const Icon(
                                        Icons.copy,
                                        color: Colors.white,
                                      ),
                                      text: "copy Text",
                                    ),
                                    BottomSheetOption(
                                      onTap: () {},
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                      text: "edit",
                                    ),
                                    BottomSheetOption(
                                      onTap: () {
                                        BlocProvider.of<HomeBloc>(context).add(
                                            DeleteCommentEvent(
                                                commentId:
                                                    state.comments[index].id));
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                      text: "delete",
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: const Color.fromARGB(
                                              255, 74, 73, 73),
                                        ),
                                        child: const Center(
                                            child: Text(
                                          "close",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                      ),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                          child: CommentCard(
                            ourComment: state.comments[index],
                          ),
                        );
                },
              )),
        );
      },
    );
  }
}
