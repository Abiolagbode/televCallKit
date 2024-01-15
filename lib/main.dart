import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Televerse Call Demo'),
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
  static const callChanel = MethodChannel('abiolagbode.com/callChannel');
  String callLevel = 'Waiting...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 100,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () async {
                        try {
                          CallKitParams params = const CallKitParams(
                              id: "12",
                              nameCaller: 'Televerse 01',
                              handle: "123456789",
                              type: 1,
                              extra: {"UserId": "1234fg"});
                          await FlutterCallkitIncoming.startCall(params);
                        } catch (e) {
                          print('Exception======>:::: $e');
                        }
                      },
                      child: const Text('OutGoing')),
                  ElevatedButton(
                      onPressed: () async {
                        CallKitParams params = const CallKitParams(
                            id: "E621E1F8-C36C-495A-93FC-0C247A3E6E5F",
                            avatar: 'https://i.pravata.cc/100',
                            nameCaller: 'Televerse 01',
                            handle: "123456",
                            type: 0,
                            textAccept: 'Accept',
                            textDecline: 'Decline',
                            duration: 30000,
                            extra: {"UserId": "sdhsjjfhuwhf"},
                            android: AndroidParams(
                                isCustomNotification: true,
                                isCustomSmallExNotification: true,
                                isShowLogo: true,
                                ringtonePath: 'system_ringtone_default',
                                backgroundColor: '#0955fa',
                                backgroundUrl: 'https://i.pravata.cc/500',
                                missedCallNotificationChannelName:
                                    'Missed Call',
                                incomingCallNotificationChannelName:
                                    'Incoming Call'),
                            ios: IOSParams(
                              // iconName: 'CallKitLogo',
                              handleType: 'generic',
                              supportsVideo: true,
                              maximumCallGroups: 2,
                              maximumCallsPerCallGroup: 1,
                              audioSessionMode: 'default',
                              audioSessionActive: true,
                              audioSessionPreferredSampleRate: 44100.0,
                              audioSessionPreferredIOBufferDuration: 0.005,
                              supportsDTMF: true,
                              supportsGrouping: false,
                              supportsHolding: true,
                              ringtonePath: 'system_ringtone_default',
                            ));
                        await FlutterCallkitIncoming.showCallkitIncoming(
                            params);
                      },
                      child: const Text('Incoming')),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),
            // ElevatedButton(
            // onPressed: () => getCallLevel(),
            // child: Text('Get Call Level')),
          ],
        ),
      ),
    );
  }

  Future getCallLevel() async {
    final arguments = {'name': 'Televerse Call'};
    final int newCallLevel =
        await callChanel.invokeMethod('getCallLevel', arguments);
    setState(() => callLevel = '$newCallLevel%');
  }
}
