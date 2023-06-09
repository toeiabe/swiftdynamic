import 'package:swift/domain/entites/province_entity.dart';
import 'package:swift/domain/entites/tambon_entity.dart';

import '../../domain/entites/amphure_entity.dart';

class Province {
  int? id;
  String? nameTh;
  String? nameEn;
  int? geographyId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<Amphure>? amphure;

  Province(
      {this.id,
      this.nameTh,
      this.nameEn,
      this.geographyId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.amphure});

  Province.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
    geographyId = json['geography_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['amphure'] != null) {
      amphure = <Amphure>[];
      json['amphure'].forEach((v) {
        amphure!.add(new Amphure.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_th'] = this.nameTh;
    data['name_en'] = this.nameEn;
    data['geography_id'] = this.geographyId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.amphure != null) {
      data['amphure'] = this.amphure!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  ProvinceEntity toEntity() => ProvinceEntity(id!, nameTh!, nameEn!,
      geographyId!, amphure!.map((e) => e.toEntity()).toList());
}

class Amphure {
  int? id;
  String? nameTh;
  String? nameEn;
  int? provinceId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  List<Tambon>? tambon;

  Amphure(
      {this.id,
      this.nameTh,
      this.nameEn,
      this.provinceId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.tambon});

  Amphure.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
    provinceId = json['province_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['tambon'] != null) {
      tambon = <Tambon>[];
      json['tambon'].forEach((v) {
        tambon!.add(new Tambon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_th'] = this.nameTh;
    data['name_en'] = this.nameEn;
    data['province_id'] = this.provinceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    if (this.tambon != null) {
      data['tambon'] = this.tambon!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  AmphureEntity toEntity() => AmphureEntity(
      id!, nameTh!, nameEn!, tambon!.map((e) => e.toEntity()).toList());
}

class Tambon {
  int? id;
  int? zipCode;
  String? nameTh;
  String? nameEn;
  int? amphureId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Tambon(
      {this.id,
      this.zipCode,
      this.nameTh,
      this.nameEn,
      this.amphureId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Tambon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    zipCode = json['zip_code'];
    nameTh = json['name_th'];
    nameEn = json['name_en'];
    amphureId = json['amphure_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['zip_code'] = this.zipCode;
    data['name_th'] = this.nameTh;
    data['name_en'] = this.nameEn;
    data['amphure_id'] = this.amphureId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }

  TambonEntity toEntity() => TambonEntity(id!, nameTh!, nameEn!, zipCode!);
}
