import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:swift/data/datasource/remote_datasource.dart';
import 'package:swift/data/exception.dart';
import 'package:swift/domain/entites/amphure_entity.dart';
import 'package:swift/domain/entites/province_entity.dart';
import 'package:swift/domain/entites/tambon_entity.dart';
import 'package:swift/domain/repositories/province_repository.dart';

import '../failure.dart';

class ProvinceRepositoryImpl implements ProvinceRepository {
  final RemoteDataSource remoteDataSource;

  ProvinceRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ProvinceEntity>>> getAllProvince() async {
    try {
      final result = await remoteDataSource.getAllProvince();
      return Right(result.map((e) => e.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
