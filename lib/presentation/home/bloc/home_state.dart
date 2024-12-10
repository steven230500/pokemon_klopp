import 'package:equatable/equatable.dart';
import 'package:pokemon_api/pokemon_api.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Pokemon> pokemonList;
  final bool hasReachedMax;

  const HomeLoaded(this.pokemonList, {this.hasReachedMax = false});

  @override
  List<Object?> get props => [pokemonList, hasReachedMax];
}

class SearchResultsLoaded extends HomeState {
  final List<Pokemon> searchResults;

  const SearchResultsLoaded(this.searchResults);

  @override
  List<Object?> get props => [searchResults];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}
