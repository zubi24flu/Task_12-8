import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;


final otpViewModelProvider = StateNotifierProvider<OTPViewModel, OTPState>(
      (ref) => OTPViewModel(),
);

class OTPViewModel extends StateNotifier<OTPState> {
  OTPViewModel() :  super(OTPState(
    focusNodes: List.generate(4, (_) => FocusNode()),
  ));


  void resetState() {
    state = OTPState(focusNodes: []);
  }

  Future<void> verifyOTP(BuildContext cont) async {
    Timer? otpTimer;
    otpTimer = Timer(const Duration(seconds: 30), () {
      if (state.otp.isEmpty) {
        ScaffoldMessenger.of(cont).showSnackBar(
          SnackBar(content: Text('OTP expired or not entered in time')),
        );
        state = state.copyWith(isLoading: false);
      }
    });

    state = state.copyWith(isLoading: true, error: null);

    await Future.delayed(const Duration(seconds: 2));

    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: {
        'Content-Type': 'application/json',
        'token': 'accessToken',
      },
      body: json.encode({
        'otp': state.otp,
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      otpTimer?.cancel();

      print('OTP Verified: ${state.otp}');
      GoRouter.of(cont).go('/dashboard');
      ScaffoldMessenger.of(cont).showSnackBar(
        SnackBar(content: Text('OTP verified successfully')),
      );
    } else {
      ScaffoldMessenger.of(cont).showSnackBar(
        SnackBar(content: Text('Invalid OTP')),
      );
    }

    state = state.copyWith(isLoading: false);
  }


  void updateOTP(String value, int index) {
    List<String> otpChars = state.otp.padRight(4, ' ').split('');
    otpChars[index] = value.isNotEmpty ? value : ' ';
    String newOTP = otpChars.join('');
    state = state.copyWith(otp: newOTP.trim());
  }


  void moveToNextField(int currentIndex) {
    if (currentIndex < 3) {
      state.focusNodes[currentIndex + 1].requestFocus();
    }
  }

  void moveToPreviousField(int currentIndex) {
    if (currentIndex > 0) {
      state.focusNodes[currentIndex - 1].requestFocus();
    }
  }
}


class OTPState {
  final String otp;
  final bool isLoading;
  final String? error;
  final List<FocusNode> focusNodes;

  OTPState({
    this.otp = '',
    this.isLoading = false,
    this.error,
    required this.focusNodes,
  });

  OTPState copyWith({
    String? otp,
    bool? isLoading,
    String? error,
    List<FocusNode>? focusNodes,
  }) {
    return OTPState(
      otp: otp ?? this.otp,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      focusNodes: focusNodes ?? this.focusNodes,
    );
  }
}
