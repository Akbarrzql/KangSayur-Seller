import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/all_ulasan_event.dart';
import 'package:kangsayur_seller/bloc/state/all_ulasan_state.dart';
import '../../repository/all_ulasan_repository.dart';

class AllUlasanPageBloc extends Bloc<AllUlasanPageEvent, AllUlasanPageState>{
  final AllUlasanPageRepository allUlasanPageRepository;

  AllUlasanPageBloc({required this.allUlasanPageRepository}) : super(InitialAllUlasanPageState()) {
    on<GetAllUlasan>((event, emit) async {
      emit(AllUlasanPageLoading());
      try {
        emit(AllUlasanPageLoaded(await allUlasanPageRepository.getAllUlasan()));
      } catch (e) {
        emit(AllUlasanPageError(e.toString()));
      }
    });
  }
}