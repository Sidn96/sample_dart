import 'package:common/core/presentation/utils/riverpod_framework.dart';
import 'package:flutter/material.dart';

AsyncSnapshot<T> useCustomHook<T>(Future<T> Function() create) {
  final future = useMemoized(create, const []);
  return useFuture(future);
}