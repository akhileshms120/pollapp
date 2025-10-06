class ServicesState {
  final int? pressedCardIndex;
  
  const ServicesState({this.pressedCardIndex});
  
  ServicesState copyWith({int? pressedCardIndex}) {
    return ServicesState(pressedCardIndex: pressedCardIndex);
  }
}
