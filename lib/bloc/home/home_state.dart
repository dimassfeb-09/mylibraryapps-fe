part of 'home_bloc.dart';

class HomeState {
  final int userId;
  final String uuid;
  HomeState({
    this.userId = 0,
    this.uuid = "",
  });
}

class HomeInitial extends HomeState {}

class HomeGetUserInfoState extends HomeState {
  final int userId;
  final String uuid;
  HomeGetUserInfoState(this.userId, this.uuid) : super(userId: userId, uuid: uuid);
}
