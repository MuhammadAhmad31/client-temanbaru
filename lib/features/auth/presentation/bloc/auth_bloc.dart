import 'package:client/core/usecase/usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/usecases/check_auth_status.dart';
import '../../domain/usecases/login_user.dart';
import '../../domain/usecases/logout_user.dart';
import '../../domain/usecases/register_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final LogoutUser logoutUser;
  final RegisterUser registerUser;
  final CheckAuthStatus checkAuthStatus;

  AuthBloc({
    required this.loginUser,
    required this.logoutUser,
    required this.registerUser,
    required this.checkAuthStatus,
  }) : super(AuthInitial()) {
    on<AuthLoginEvent>(_onLogin);
    on<AuthLogoutEvent>(_onLogout);
    on<AuthRegisterEvent>(_onRegister);
    on<AuthCheckStatusEvent>(_onCheckStatus);
  }

  Future<void> _onLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUser(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (token) => emit(AuthAuthenticated(token: token)),
    );
  }

  Future<void> _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logoutUser(NoParams());
    result.fold(
      (failure) => emit(AuthError(_mapFailureToMessage(failure))),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> _onRegister(
    AuthRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await registerUser(
      RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );

    result.fold((failure) {
      String message = 'Registration failed';
      if (failure is ServerFailure) {
        message = failure.message;
      } else if (failure is NetworkFailure) {
        message = 'No internet connection';
      }
      emit(AuthError(message));
    }, (_) => emit(AuthRegistrationSuccess()));
  }

  Future<void> _onCheckStatus(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await checkAuthStatus(NoParams());
    result.fold(
      (failure) => emit(AuthUnauthenticated()),
      (token) => emit(AuthAuthenticated(token: token)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server Error: ${(failure as ServerFailure).message}';
      case CacheFailure:
        return 'Local Data Error: No cached token found.';
      case InvalidInputFailure:
        return 'Invalid Input: Please check your credentials.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
