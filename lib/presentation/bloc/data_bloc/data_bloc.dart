import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:swift/domain/entites/user_entity.dart';

part 'data_event.dart';
part 'data_state.dart';

class DataBloc extends Bloc<DataEvent, DataState> {
  DataBloc() : super(DataState([])) {
    on<AddData>((event, emit) {
      final users = this.state.users;
      final newList = users.toList()..add(event.user);
      emit(DataState(newList));
    });

    on<DeleteData>((event, emit) {
      final users = this.state.users;
      final newList = users
          .toList()
          .where(
            (element) => element != event.user,
          )
          .toList();

      emit(DataState(newList));
    });
  }
}
