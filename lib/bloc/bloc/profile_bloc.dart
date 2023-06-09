
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kangsayur_seller/bloc/event/profile_event.dart';
import 'package:kangsayur_seller/bloc/state/profile_state.dart';
import 'package:kangsayur_seller/model/user_model.dart';
import 'package:kangsayur_seller/repository/profile_repository.dart';

class ProfilePageBloc extends Bloc<ProfilePageEvent, ProfilePageState>{
  final ProfilePageRepository profilePageRepository;

  ProfilePageBloc({required this.profilePageRepository}) : super(InitialProfilePageState()) {
    on<GetProfile>((event, emit) async {
      emit(ProfilePageLoading());
      try {
        UserModel userModel = await profilePageRepository.profile();
        emit(ProfilePageLoaded(userModel));
      } catch (e) {
        emit(ProfilePageError(e.toString()));
      }
    });
  }
}