import 'package:equatable/equatable.dart';
import 'package:swift/domain/entites/amphure_entity.dart';

class ProvinceEntity extends Equatable {
  const ProvinceEntity(
      this.id, this.nameTh, this.nameEn, this.geographyId, this.amphure);

  final int id;
  final String nameTh;
  final String nameEn;
  final int geographyId;
  final List<AmphureEntity> amphure;
  @override
  List<Object?> get props => [id, nameTh, nameEn, geographyId, amphure];
}
