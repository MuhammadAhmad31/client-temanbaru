import 'package:get_it/get_it.dart';
import 'features/pets_di.dart' as user_di;
import 'features/auth_di.dart' as auth_di;
import 'features/adopt_di.dart' as adopt_di;
import 'external_di.dart' as external_di;

final sl = GetIt.instance;

Future<void> init() async {
  await external_di.init(sl);

  await user_di.init(sl);
  await auth_di.init(sl);
  await adopt_di.init(sl);
}
