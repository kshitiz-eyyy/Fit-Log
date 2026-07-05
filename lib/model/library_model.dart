class LibraryStateModel {
  final Map<String, List<Map<String, String>>> dynamicExerciseData;
  final List<String> muscleGroups;
  final bool enableTrainingSplitsFlag;

  LibraryStateModel({
    required this.dynamicExerciseData,
    required this.muscleGroups,
    required this.enableTrainingSplitsFlag,
  });

  factory LibraryStateModel.initial() {
    return LibraryStateModel(
      dynamicExerciseData: {},
      muscleGroups: [],
      enableTrainingSplitsFlag: true,
    );
  }

  LibraryStateModel copyWith({
    Map<String, List<Map<String, String>>>? dynamicExerciseData,
    List<String>? muscleGroups,
    bool? enableTrainingSplitsFlag,
  }) {
    return LibraryStateModel(
      dynamicExerciseData: dynamicExerciseData ?? this.dynamicExerciseData,
      muscleGroups: muscleGroups ?? this.muscleGroups,
      enableTrainingSplitsFlag: enableTrainingSplitsFlag ?? this.enableTrainingSplitsFlag,
    );
  }
}