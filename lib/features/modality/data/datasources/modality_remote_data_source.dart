import 'dart:convert';

import 'package:movpass_app/core/error/exception.dart';
import 'package:movpass_app/features/modality/data/models/modality_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class ModalityRemoteDataSource {
  Future<List<ModalityModel>> getAllModalities();

  Future<ModalityModel> getModalityById(int id);
}

class ModalityRemoteDataSourceImpl implements ModalityRemoteDataSource {
  final http.Client client;

  ModalityRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<ModalityModel>> getAllModalities() async {
    // TODO: implement getAllModalities
    final response = await client.get(
      'https://dev.movpass.com.br/api/modalities',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List list = json.decode(response.body) as List<dynamic>;

      return list
          .map<ModalityModel>(
              (map) => ModalityModel.fromJson(map as Map<String, dynamic>))
          .toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ModalityModel> getModalityById(int id) async {
    final response = await client.get(
      'https://dev.movpass.com.br/api/modalities/$id',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return ModalityModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }
}
