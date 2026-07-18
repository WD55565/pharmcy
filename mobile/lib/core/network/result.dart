import 'package:freezed_annotation/freezed_annotation.dart';

import 'failure.dart';

part 'result.freezed.dart';

/// Generic success/failure wrapper returned by repositories, so callers
/// handle both outcomes explicitly instead of relying on thrown exceptions.
@freezed
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T data) = ResultSuccess<T>;

  const factory Result.failure(Failure failure) = ResultFailure<T>;
}
