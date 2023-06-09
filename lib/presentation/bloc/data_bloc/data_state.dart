part of 'data_bloc.dart';

class DataState extends Equatable {
  final List<User> users;

  const DataState(this.users);

  @override
  List<Object> get props => [users];
}
