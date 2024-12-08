import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../viewmodel/login_viewmodel.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginViewModelProvider);
    final loginNotifier = ref.read(loginViewModelProvider.notifier);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 23.h),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Welcome to\n',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Carbon',
                          style: TextStyle(
                            fontSize: 27.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                        TextSpan(
                          text: 'Cap',
                          style: TextStyle(
                            fontSize: 27.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.lightGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Please Sign in or Sign Up in CarbonCap',
                    style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  ),
                  SizedBox(height: 2.h),
                  Center(
                    child: Text(
                      'Sign in',
                      style: TextStyle(fontSize: 20.sp, color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 2.5.h),
        
                  TextField(
                    onChanged: loginNotifier.updateEmail,
                    decoration: InputDecoration(
                      labelText: 'Enter Your Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.w),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                      isDense: true,
                    ),
                  ),
        
                  SizedBox(height: 2.h),
                  // Password Field
                  TextField(
                    onChanged: loginNotifier.updatePassword,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: 'Enter Your Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.w),
        
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 22.sp,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 5.w),
                      isDense: true,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
        
                          Text('Remember Password', style: TextStyle(fontSize: 14.sp)),
                          Checkbox(
                            value: loginState.rememberPassword,
                            onChanged: (value) {
                              loginNotifier.updateRememberPassword(value ?? false);
                            },
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to forgot password screen
                        },
                        child: Text(
                          'Forget Password?',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14.sp,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  // Sign In Button
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ElevatedButton(
                        onPressed: loginState.isLoading
                            ? null
                            : () async {
                          await loginNotifier.login(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(vertical: 2.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.w),
                          ),
                        ),
                        child: loginState.isLoading
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text('Sign in', style: TextStyle(fontSize: 18.sp, color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding: EdgeInsets.only(left: 1.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('New in CarbonCap?', style: TextStyle(fontSize: 16.sp)),
                        GestureDetector(
                          onTap: () {
                            context.go('/signup');
                          },
                          child: Text(
                            ' Sign Up',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 1.5.h),
                  Center(
                    child: Image.asset(
                      'assets/Group 10083.png',
                      width: 75.w,
                      height: 8.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/Group 10259.png',
                width: 75.w,
                height: 28.h,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
