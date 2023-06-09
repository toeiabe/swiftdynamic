import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swift/data/model/province_model.dart';

import '../exception.dart';

abstract class RemoteDataSource {
  Future<List<Province>> getAllProvince();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<Province>> getAllProvince() async {
    final response = await client.get(Uri.parse(
        "https://raw.githubusercontent.com/kongvut/thai-province-data/master/api_province_with_amphure_tambon.json"));
    List body = json.decode(response.body);
    if (response.statusCode == 200) {
      return body.map((e) => Province.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
