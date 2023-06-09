import 'package:equatable/equatable.dart';

class TambonEntity extends Equatable {
  const TambonEntity(
    this.id,
    this.nameTh,
    this.nameEn,
    this.zipcode,
  );

  final int id;
  final String nameTh;
  final String nameEn;

  final int zipcode;
  @override
  List<Object?> get props => [id, nameTh, nameEn, zipcode];
}
