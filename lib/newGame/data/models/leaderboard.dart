class Leaderboard {
  Leaderboard({required this.login, required this.score, required this.time});

  Leaderboard.fromJson(Map<String, Object?> json)
      : this(
          login: json['login']! as String,
          score: json['score']! as int,
          time: json['time']! as int,
        );

  String? login;
  int? score;
  int? time;

  Map<String, Object?> toJson() {
    return {
      'login': login,
      'score': score,
      'time': time,
    };
  }
}
