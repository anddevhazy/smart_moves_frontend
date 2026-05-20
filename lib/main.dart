import 'package:smart_moves/features/global/core/config/environment.dart';
import 'package:smart_moves/main_common.dart';

import 'features/global/core/config/flavor_config.dart';

void main() async {
  FlavorConfig.init(
    environment: Environment.dev,
    baseApiUrl: 'https://smart-moves-staging-api.up.railway.app',
  );

  await mainCommon();
}
