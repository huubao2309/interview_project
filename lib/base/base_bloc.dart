import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'base_event.dart';

abstract class BaseBloc {
  BaseBloc() {
    _eventStreamController.stream.listen((event) {
      if (event is! BaseEvent) {
        throw Exception('Invalid event');
      }

      dispatchEvent(event);
    });
  }

  final StreamController<BaseEvent> _processEventSubject =
      BehaviorSubject<BaseEvent>();

  final StreamController<bool> _loadingStreamController =
      StreamController<bool>();

  final StreamController<BaseEvent> _eventStreamController =
      StreamController<BaseEvent>();

  Sink<BaseEvent> get event => _eventStreamController.sink;

  Stream<bool> get loadingStream => _loadingStreamController.stream;

  Sink<bool> get loadingSink => _loadingStreamController.sink;

  Stream<BaseEvent> get processEventStream => _processEventSubject.stream;

  Sink<BaseEvent> get processEventSink => _processEventSubject.sink;

  void dispatchEvent(BaseEvent event);

  @mustCallSuper
  void dispose() {
    _eventStreamController.close();
    _loadingStreamController.close();
    _processEventSubject.close();
  }
}
