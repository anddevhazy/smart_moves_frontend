import 'package:smart_moves/features/global/core/config/environment.dart';
import 'package:smart_moves/main_common.dart';

import 'features/global/core/config/flavor_config.dart';

void main() async {
  FlavorConfig.init(
    environment: Environment.prod,
    baseApiUrl: 'https://smart-moves-production-api.up.railway.app',
  );

  await mainCommon();
}
