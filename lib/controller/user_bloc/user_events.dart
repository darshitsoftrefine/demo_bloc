import 'package:equatable/equatable.dart';

abstract class UserEvents extends Equatable{}

class UserSubmittingEvent extends UserEvents {
  @override

  List<Object?> get props => [];
}

class UserSubmittedEvent extends UserEvents {
  @override

  List<Object?> get props => [];

}