import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_klopp/presentation/home/widgets/search_delegate.dart';
import 'package:pokemon_klopp/shared/widgets/cached_image_widget.dart';
import 'bloc/home_bloc.dart';
import 'bloc/home_event.dart';
import 'bloc/home_state.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Klopp'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: PokemonSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading && state is! HomeLoaded) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeLoaded) {
            final pokemonList = state.pokemonList;
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification &&
                    scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent &&
                    !state.hasReachedMax) {
                  context
                      .read<HomeBloc>()
                      .add(LoadPokemonList(limit: 20, offset: pokemonList.length));
                }
                return false;
              },
              child: ListView.builder(
                itemCount: pokemonList.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index >= pokemonList.length) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final pokemon = pokemonList[index];
                  return ListTile(
                    leading: CachedImageWidget(
                      imageUrl: pokemon.spriteUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.contain,
                    ),
                    title: Text(pokemon.name),
                    subtitle: Text('ID: ${pokemon.id}'),
                  );
                },
              ),
            );
          } else if (state is HomeError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No hay datos.'));
          }
        },
      ),
    );
  }
}
