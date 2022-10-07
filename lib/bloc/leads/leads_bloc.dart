import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'leads_event.dart';
part 'leads_state.dart';

class LeadsBloc extends Bloc<LeadsEvent, LeadsState> {
  LeadsBloc() : super(LeadsInitial()) {
    on<LeadsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
