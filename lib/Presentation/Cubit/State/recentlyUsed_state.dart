
class RecentlyUsedState {
  final List<String> usedServices;

  RecentlyUsedState(this.usedServices);


  List<String> get topServices => usedServices.take(5).toList();
}