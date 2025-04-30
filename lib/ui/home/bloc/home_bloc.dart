import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_template/base/bloc/base_bloc/base_bloc.dart';
import 'package:flutter_bloc_template/domain/entity/course/category_entity.dart';
import 'package:flutter_bloc_template/domain/entity/course/course_entity.dart';
import 'package:flutter_bloc_template/domain/entity/course/mentor_entity.dart';
import 'package:flutter_bloc_template/domain/entity/course/promote_entity.dart';
import 'package:flutter_bloc_template/domain/use_case/course/fetch_category_list_use_case.dart';
import 'package:flutter_bloc_template/domain/use_case/course/fetch_most_popular_course_use_case.dart';
import 'package:flutter_bloc_template/domain/use_case/course/fetch_promote_list_use_case.dart';
import 'package:flutter_bloc_template/domain/use_case/course/fetch_top_mentor_list_use_case.dart';
import 'package:flutter_bloc_template/domain/use_case/course/toggle_favourite_course_use_case.dart';
import 'package:flutter_bloc_template/ui/home/bloc/home_event.dart';
import 'package:flutter_bloc_template/ui/home/bloc/home_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  HomeBloc(
    this._fetchPromoteListUseCase,
    this._fetchMostPopularCourseUseCase,
    this._fetchTopMentorListUseCase,
    this._fetchCategoryListUseCase,
    this._toggleFavouriteCourseUseCase,
  ) : super(HomeState(categoryId: 'all')) {
    on<HomeDataRequestedEvent>(_onHomeDataRequestedEvent);
    on<HomeCategoryChangedEvent>(_onHomeCategoryChangedEvent);
  }

  final FetchPromoteListUseCase _fetchPromoteListUseCase;
  final FetchMostPopularCourseUseCase _fetchMostPopularCourseUseCase;
  final FetchTopMentorListUseCase _fetchTopMentorListUseCase;
  final FetchCategoryListUseCase _fetchCategoryListUseCase;
  final ToggleFavouriteCourseUseCase _toggleFavouriteCourseUseCase;

  // Future<void> _onHomeDataRequestedEvent(
  //     HomeDataRequestedEvent event, Emitter<HomeState> emit) async {
  //   return runAction(
  //     onAction: () async {
  //       final apiCalls = [
  //         _fetchPromoteListUseCase.invoke(null),
  //         _fetchTopMentorListUseCase.invoke(null),
  //         _fetchCategoryListUseCase.invoke(null),
  //         _fetchMostPopularCourseUseCase.invoke(null),
  //       ];
  //       final result = await Future.wait(apiCalls);

  //       final emitters = [
  //         (data) => emit(state.copyWith(promotes: data as List<PromoteEntity>)),
  //         (data) => emit(state.copyWith(mentors: data as List<MentorEntity>)),
  //         (data) =>
  //             emit(state.copyWith(categories: data as List<CategoryEntity>)),
  //         (data) => emit(state.copyWith(courses: data as List<CourseEntity>)),
  //       ];

  //       for (int i = 0; i < result.length; i++) {
  //         result[i].when(ok: emitters[i]);
  //       }
  //     },
  //   );
  // }

  Future<void> _onHomeDataRequestedEvent(
    HomeDataRequestedEvent event,
    Emitter<HomeState> emit,
  ) async {
    return runAction(
      onAction: () async {
        // 1) Fire all four calls in parallel
        final results = await Future.wait([
          _fetchPromoteListUseCase.invoke(null),
          _fetchTopMentorListUseCase.invoke(null),
          _fetchCategoryListUseCase.invoke(null),
          _fetchMostPopularCourseUseCase.invoke(null),
        ]);

        // 2) Unwrap each Result<T> into a List<…>, defaulting to [] on error
        final promotes = results[0].when(
          ok: (data) => data as List<PromoteEntity>,
          failure: (_) => <PromoteEntity>[],
        );
        final mentors = results[1].when(
          ok: (data) => data as List<MentorEntity>,
          failure: (_) => <MentorEntity>[],
        );
        final categories = results[2].when(
          ok: (data) => data as List<CategoryEntity>,
          failure: (_) => <CategoryEntity>[],
        );
        final courses = results[3].when(
          ok: (data) => data as List<CourseEntity>,
          failure: (_) => <CourseEntity>[],
        );

        // 3) Emit one new state with all four lists
        emit(state.copyWith(
          promotes: promotes,
          mentors: mentors,
          categories: categories,
          courses: courses,
        ));
      },
      // Optional: you can supply onError to do extra handling,
      // but CommonBloc is already showing/hiding the loading spinner
      onError: (err) {
        // e.g. log or show a toast — but you don't have an `error` field in HomeState
      },
    );
  }

  FutureOr<void> _onHomeCategoryChangedEvent(
      HomeCategoryChangedEvent event, Emitter<HomeState> emit) {
    emit(state.copyWith(categoryId: event.id));
  }
}
