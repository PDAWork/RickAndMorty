import 'package:dartz/dartz.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/domain/entities/person_entity.dart';

abstract class PersonRepository {
  /// Все записи
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page);

  /// Поиск данных
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
