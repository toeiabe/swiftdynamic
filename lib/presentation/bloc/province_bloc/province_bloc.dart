import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:swift/domain/entites/province_entity.dart';
import 'package:swift/domain/usecases/provinces_usecase.dart';
import 'package:swift/injection.dart' as di;

part 'province_event.dart';
part 'province_state.dart';

class ProvinceBloc extends Bloc<ProvinceEvent, ProvinceState> {
  final GetProvince getProvince = di.locator<GetProvince>();
  ProvinceBloc() : super(ProvinceInitial()) {
    on<ProvinceQuery>((event, emit) async {
      emit(ProvinceLoading());
      final result = await getProvince.execute();

      if (result.isRight()) {
        List<ProvinceEntity> provinceEntity =
            result.getOrElse(() => throw UnimplementedError());
        emit(ProvinceHasData(provinceEntity));
      }
    });
  }
}
