import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';

class SignupState {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String address;
  final String selectedGender;
  final String password;
  final String confirmPassword;
  final bool isTermsAccepted;
  final bool isPasswordVisible;
  final bool isLoading;
  final String firstNameError;
  final String lastNameError;
  final String emailError;
  final String phoneNumberError;
  final String addressError;
  final String passwordError;
  final String confirmPasswordError;

  SignupState({
    this.firstName = '',
    this.lastName = '',
    this.email = '',
    this.phoneNumber = '',
    this.address = '',
    this.selectedGender = '',
    this.password = '',
    this.confirmPassword = '',
    this.isTermsAccepted = false,
    this.isPasswordVisible = false,
    this.isLoading = false,
    this.firstNameError = '',
    this.lastNameError = '',
    this.emailError = '',
    this.phoneNumberError = '',
    this.addressError = '',
    this.passwordError = '',
    this.confirmPasswordError = '',
  });

  SignupState copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? address,
    String? selectedGender,
    String? password,
    String? confirmPassword,
    bool? isTermsAccepted,
    bool? isPasswordVisible,
    bool? isLoading,
    String? firstNameError,
    String? lastNameError,
    String? emailError,
    String? phoneNumberError,
    String? addressError,
    String? passwordError,
    String? confirmPasswordError,
  }) {
    return SignupState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      selectedGender: selectedGender ?? this.selectedGender,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isTermsAccepted: isTermsAccepted ?? this.isTermsAccepted,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isLoading: isLoading ?? this.isLoading,
      firstNameError: firstNameError ?? this.firstNameError,
      lastNameError: lastNameError ?? this.lastNameError,
      emailError: emailError ?? this.emailError,
      phoneNumberError: phoneNumberError ?? this.phoneNumberError,
      addressError: addressError ?? this.addressError,
      passwordError: passwordError ?? this.passwordError,
      confirmPasswordError: confirmPasswordError ?? this.confirmPasswordError,
    );
  }
}

class SignupViewModel extends StateNotifier<SignupState> {
  SignupViewModel() : super(SignupState());

  final Dio _dio = Dio();

  void updateFirstName(String value) {
    state = state.copyWith(firstName: value, firstNameError: '');
  }
  void resetState() {
    state = SignupState();
  }
  void updateLastName(String value) {
    state = state.copyWith(lastName: value, lastNameError: '');
  }

  void updateEmail(String value) {
    state = state.copyWith(email: value, emailError: '');
  }

  void updatePhoneNumber(String value) {
    state = state.copyWith(phoneNumber: value, phoneNumberError: '');
  }

  void updateAddress(String value) {
    state = state.copyWith(address: value, addressError: '');
  }

  void updateGender(String? value) {
    state = state.copyWith(selectedGender: value ?? '', addressError: '');
  }

  void updatePassword(String value) {
    state = state.copyWith(password: value, passwordError: '');
  }

  void updateConfirmPassword(String value) {
    state = state.copyWith(confirmPassword: value, confirmPasswordError: '');
  }

  void togglePasswordVisibility() {
    state = state.copyWith(isPasswordVisible: !state.isPasswordVisible);
  }

  void toggleTerms(bool? value) {
    state = state.copyWith(isTermsAccepted: value ?? false);
  }

  bool _validateForm() {
    bool isValid = true;

    // Validation for required fields
    if (state.firstName.isEmpty) {
      state = state.copyWith(firstNameError: 'This field is required');
      isValid = false;
    }
    if (state.lastName.isEmpty) {
      state = state.copyWith(lastNameError: 'This field is required');
      isValid = false;
    }
    if (state.email.isEmpty || !RegExp(r'\S+@\S+\.\S+').hasMatch(state.email)) {
      state = state.copyWith(emailError: 'Enter a valid email');
      isValid = false;
    }
    if (state.phoneNumber.isEmpty) {
      state = state.copyWith(phoneNumberError: 'This field is required');
      isValid = false;
    }
    if (state.address.isEmpty) {
      state = state.copyWith(addressError: 'This field is required');
      isValid = false;
    }
    if (state.password.isEmpty || state.password.length < 6) {
      state = state.copyWith(passwordError: 'Password must be at least 6 characters');
      isValid = false;
    }
    if (state.confirmPassword != state.password) {
      state = state.copyWith(confirmPasswordError: 'Passwords do not match');
      isValid = false;
    }
    if (!state.isTermsAccepted) {
      isValid = false;
    }

    return isValid;
  }

  // Signup action
  Future<void> signup(BuildContext context) async {
    if (!_validateForm()) {
      print('object');
      return;
    }
    print('objectj');

    state = state.copyWith(isLoading: true);
    print('objectjjj');

    try {

      print('objectjj');

      final response = await _dio.post(
        'https://jsonplaceholder.typicode.com/users',
        data: {
          'firstName': state.firstName,
          'lastName': state.lastName,
          'email': state.email,
          'phone': state.phoneNumber,
          'address': state.address,
          'gender': state.selectedGender,
          'password': state.password,
          'confirmPassword': state.confirmPassword,
        },
      );

      if (response.statusCode == 201) {
        print('objectvjhjvj ${response}');

        final email = state.email;
        GoRouter.of(context).go('/otp',  extra: {'email': email});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful')),
        );
        state = state.copyWith(isLoading: false);

        print('objectjjjkbkbjbjb686');

      } else {
        print('obje,bjbkbkctj');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed')),
        );
        state = state.copyWith(isLoading: false);
      }
    } catch (e) {
      state = state.copyWith(isLoading: false);

      print(e);
    }
  }
}

final signupViewModelProvider = StateNotifierProvider<SignupViewModel, SignupState>((ref) {
  return SignupViewModel();
});
