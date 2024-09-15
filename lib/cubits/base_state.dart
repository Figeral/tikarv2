
abstract class BaseState<T> {
  const BaseState();
  factory BaseState.init() = Initial;
  factory BaseState.loading() = Loading;
  factory BaseState.success(T user) = Success;
  factory BaseState.error(String message) = Error;
}

class Initial<T> extends BaseState<T> {}

class Loading<T> extends BaseState<T> {}

class Success<T> extends BaseState<T> {
  T user;

  Success(this.user);
}

class Error<T> extends BaseState<T> {
  final String message;
  Error(this.message);
}
