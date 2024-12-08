import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../viewmodel/signup_viewmodel.dart';

class SignupScreen extends ConsumerWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final signupState = ref.watch(signupViewModelProvider);
    final signupNotifier = ref.read(signupViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title:  Center(child: Image.asset(
          'assets/Logo.png',
          width: 40.w,
          height: 6.5.h,
          fit: BoxFit.fill,
        ),),
        leading: IconButton(
          icon:  Icon(Icons.arrow_left_outlined, size: 30.sp,),
          onPressed: () =>
      context.go('/')

        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),)),
              SizedBox(height: 3.h,),
              TextField(
                onChanged: signupNotifier.updateFirstName,
                decoration: InputDecoration(
                  labelText: 'First Name*',
                  errorText: signupState.firstNameError.isNotEmpty ? signupState.firstNameError : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: signupNotifier.updateLastName,
                decoration: InputDecoration(
                  labelText: 'Last Name*',
                  errorText: signupState.lastNameError.isNotEmpty ? signupState.lastNameError : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (email) {
                  // Update the email in the state
                  signupNotifier.updateEmail(email);
                },
                decoration: InputDecoration(
                  labelText: 'Enter Your Email*',
                  errorText: signupState.emailError.isNotEmpty ? signupState.emailError : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: signupNotifier.updatePhoneNumber,
                decoration: InputDecoration(
                  labelText: 'Enter Your Phone Number*',
                  errorText: signupState.phoneNumberError.isNotEmpty ? signupState.phoneNumberError : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: signupNotifier.updateAddress,
                decoration: InputDecoration(
                  labelText: 'Enter Your Address*',
                  errorText: signupState.addressError.isNotEmpty ? signupState.addressError : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: signupState.selectedGender.isNotEmpty ? signupState.selectedGender : 'Male', // Set default value here
                onChanged: signupNotifier.updateGender,
                decoration: InputDecoration(
                  labelText: 'Select Gender*',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                ),
                items: <String>['Male', 'Female', 'Other'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: signupNotifier.updatePassword,
                decoration: InputDecoration(
                  labelText: 'Create Your Password*',
                  errorText: signupState.passwordError.isNotEmpty ? signupState.passwordError : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      signupState.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: signupNotifier.togglePasswordVisibility,
                  ),
                ),
                obscureText: !signupState.isPasswordVisible,
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: signupNotifier.updateConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password*',
                  errorText: signupState.confirmPasswordError.isNotEmpty
                      ? signupState.confirmPasswordError
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      signupState.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: signupNotifier.togglePasswordVisibility,
                  ),
                ),
                obscureText: !signupState.isPasswordVisible,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: signupState.isTermsAccepted,
                    onChanged: signupNotifier.toggleTerms,
                  ),
                  const Text('I agree with terms and conditions'),
                ],
              ),
              const SizedBox(height: 16),

              // Signup Button
              Center(
                child: ElevatedButton(
                  onPressed: signupState.isLoading
                      ? null
                      : () async {
                    await signupNotifier.signup(context);
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(60.sp, 60),
                    backgroundColor: Colors.green,
                    elevation: 8.0, // Adds shadow effect
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: signupState.isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  GestureDetector(
                    onTap: () {
                      final email = signupState.email;
                     print('zzzz $email');
                      context.go('/otp', extra: {'email': email});
                      signupNotifier.resetState();

                      print('zzzz $email');
                    },
                    child: const Text(
                      ' Sign In',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
