import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/homepage.dart';
import '../screens/myaccount.dart';
import '../screens/myservices.dart';

enum NavigationEvents {
  homePageClickedEvent,
  myAccountClickedEvent,
  myServicesClickedEvent,
}

abstract class NavigationStates {}

class NavigationBloc extends Bloc<NavigationEvents, NavigationStates> {
  NavigationBloc(super.initialState) {
    // Register event handlers
    on<NavigationEvents>((event, emit) {
      // Handle different events and emit corresponding states
      switch (event) {
        case NavigationEvents.homePageClickedEvent:
          emit(const HomePage());
          break;
        case NavigationEvents.myAccountClickedEvent:
          emit(const MyAccount());
          break;
        case NavigationEvents.myServicesClickedEvent:
          emit(const MyServices());
          break;
      }
    });
  }
}
