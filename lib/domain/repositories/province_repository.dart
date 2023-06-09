import 'package:dartz/dartz.dart';

import 'package:swift/domain/entites/amphure_entity.dart';
import 'package:swift/domain/entites/province_entity.dart';
import 'package:swift/domain/entites/tambon_entity.dart';

import '../../data/failure.dart';

abstract class ProvinceRepository {
  Future<Either<Failure, List<ProvinceEntity>>> getAllProvince();
}
