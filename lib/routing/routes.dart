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
  static final Route layoutScreen = Route(
    name: "layoutScreen",
    path: "/layoutScreen",
  );
  static final Route productScreen = Route(
    name: "productScreen",
    path: "/productScreen",
  );
  static final Route productDetailsScreen = Route(
    name: "productDetailsScreen",
    path: "/productDetailsScreen",
  );
  static final Route addProductScreen = Route(
    name: "addProductScreen",
    path: "/addProductScreen",
  );
  static final Route registercreen = Route(
    name: "registercreen",
    path: "/registercreen",
  );
  static final Route searchScreen = Route(
    name: "searchScreen",
    path: "/searchScreen",
  );
}
