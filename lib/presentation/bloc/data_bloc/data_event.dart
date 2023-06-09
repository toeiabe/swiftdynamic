part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();

  @override
  List<Object> get props => [];
}

class AddData extends DataEvent {
  final User user;

  const AddData({required this.user});
  @override
  List<Object> get props => [user];
}

class DeleteData extends DataEvent {
  final User user;

  const DeleteData({required this.user});
  @override
  List<Object> get props => [user];
}
