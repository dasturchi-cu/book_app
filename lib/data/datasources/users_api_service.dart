import 'package:book_app/data/datasources/base_api_service.dart';

class UsersApiService extends BaseApiService {
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    return await postRequest<Map<String, dynamic>>(
      '/api/Users/LogIn',
      data: {
        'email': email, // Adjust to backend if needed (e.g., userName)
        'password': password,
      },
    );
  }

  Future<Map<String, dynamic>> createUser({
    required String name,
    required String email,
    required String password,
  }) async {
    return await postRequest<Map<String, dynamic>>(
      '/api/Users/Create',
      data: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
  }

  Future<List<dynamic>> getAllUsers() async {
    return await getRequest<List<dynamic>>('/api/Users/GetAllUsers');
  }

  Future<int> getUsersCount() async {
    return await getRequest<int>('/api/Users/GetCountUsers');
  }

  Future<int> countUsersByRegion(String id) async {
    return await getRequest<int>('/api/Users/CountUsersByRegion/$id');
  }

  Future<Map<String, dynamic>> getUserById(String id) async {
    return await getRequest<Map<String, dynamic>>(
      '/api/Users/GetByIdUser',
      query: {'id': id},
    );
  }

  Future<Map<String, dynamic>> updateUser(Map<String, dynamic> user) async {
    return await putRequest<Map<String, dynamic>>('/api/Users/Update', data: user);
  }

  Future<void> deleteUser(String id) async {
    return await deleteRequest('/api/Users/Delete', query: {'id': id});
  }
}


