part of 'pickup_bloc.dart';

abstract class PickupState extends Equatable {
  const PickupState();
}

class PickupInitial extends PickupState {
  @override
  List<Object> get props => [];
}
class LoadingStart extends PickupState {
@override
List<Object?> get props => [];
}

class SuccessStart extends PickupState {
  final String? startAddress1;
  SuccessStart({this.startAddress1 =""});
  SuccessStart copyWith({ String? startAddress1})
  => SuccessStart(startAddress1: startAddress1 ?? this.startAddress1);


  @override
  List<Object?> get props => [];
}

class FailureStart extends PickupState {
  String? error;
  FailureStart( this.error);
  @override
  List<Object?> get props => [error];
}
