import 'package:book_app/domain/entities/auth.dart';
import 'package:book_app/domain/entities/user.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(AuthRequest request);
  Future<AuthResponse> register(RegisterRequest request);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<String?> getToken();
  Future<User?> getCurrentUser();
}
