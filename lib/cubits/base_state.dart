abstract class BaseState<T> {
  const BaseState();
  factory BaseState.init() = Initial;
  factory BaseState.loading() = Loading;
  factory BaseState.success(T data) = Success;
  factory BaseState.error(String message) = Error;
  factory BaseState.notFound() = NotFound;
  factory BaseState.valid() = Valid;
}

class Initial<T> extends BaseState<T> {}

class Loading<T> extends BaseState<T> {}

class Valid<T> extends BaseState<T> {}

class Success<T> extends BaseState<T> {
  T data;

  Success(this.data);
}

class NotFound<T> extends BaseState<T> {}

class Error<T> extends BaseState<T> {
  final String message;
  Error(this.message);
}
