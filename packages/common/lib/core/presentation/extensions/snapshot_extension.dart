
import 'package:flutter/material.dart';

extension SnapshotExtension<T, R> on AsyncSnapshot<T> {
  R when({
    required R Function(T data) data,
    required R Function(Object error, StackTrace stackTrace) error,
    required R Function() loading,
  }) =>
      switch (this) {
        // AsyncSnapshot(hasData: true, data: T d) => data(d),
        AsyncSnapshot(connectionState: ConnectionState.done, data: T d) => data(d),
        AsyncSnapshot(hasError: true, error: Object e, stackTrace: StackTrace s) => error(e, s),
        _ => loading(),
      };
}