abstract class BaseCubit<T> {
  void fetch();
  void fetchById(int id);
  void update(T data);
  void post(T data);
  void delete(int id);
}
