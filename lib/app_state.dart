class AppState {
  int count;
  AppState({required this.count});
}

class Initstate extends AppState {
  Initstate() : super(count: -2);
}
