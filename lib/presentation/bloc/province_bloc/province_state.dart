part of 'province_bloc.dart';

abstract class ProvinceState extends Equatable {
  const ProvinceState();

  @override
  List<Object> get props => [];
}

class ProvinceInitial extends ProvinceState {}

class ProvinceLoading extends ProvinceState {}

class ProvinceError extends ProvinceState {
  final String message;

  const ProvinceError(this.message);
}

class ProvinceHasData extends ProvinceState {
  final List<ProvinceEntity> provinceEntity;

  const ProvinceHasData(this.provinceEntity);
}
