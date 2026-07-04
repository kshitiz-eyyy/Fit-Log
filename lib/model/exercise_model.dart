class Exercise {
  final String id;
  final String name;
  final String image;
  final String video;
  final String instructions;
  final String muscle;
  final String level;
  final String equipment;

  Exercise({
    required this.id, required this.name, required this.image,
    required this.video, required this.instructions,
    required this.muscle, required this.level, required this.equipment,
  });

  factory Exercise.fromMap(Map<String, dynamic> map, String id) {
    return Exercise(
      id: id,
      name: map['name'] ?? 'Unknown',
      image: map['image'] ?? '',
      video: map['video'] ?? '',
      instructions: map['instructions'] ?? '',
      muscle: map['muscle'] ?? '',
      level: map['level'] ?? '',
      equipment: map['equipment'] ?? '',
    );
  }
}