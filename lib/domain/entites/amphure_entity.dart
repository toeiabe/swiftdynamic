import 'package:equatable/equatable.dart';
import 'package:swift/data/model/province_model.dart';
import 'package:swift/domain/entites/tambon_entity.dart';

class AmphureEntity extends Equatable {
  const AmphureEntity(this.id, this.nameTh, this.nameEn, this.tambon);

  final int id;
  final String nameTh;
  final String nameEn;

  final List<TambonEntity> tambon;
  @override
  List<Object?> get props => [id, nameTh, nameEn, tambon];
}
