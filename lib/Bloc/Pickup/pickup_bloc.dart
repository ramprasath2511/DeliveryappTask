import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pickup_event.dart';
part 'pickup_state.dart';

class PickupBloc extends Bloc<PickupEvent, PickupState> {
  String? startAddress;
  String? message;
  PickupBloc() : super(PickupInitial()) {
    on<StartEvent> (_startLocation);

    }
    void _startLocation( StartEvent event, Emitter<PickupState> emit ) async {

      String startLocation = StartEvent(startAddress!) as String;
      print(startLocation);



    }
  }
