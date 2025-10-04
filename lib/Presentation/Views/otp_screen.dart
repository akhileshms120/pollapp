import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:pollapp/Core/app_constants/image_constant.dart';
import 'package:pollapp/Core/app_constants/routes_constant.dart';
import 'package:pollapp/Presentation/Controller/text_controller.dart';
import 'package:pollapp/Presentation/Cubit/State/otpState.dart';
import 'package:pollapp/Presentation/Cubit/State/timerState.dart';
import 'package:pollapp/Presentation/Cubit/cubit_files/otp_cubit.dart';
import 'package:pollapp/Presentation/Cubit/cubit_files/timerState_cubit.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  final int otpLength; 
  const OtpScreen({super.key,  this.phone="", this.otpLength = 6});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

   final _loginScreenTextcontroller = Get.find<TextControllers>();
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _nodes;

  Timer? _timer;
 

  bool get _isOtpComplete => _controllers.every((c) => c.text.isNotEmpty);

  @override
  void initState() {
    super.initState();
    _controllers =
        List.generate(widget.otpLength, (_) => TextEditingController());
    _nodes = List.generate(widget.otpLength, (_) => FocusNode());
    //_startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _controllers) c.dispose();
    for (final f in _nodes) f.dispose();
    super.dispose();
  }

  void _onVerify() {
    final otp = _controllers.map((c) => c.text).join();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Verifying OTP: $otp')),
    );
    Get.offAllNamed(RoutesName.homeScreen);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const greyText = Color(0xFF6B7280);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (_)=>TimerCubit()..startTimer()),
         BlocProvider(
        create: (_)=>OtpCubit(otpLength: widget.otpLength))
      ],
        child: Scaffold(
          backgroundColor: Colors.white,
            appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed:()=>Get.back()
        ),
        title: const Text(
          "OTP Verification",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  // Logo
                  Center(
                    child: Image.asset(
                      splash_logo, // replace with your asset
                      height: 86,
                      width: 86,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Text('Verify OTP',
                      style: theme.textTheme.headlineMedium ??
                          const TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 8),
                  Text(
                    'Enter the OTP sent to ${_loginScreenTextcontroller.textEditingController.text}',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleMedium ??
                        const TextStyle(fontSize: 18, color: Color(0xFF4B5563)),
                  ),
                  const SizedBox(height: 28),
        
                  // 6 OTP boxes (responsive width)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      const spacing = 12.0;
                      final boxSize = min(
                        72.0,
                        (constraints.maxWidth -
                                spacing * (widget.otpLength - 1)) /
                            widget.otpLength,
                      );
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(widget.otpLength, (i) {
                          return SizedBox(
                            width: boxSize,
                            height: 72,
                            child: _OtpBox(
                              controller: _controllers[i],
                              focus: _nodes[i],
                              first: i == 0,
                              last: i == widget.otpLength - 1,
                              onChanged: (){
                                final otp=_controllers.map((c)=>c.text).join();
                                context.read<OtpCubit>().onOtpChnageString(otp);
                              },
                            ),
                          );
                        }),
                      );
                    },
                  ),
        
                  const SizedBox(height: 24),
        
                  // Resend
                  GestureDetector(
                    onTap:(){
                        if (context.read<TimerCubit>().state.canResend) {
        context.read<TimerCubit>().startTimer(); // restart timer
      }
                    },
                    child:BlocBuilder<TimerCubit,TimerState>(builder: (context,state){
                    return    Text(
                      state.canResend
                          ? 'Resend OTP'
                          : 'Resend OTP in 00:${state.seconds.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 18,
                        color: state.canResend ? Colors.black : greyText,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                    })
                 
                  ),
                  const SizedBox(height: 20),
        
                  // Verify button
                  SizedBox(
                    width: double.infinity,
                    child: BlocBuilder<OtpCubit,OtpState>(
                      builder: (context,state){ return ElevatedButton(
                        onPressed: _isOtpComplete ? _onVerify : null,
                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: Colors.black,
                          disabledBackgroundColor: const Color(0xFFE5E7EB),
                          foregroundColor: Colors.white,
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                        ),
                        child: const Text(
                          'Verify',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      );
                      }
                    ),
                  ),
                  const Spacer(),
        
                  // Footer links
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Terms and Condition',
                          style:
                              TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Privacy Policy',
                          style:
                              TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          ),
        ),
      );
    
  }
}

class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final bool first;
  final bool last;
  final VoidCallback onChanged;

  const _OtpBox({
    required this.controller,
    required this.focus,
    required this.onChanged,
    this.first = false,
    this.last = false,
  });

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color color) => OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: color, width: 1.2),
        );

    return TextField(
      controller: controller,
      focusNode: focus,
      autofocus: first,
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
      inputFormatters: [
        LengthLimitingTextInputFormatter(1),
        FilteringTextInputFormatter.digitsOnly,
      ],
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF9FAFB),
        border: border(const Color(0xFFE5E7EB)),
        enabledBorder: border(const Color(0xFFE5E7EB)),
        focusedBorder: border(Colors.black),
        contentPadding: EdgeInsets.zero,
      ),
      onChanged: (value) {
        if (value.isNotEmpty && !last) {
          FocusScope.of(context).nextFocus();
        } else if (value.isEmpty && !first) {
          FocusScope.of(context).previousFocus();
        }
        onChanged();
      },
    );
  }
}