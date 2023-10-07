import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_event.dart';
import '../bloc/home_state.dart';

class WriteComment extends StatefulWidget {
  const WriteComment({super.key});

  @override
  State<WriteComment> createState() => _WriteCommentState();
}

class _WriteCommentState extends State<WriteComment> {
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            state.writeComment == true
                ? Container(
                    color: Colors.black,
                    child: const Row(
                      children: [
                        Text(
                          "please follow",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "community rules ",
                          style: TextStyle(color: Colors.blue),
                        ),
                        Text(
                          "when commenting",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
            Focus(
              onFocusChange: (value) {
                if (value == false) {
                  BlocProvider.of<HomeBloc>(context).add(WriteCommentEvent());
                }
              },
              child: TextFormField(
                style: const TextStyle(color: Colors.white),
                onTap: () {
                  BlocProvider.of<HomeBloc>(context).add(WriteCommentEvent());
                },
                // focusNode: state.writeComment == true ? FocusNode() : null,
                autofocus: state.writeComment == true ? true : false,
                controller: comment,
                cursorColor: Colors.white,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  suffixIcon: const Icon(Icons.image),
                  filled: true,
                  fillColor: Colors.black,
                  hintText: "add a comment",
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "من فضلك ادخل الاسم كامل";
                  }
                  return null;
                },
              ),
            ),
            state.writeComment == true
                ? Container(
                    color: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            if (comment.text.isNotEmpty) {
                              BlocProvider.of<HomeBloc>(context).add(
                                  CreateNewComment(commentText: comment.text));
                              comment.clear();
                            }
                          },
                          child: const Text("replay"),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        );
      },
    );
  }
}
