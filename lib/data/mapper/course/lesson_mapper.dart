import 'package:flutter_bloc_template/data/data_source/remote/dto/course/lesson_response_dto.dart';
import 'package:flutter_bloc_template/domain/entity/course/lesson_entity.dart';

abstract final class LessonMapper {
  const LessonMapper._();

  static LessonEntity mapToEntity(LessonResponseDto? dto) {
    return LessonEntity(
      id: dto?.id ?? '',
      title: dto?.title ?? '',
      duration: dto?.duration ?? 0,
      videoUrl: dto?.videoUrl ?? '',
      isFree: dto?.isFree ?? false,
    );
  }
}
