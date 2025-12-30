import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:my_template/core/commons/constants/colors/app_colors.dart';
import 'package:my_template/features/my_bloc_provider.dart';

import 'core/di/service_locator.dart';
import 'features/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  await Hive.initFlutter();
  await Hive.openBox('authBox');

  runApp(
    MyBlocProvider(
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: AppColors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: MyApp(),
      ),
    ),
  );
}
