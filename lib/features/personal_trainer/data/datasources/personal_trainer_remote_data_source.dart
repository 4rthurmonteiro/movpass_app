import 'package:movpass_app/core/error/exception.dart';
import 'package:movpass_app/features/personal_trainer/data/models/personal_trainer_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'dart:convert';

abstract class PersonalTrainerRemoteDataSource {

  Future<List<PersonalTrainerModel>> getAllPersonalTrainers();

  Future<PersonalTrainerModel> getPersonalTrainerById(int id);

}

class PersonalTrainerRemoteDataSourceImpl implements PersonalTrainerRemoteDataSource {
  final http.Client client;

  PersonalTrainerRemoteDataSourceImpl({@required this.client});

  @override
  Future<List<PersonalTrainerModel>> getAllPersonalTrainers() async {
    final response = await client.get(
      'https://dev.movpass.com.br/api/personal-trainers/',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List list = json.decode(response.body) as List<dynamic>;

      return list
          .map<PersonalTrainerModel>(
              (map) => PersonalTrainerModel.fromJson(map as Map<String, dynamic>))
          .toList();
    }else{
      throw ServerException();

    }
  }

  @override
  Future<PersonalTrainerModel> getPersonalTrainerById(int id) async {
    final response = await client.get(
      'https://dev.movpass.com.br/api/personal-trainers/$id',
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return PersonalTrainerModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw ServerException();
    }
  }
}
