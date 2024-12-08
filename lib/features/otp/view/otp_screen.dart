import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../viewmodel/otp_viewmodel.dart';

class OTPScreen extends ConsumerWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final otpState = ref.watch(otpViewModelProvider);
    final otpNotifier = ref.read(otpViewModelProvider.notifier);
    final GoRouterState? routerState = GoRouter.of(context).state;
    final extraData = routerState?.extra as Map<String, dynamic>?;
    final String email = extraData?['email'] ?? 'No email provided';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
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
                context.go('/signup')

        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 2.h),
            Text("Verification Code", style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),),
            SizedBox(height:2.h),
            Text.rich(
              TextSpan(
                text: "We have sent the 4-digit Verification code to your\nPhone Number and Email Address\n",
                style: TextStyle(fontSize: 16.sp),
                children: [
                  TextSpan(
                    text: '$email',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.sp,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5.h),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return _OTPInputField(
                  index: index,
                  onChanged: (value) {
                    otpNotifier.updateOTP(value, index);
                    if (value.isNotEmpty) {
                      otpNotifier.moveToNextField(index);
                    }
                  },
                  otp: otpState.otp,
                  focusNode: otpState.focusNodes[index],
                );
              }),
            ),

            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                ElevatedButton(
                  onPressed: otpState.isLoading
                      ? null
                      : () async {
                    context.go('/dashboard');
                    // await otpNotifier.verifyOTP(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                  ),
                  child: otpState.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text("Resend", style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                ),

                ElevatedButton(
                  onPressed: otpState.isLoading
                      ? null
                      : () async {

                    await otpNotifier.verifyOTP(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
                  ),
                  child: otpState.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text("Verify", style: TextStyle(fontSize: 16.sp, color: Colors.white)),
                ),
              ],
            ),

            if (otpState.error != null)
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Text(
                  otpState.error!,
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _OTPInputField extends StatelessWidget {
  final Function(String) onChanged;
  final int index;
  final String otp;
  final FocusNode focusNode;

  const _OTPInputField({required this.onChanged, required this.index, required this.otp, required this.focusNode, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFilled = otp.length > index && otp[index].isNotEmpty;

    return SizedBox(
      width: 20.w,
      height: 20.h,
      child: TextField(
        maxLength: 1,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        onChanged: onChanged,
        focusNode: focusNode,
        style: TextStyle(color:  Colors.black, fontSize: 28.sp),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.symmetric(vertical: 16.sp),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.w),
            borderSide: BorderSide(color:  Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.w),
            borderSide: BorderSide(color: isFilled ? Colors.green : Colors.black),
          ),
        ),
      ),
    );
  }
}
