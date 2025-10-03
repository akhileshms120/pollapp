import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollapp/Presentation/Cubit/State/otpState.dart';

class OtpCubit extends Cubit<OtpState>{
  final int otpLength;
  OtpCubit({this.otpLength = 6}) : super(OtpState(otp: "",isCompleted: false));
  

  void onOtpChnageString(String otp){
    emit(state.copyWith(otp: otp,isCompleted: otp.length==otpLength));
    
  }
  void clearOtp(){
    emit(state.copyWith(otp: "",isCompleted: false));
  }
}