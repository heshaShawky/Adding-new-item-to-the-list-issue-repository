import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  @override
  TestState get initialState => TestInitial();

  @override
  Stream<TestState> mapEventToState(
    TestEvent event,
  ) async* {
    if (event is StartTest) {
      print('Test been started');
    }    
  }
}
