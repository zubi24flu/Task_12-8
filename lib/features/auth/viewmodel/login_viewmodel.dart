import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../../core/services/api_service.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;


// Define the provider
final loginViewModelProvider = StateNotifierProvider<LoginViewModel, LoginState>(
      (ref) => LoginViewModel(),
);

// LoginState
class LoginState {
  final String email;
  final String password;
  final bool rememberPassword;
  final bool isLoading;
  final String? error;

  LoginState({
    this.email = '',
    this.password = '',
    this.rememberPassword = false,
    this.isLoading = false,
    this.error,
  });

  LoginState copyWith({
    String? email,
    String? password,
    bool? rememberPassword,
    bool? isLoading,
    String? error,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      rememberPassword: rememberPassword ?? this.rememberPassword,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

// LoginViewModel
class LoginViewModel extends StateNotifier<LoginState> {
  LoginViewModel() : super(LoginState());

  // final ApiService _apiService = ApiService();

  // Update email
  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  // Update password
  void updatePassword(String password) {
    state = state.copyWith(password: password);
  }

  // Update remember password toggle
  void updateRememberPassword(bool rememberPassword) {
    state = state.copyWith(rememberPassword: rememberPassword);
  }



  Future<void> login(BuildContext context) async {
    if (state.email.isEmpty || state.password.isEmpty) {
      state = state.copyWith(error: 'Email and password are required');
      return;
    }

    state = state.copyWith(isLoading: true, error: null);
    try {
print('hello');
      final response = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/users?email=${state.email}'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
print('hello');
print('hello ${response.statusCode}');

print('hello ${state.email}');
print('hello5 ${response.body}');


      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);

        print("response :${responseData}");
        if (responseData.isNotEmpty) {
          GoRouter.of(context).go('/dashboard');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login successful')),
          );
        } else {
          state = state.copyWith(error: 'Invalid email or password');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid email or password')),
          );
        }
      } else {
        state = state.copyWith(error: 'Failed to login');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to login')),
        );
      }
    } catch (e) {
      state = state.copyWith(error: 'An unexpected error occurred');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred')),
      );
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }
}
