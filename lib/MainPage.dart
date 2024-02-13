import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:green_today/business/calendar_event_control.dart';
import 'package:green_today/domain/EventDataSource.dart';
import 'package:green_today/firebase_options.dart';
import 'package:green_today/palette.dart';
import 'package:green_today/repo/DayReviewRepository.dart';
import 'package:green_today/repo/SettingRepository.dart';
import 'package:green_today/screens/month.dart';
import 'package:green_today/screens/today.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MultiProvider(
    providers: [
      Provider(create: (_) => EventDataSource([])),
      ProxyProvider<EventDataSource, EventController>(
          create: (context) {
            final eventController = EventController(
                Provider.of<EventDataSource>(context, listen: false));
            // TODO eventController.loadMonthEvents(DateTime.now());
            return eventController;
          },
          update: (context, value, EventController? previous) => previous!),
      Provider(create: (_) => DayReviewRepository()),
      Provider(create: (_) => SettingsRepository())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: const DefaultTabController(
          length: 2, child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedTabIdx = 0;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: SafeArea(
          child: TabBar(
            onTap: (index) {
              setState(() {
                _selectedTabIdx = index;
              });
            },
            indicatorColor: GreenPicker.background.color,
            labelColor: GreenPicker.background.color,
            tabs: [
              Tab(
                child: Chip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: _selectedTabIdx == 0
                        ? GreenPicker.chipTab.color
                        : Colors.white,
                    label: Text('Today ${getTodayAsString()}')),
              ),
              Tab(
                child: Chip(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    backgroundColor: _selectedTabIdx == 1
                        ? GreenPicker.chipTab.color
                        : Colors.white,
                    label: const Text('Month')),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        children: [TodayScreen(), MonthScreen()],
      ),
    );
  }
}

String getTodayAsString() {
  DateTime today = DateTime.now();
  return '${today.year}/${today.month}/${today.day}';
}
