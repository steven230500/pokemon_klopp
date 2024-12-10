import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon_api/pokemon_api.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService apiService;

  HomeBloc({required this.apiService}) : super(HomeInitial()) {
    on<LoadPokemonList>(_onLoadPokemonList);
    on<SearchPokemon>(_onSearchPokemon);
  }

  Future<void> _onLoadPokemonList(LoadPokemonList event, Emitter<HomeState> emit) async {
    final currentState = state;

    if (currentState is HomeLoaded && currentState.hasReachedMax) {
      return;
    }

    try {
      final offset = (currentState is HomeLoaded) ? currentState.pokemonList.length : 0;

      final pokemonList = await apiService.fetchPokemonList(
        limit: event.limit,
        offset: offset,
      );

      final hasReachedMax = pokemonList.isEmpty;

      if (currentState is HomeLoaded) {
        emit(HomeLoaded(
          List.of(currentState.pokemonList)..addAll(pokemonList),
          hasReachedMax: hasReachedMax,
        ));
      } else {
        emit(HomeLoaded(pokemonList, hasReachedMax: hasReachedMax));
      }
    } catch (_) {
      emit(const HomeError('Error al cargar la lista de Pokémon'));
    }
  }

  Future<void> _onSearchPokemon(SearchPokemon event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final pokemon = await apiService.fetchPokemon(event.query);

      emit(SearchResultsLoaded([pokemon]));
    } catch (e) {
      emit(HomeError('Error al buscar el Pokémon: ${event.query}'));
    }
  }
}
