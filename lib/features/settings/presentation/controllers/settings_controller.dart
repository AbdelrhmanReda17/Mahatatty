import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../authentication/data/models/user_model.dart';
import '../../domain/usecases/edit_profile_usecase.dart';
import '../Providers/change_language_usecase_provider.dart';

class SettingsState {
  final bool isLoading;
  final Exception? exception;
  final bool isSuccessful;

  SettingsState({
    this.isLoading = false,
    this.exception,
    this.isSuccessful = false,
  });

  SettingsState copyWith({
    bool? isLoading,
    Exception? exception,
    bool? isSuccessful,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      exception: exception ?? this.exception,
      isSuccessful: isSuccessful ?? this.isSuccessful,
    );
  }
}

class SettingsController extends StateNotifier<SettingsState> {
  final EditProfileUseCase editProfileUseCase;

  SettingsController(this.editProfileUseCase) : super(SettingsState());

  Future<void> editProfile(UserModel updatedProfile) async {
    state = state.copyWith(isLoading: true);
    try {
      await editProfileUseCase.execute(updatedProfile);
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.updateDisplayName(updatedProfile.name);
        await user.updateEmail(updatedProfile.email);
      }
      state = state.copyWith(isSuccessful: true, isLoading: false);
    } catch (e) {
      state = state.copyWith(exception: e as Exception, isLoading: false);
    }
  }
}

final settingsControllerProvider =
StateNotifierProvider<SettingsController, SettingsState>(
      (ref) => SettingsController(ref.read(editProfileUseCaseProvider)),
);
