import 'package:bloc/bloc.dart';
import 'package:laravel_rest_blog/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repo;
  AuthBloc(this.repo) : super(AuthInitial()) {
    on<LoginEvent>((e, emit) async {
      emit(AuthLoading());
      try {
        emit(AuthSuccess(await repo.login(e.email, e.password)));
      } catch (ex) {
        emit(AuthFailure(ex.toString()));
      }
    });
    on<LogoutEvent>((e, emit) async {
      await repo.logout();
      emit(AuthInitial());
    });
  }
}
