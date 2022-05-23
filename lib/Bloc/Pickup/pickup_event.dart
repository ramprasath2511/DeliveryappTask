part of 'pickup_bloc.dart';

abstract class PickupEvent extends Equatable {
  const PickupEvent();
}

class StartEvent extends PickupEvent{
String startAddress;
StartEvent(this.startAddress);
  @override
  List<Object?> get props => [startAddress];
}
class EndEvent extends PickupEvent{

  @override
  List<Object?> get props => [];
}