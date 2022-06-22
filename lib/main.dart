import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/common/app_colors.dart';
import 'package:rick_and_morty/locator_service.dart';
import 'package:rick_and_morty/presentation/pages/person_screen.dart';
import 'package:rick_and_morty/presentation/state/person_list_cubit/person_list_cubit/person_list_cubit.dart';
import 'package:rick_and_morty/presentation/state/search_bloc/search_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const Application());
}

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PersonListCubuit>(
          create: (context) => sl<PersonListCubuit>()..loadedPerson(),
        ),
        BlocProvider<PersonSearchBloc>(
          create: (context) => sl<PersonSearchBloc>(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
