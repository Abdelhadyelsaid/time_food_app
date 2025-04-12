class Route {
  String name;
  String path;

  Route({required this.name, required this.path});
}

class Routes {
  static final Route splashScreen = Route(
    name: "splashScreen",
    path: "/splashScreen",
  );
  static final Route loginScreen = Route(
    name: "loginScreen",
    path: "/loginScreen",
  );
}
