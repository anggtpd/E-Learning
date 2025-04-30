class LessonResponseDto {
  final String id;
  final String title;
  final int duration;
  final String videoUrl;
  final bool isFree;

  LessonResponseDto({
    required this.id,
    required this.title,
    required this.duration,
    required this.videoUrl,
    required this.isFree,
  });

  factory LessonResponseDto.fromJson(Map<String, dynamic> json) {
    return LessonResponseDto(
      id: json['id'],
      title: json['title'],
      duration: json['duration'],
      videoUrl: json['videoUrl'],
      isFree: json['isFree'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration,
      'videoUrl': videoUrl,
      'isFree': isFree,
    };
  }
}
