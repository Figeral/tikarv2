import 'dart:async';

class DrawerStreams<T> {
  final _streamController = StreamController<T>.broadcast();
  Stream<T> get stream => _streamController.stream;
  void setStream(T data) {
    _streamController.add(data);
  }

  void close() => _streamController.close();
}
