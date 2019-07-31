import 'imports.dart';

void main() {
  // debugDefaultTargetPlatformOverride = TargetPlatform.iOS;
  timeDilation = 2;
  Provider.debugCheckInvalidValueType = null;
  setupLocator();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.controller(
          initialData: User(),
          builder: (context) => locator<ProfileServices>().loggedInUserStream,
        ),
        StreamProvider<FirebaseUser>.controller(
          initialData: null,
          builder: (context) =>
              locator<AuthenticationServices>().fireBaseUserStream,
        ),
        StreamProvider<UserType>.controller(
          initialData: UserType.UNKNOWN,
          builder: (context) =>
              locator<AuthenticationServices>().userTypeStream,
        ),
        StreamProvider<bool>.controller(
          initialData: false,
          builder: (context) =>
              locator<AuthenticationServices>().isUserLoggedInStream,
        ),
      ],
      child: DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
          pageTransitionsTheme: PageTransitionsTheme(builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }),
          fontFamily: "Nunito",
          primaryColor: Colors.red,
          accentColor: Colors.redAccent,
          primaryColorDark: Color(0xff0029cb),
          brightness: brightness,
        ),
        themedWidgetBuilder: (context, theme) => new OurSchoolApp(
          theme: theme,
        ),
      ),
    );
  }
}

class OurSchoolApp extends StatelessWidget {
  const OurSchoolApp({
    Key key,
    @required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Our E-School',
      theme: theme,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        Home.id: (context) => Home(),
        ProfilePage.id: (context) => ProfilePage(),
        GuardianProfilePage.id: (context) => GuardianProfilePage(
              title: 'Guardian Profile',
            ),
      },
      home: getHome(context),
    );
  }

  Widget getHome(BuildContext context) {
    User currentUser = Provider.of<User>(context);
    UserType userType = Provider.of<UserType>(context);

    if (Provider.of<FirebaseUser>(context) == null) {
      return WelcomeScreen();
    }

    if (userType == UserType.UNKNOWN) {
      return WelcomeScreen();
    }

    if (Provider.of<bool>(context)) {
      if (userType == UserType.STUDENT) {
        return currentUser.isEmpty() ? ProfilePage() : Home();
      } else {
        return Home();
      }
    } else {
      return WelcomeScreen();
    }
  }
}
