class Exercise {
  final int id;
  final String name;
  final String targetArea;
  final String difficulty;
  final String description;
  final String videoUrl;

  Exercise({
    required this.id,
    required this.name,
    required this.targetArea,
    required this.difficulty,
    required this.description,
    required this.videoUrl,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'],
      name: json['name'],
      targetArea: json['targetArea'],
      difficulty: json['difficulty'],
      description: json['description'],
      videoUrl: json['videoUrl'],
    );
  }
}
