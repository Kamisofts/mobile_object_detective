import 'package:get_it/get_it.dart';

import '../controllers/camera_controller.dart';
final sl = GetIt.instance;

Future<void> init() async {
  //! Controller
  sl.registerLazySingleton(() => DetectController());

  //! Initial Functions
  // sl<SplashController>().mainOrAuth();

}
