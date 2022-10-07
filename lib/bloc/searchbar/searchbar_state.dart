part of 'searchbar_bloc.dart';

abstract class SearchbarState extends Equatable {
  const SearchbarState();
  
  @override
  List<Object> get props => [];
}

class SearchbarInitial extends SearchbarState {}
