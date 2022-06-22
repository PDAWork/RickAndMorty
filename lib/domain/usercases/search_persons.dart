import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/core/usecases/usecase.dart';
import 'package:rick_and_morty/domain/entities/person_entity.dart';
import 'package:rick_and_morty/domain/repositories/person_repository.dart';

class SearchPerson implements UseCase<List<PersonEntity>, SearchPersonParams> {
  final PersonRepository _persolRepository;

  SearchPerson(this._persolRepository);

  @override
  Future<Either<Failure, List<PersonEntity>>> call(SearchPersonParams params) {
    return _persolRepository.searchPerson(params.query);
  }
}

class SearchPersonParams extends Equatable {
  final String query;

  const SearchPersonParams({required this.query});

  @override
  List<Object?> get props => [query];
}
