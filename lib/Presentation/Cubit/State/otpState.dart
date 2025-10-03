class OtpState{
final String otp;
final bool isCompleted;

  OtpState({required this.otp, required this.isCompleted, });

   OtpState copyWith({String? otp ,bool? isCompleted}) {
    return OtpState(
      otp: otp??this.otp,
      isCompleted: isCompleted??this.isCompleted
    );
  }
}