import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadPokemonList extends HomeEvent {
  final int limit;
  final int offset;

  const LoadPokemonList({this.limit = 20, this.offset = 0});
}

class SearchPokemon extends HomeEvent {
  final String query;

  const SearchPokemon(this.query);

  @override
  List<Object?> get props => [query];
}
