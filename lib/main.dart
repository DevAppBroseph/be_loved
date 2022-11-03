import 'package:be_loved/core/bloc/auth/auth_bloc.dart';
import 'package:be_loved/core/helpers/shared_prefs.dart';
import 'package:be_loved/models/user/user.dart';
import 'package:be_loved/ui/auth/login/phone.dart';
import 'package:be_loved/ui/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/route_manager.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:overlay_support/overlay_support.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  var user = await MySharedPrefs().user;
  initializeDateFormatting('ru');
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: OverlaySupport.global(
        child: MyApp(user: user),
      ),
    ));
  });
}

class MyApp extends StatelessWidget {
  final UserAnswer? user;
  const MyApp({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: const Color.fromRGBO(240, 240, 240, 1.0),
              fontFamily: 'Inter'),
          // home: user != null
          //     ? user?.date != null
          //         ? HomePage()
          //         : const PhonePage()
          //     : const PhonePage(),
          home: HomePage(),
        );
      },
    );
  }
}

// Анекдот ;)
//
// Муравей таскает камешки, веточки, строит дом. Подъезжает стрекоза на кабриолете:
// — Что делаешь
// — Дом строю.
// — А зачем?
// — Ну, зима придет, холодно будет, а я в домике согреюсь.
// — Ну ладно, строй, а я в ночной клуб поеду. И уехала.
// Муравьишка тащит камень и думает: "Ну ладно. Придет зима — посмотрим..."
// Наступила зима. Муравьишка пилит дрова, подъезжает стрекоза вся в мехах:
// — Что делаешь?
// — Дровишки пилю, холодно, сейчас печку затоплю и согреюсь.
// — Да, холодно. А я в аэропорт еду, полечу в Рио–де–Жанейро, там богема вся собирается, художники, писатели, с ними и перезимую.
// — А Крылов будет?
// — Конечно будет, все собираются.
// — Ну, увидишь — передай, что я его маму ебал.
