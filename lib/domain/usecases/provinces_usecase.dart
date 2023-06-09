import 'package:dartz/dartz.dart';
import 'package:swift/domain/entites/province_entity.dart';

import '../../data/failure.dart';
import '../repositories/province_repository.dart';

class GetProvince {
  final ProvinceRepository repository;

  GetProvince(this.repository);

  Future<Either<Failure, List<ProvinceEntity>>> execute() async {
    return await repository.getAllProvince();
  }
}
