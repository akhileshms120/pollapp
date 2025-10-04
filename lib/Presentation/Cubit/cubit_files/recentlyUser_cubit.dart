
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pollapp/Presentation/Cubit/State/recentlyUsed_state.dart';

class RecentlyUsedCubit extends Cubit<RecentlyUsedState> {

  RecentlyUsedCubit() : super(RecentlyUsedState([]));

  void markAsUsed(String serviceId) {
    // 1. Get the current list
    final currentList = List<String>.from(state.usedServices);

    // 2. Remove the item if it already exists (to prevent duplicates)
    currentList.remove(serviceId);

    // 3. Insert the item at the beginning
    currentList.insert(0, serviceId);

    // 4. Emit the new state
    emit(RecentlyUsedState(currentList));
  }
}