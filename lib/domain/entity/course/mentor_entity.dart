class MentorEntity {
  final String id;
  final String name;
  final String title;
  final String avatarUrl;

  MentorEntity({
    required this.id,
    required this.name,
    required this.title,
    required this.avatarUrl,
  });

  static MentorEntity defaultValue() => MentorEntity(id: '', name: '', title: '', avatarUrl: '');
}
