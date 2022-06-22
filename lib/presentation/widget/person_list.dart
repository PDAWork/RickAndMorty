import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/domain/entities/person_entity.dart';
import 'package:rick_and_morty/presentation/state/person_list_cubit/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/presentation/state/person_list_cubit/person_list_cubit/person_list_state.dart';

class PersonsList extends StatelessWidget {
  const PersonsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    List<PersonEntity> persons = [];

    _scrollController.addListener(
      () async {
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          context.read<PersonListCubuit>().addPerson();
        }
      },
    );
    return BlocBuilder<PersonListCubuit, PersonState>(
      builder: (context, state) {
        if (state is PersonLoading && state.isFirstFetch) {
          return _loadingindeicatore();
        } else if (state is PersonLoaded) {
          persons = state.personsList;
          print(persons.length);
        }

        return ListView.separated(
          controller: _scrollController,
          itemCount: persons.length,
          itemBuilder: (context, index) {
            return Text('${persons[index]}');
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[400],
            );
          },
        );
      },
    );
  }
}

Widget _loadingindeicatore() {
  return const Center(
    child: CircularProgressIndicator(),
  );
}
