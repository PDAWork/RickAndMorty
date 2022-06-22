import 'package:dio/dio.dart';
import 'package:rick_and_morty/core/error/exception.dart';
import 'package:rick_and_morty/data/models/person_model.dart';

abstract class PersonRemoteDataSource {
  /// https://rickandmortyapi.com/api/charecter/?page=1 endpoint
  Future<List<PersonModel>> getAllPersons(int page);

  // https://rickandmortyapi.com/api/charecter/?name=rick endpoint
  Future<List<PersonModel>> searchPerson(String query);
}

class PersonRemoteDataSourceImpl extends PersonRemoteDataSource {
  final Dio dio;

  PersonRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PersonModel>> getAllPersons(int page) async {
    return await _getPersonFromUrl('character/?page=$page');
  }

  @override
  Future<List<PersonModel>> searchPerson(String query) async {
    return await _getPersonFromUrl('character/?name=$query');
  }

  Future<List<PersonModel>> _getPersonFromUrl(String url) async {
    // ignore: avoid_print
    print(url);
    print(dio.options.baseUrl);

    try {
      final response = await dio.get(url);
      return (response.data['results'] as List)
          .map((e) => PersonModel.fromJson(e))
          .toList();
    } on DioError catch (e) {
      print(e.message);
      throw ServerException();
    }
  }
}
