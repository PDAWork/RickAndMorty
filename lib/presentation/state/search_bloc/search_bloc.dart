import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/failure.dart';
import 'package:rick_and_morty/domain/usercases/search_persons.dart';
import 'package:rick_and_morty/presentation/state/search_bloc/search_event.dart';
import 'package:rick_and_morty/presentation/state/search_bloc/search_state.dart';

class PersonSearchBloc extends Bloc<PersonSearchEvent, PersonSearchState> {
  final SearchPerson searchPersons;

  PersonSearchBloc({required this.searchPersons}) : super(PersonEmpty()) {
    on<PersonSearchEvent>((event, emit) async {
      if (event is SearchPersons) {
        _mapFetchPersonsToState(event.personQuery);
      }
    });
  }

  Stream<PersonSearchState> _mapFetchPersonsToState(String personQuery) async* {
    yield PersonSearchLoading();

    final failureOrPerson =
        await searchPersons(SearchPersonParams(query: personQuery));

    yield failureOrPerson.fold(
      (failure) => PersonSearchError(message: _mapFailureToMessage(failure)),
      (person) => PersonSearchLoaded(persons: person),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexcpected Error';
    }
  }
}
