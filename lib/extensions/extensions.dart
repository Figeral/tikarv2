import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension MediaQueryManager on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  T cubit<T extends Cubit>() => BlocProvider.of<T>(this);
}
