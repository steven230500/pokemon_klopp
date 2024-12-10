import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_klopp/presentation/home/bloc/home_bloc.dart';
import 'package:pokemon_klopp/presentation/home/bloc/home_event.dart';
import 'package:pokemon_klopp/presentation/home/bloc/home_state.dart';

class PokemonSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        final bloc = context.read<HomeBloc>();

        if (bloc.state is SearchResultsLoaded) {
          bloc.add(const LoadPokemonList());
        }

        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Escribe el nombre de un Pokémon'));
    }

    final bloc = context.read<HomeBloc>();
    bloc.add(SearchPokemon(query));

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SearchResultsLoaded) {
          final searchResults = state.searchResults;
          return ListView.builder(
            itemCount: searchResults.length,
            itemBuilder: (context, index) {
              final pokemon = searchResults[index];
              return ListTile(
                leading: Image.network(pokemon.spriteUrl),
                title: Text(pokemon.name),
                subtitle: Text('ID: ${pokemon.id}'),
              );
            },
          );
        } else if (state is HomeError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Error inesperado.'));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Escribe el nombre de un Pokémon'));
    }

    return Container();
  }
}
