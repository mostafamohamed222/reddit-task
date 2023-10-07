class CommentEntity {
  String userName;
  String image;
  String time;
  String commentText;
  bool voteUp;
  bool votedown;
  int numberOfVotes;
  int id;

  CommentEntity.empty({
    this.commentText = "",
    this.numberOfVotes = 0,
    this.time = "5h",
    this.voteUp = false,
    this.votedown = false,
    this.userName = "mostafa",
    this.image = "https://cdn-icons-png.flaticon.com/512/1384/1384067.png",
    this.id = 0,
  });

  CommentEntity({
    required this.commentText,
    required this.image,
    required this.numberOfVotes,
    required this.time,
    required this.userName,
    required this.voteUp,
    required this.votedown,
    required this.id,
  });

  CommentEntity copyWith({
    String? userName,
    String? image,
    String? time,
    String? commentText,
    bool? voteUp,
    bool? votedown,
    int? numberOfVotes,
    int? id,
  }) {
    return CommentEntity(
      commentText: commentText ?? this.commentText,
      image: image ?? this.image,
      numberOfVotes: numberOfVotes ?? this.numberOfVotes,
      time: time ?? this.time,
      userName: userName ?? this.userName,
      voteUp: voteUp ?? this.voteUp,
      votedown: votedown ?? this.votedown,
      id: id ?? this.id,
    );
  }
}
