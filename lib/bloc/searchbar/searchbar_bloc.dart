import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'searchbar_event.dart';
part 'searchbar_state.dart';

class SearchbarBloc extends Bloc<SearchbarEvent, SearchbarState> {
  SearchbarBloc() : super(SearchbarInitial()) {
    on<SearchbarEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
