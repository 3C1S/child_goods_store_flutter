// Import from prod dependency
import 'flavors.dart';
import 'main.dart' as runner;

Future<void> main() async {
  F.appFlavor = Flavor.prod;

  await runner.main();
}
