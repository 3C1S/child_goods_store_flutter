enum Flavor {
  dev,
  prod,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'DEV 키디마켓';
      case Flavor.prod:
        return '키디마켓';
      default:
        return 'title';
    }
  }

}
