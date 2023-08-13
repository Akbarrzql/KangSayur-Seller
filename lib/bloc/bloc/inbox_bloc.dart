import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/inbox_event.dart';
import 'package:kangsayur_seller/bloc/state/inbox_state.dart';

import '../../repository/inbox_repository.dart';

class InboxPageBloc extends Bloc<InboxEvent, InboxState>{
  final InboxPageRepository inboxPageRepository;

  InboxPageBloc({required this.inboxPageRepository}) : super(InitialInboxState()){
    on<GetInbox>((event, emit) async{
      emit(InboxLoading());
      try{
        final inbox = await inboxPageRepository.getInbox();
        emit(InboxLoaded(inboxModel: inbox));
      }catch(e){
        emit(InboxError(message: e.toString()));
      }
    });
  }
}