part of 'home_bloc.dart';

abstract class HomeEvent {}

class HomeGetUserInfoEvent extends HomeEvent {
  final String uuid;
  HomeGetUserInfoEvent({this.uuid = ""});
}
