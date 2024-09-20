import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';

class OutputScreen extends StatefulWidget {
  const OutputScreen({
    required this.urls,
    required this.message,
    required this.viewUrl,
    required this.downloadUrl,
  });

  final List<String> urls;
  final String message;
  final String viewUrl;
  final String downloadUrl;

  @override
  State<OutputScreen> createState() => _OutputScreenState();
}

class _OutputScreenState extends State<OutputScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _requestPermissions() async {
    if (await Permission.storage.request().isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Storage permission is required to download files.'),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _requestPermissions();
  }

  void _initializeNotifications() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        if (response.payload != null) {
          final file = File(response.payload!);
          if (await file.exists()) {
            OpenFile.open(file.path);
          }
        }
      },
    );
  }

  Future<void> requestStoragePermissions() async {
    if (!await Permission.storage.isGranted) {
      // Request the storage permission
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
        Permission.manageExternalStorage, // For Android 11+
      ].request();

      // Handle permission status
      // if (statuses[Permission.storage]?.isDenied ?? true) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Storage permission is required to download files.'),
      //     ),
      //   );
      // } else if (statuses[Permission.manageExternalStorage]?.isDenied ??
      //     false) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text('Manage External Storage permission required.'),
      //     ),
      //   );
      // }
    }

    // Check for permanent denial and open app settings if needed
    if (await Permission.storage.isPermanentlyDenied) {
      openAppSettings();
    }
  }

  Future<void> _downloadFile(String url, String filename) async {
    // Request permissions before attempting the download
    await requestStoragePermissions();

    try {
      if (await Permission.storage.isGranted ||
          await Permission.manageExternalStorage.isGranted) {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          // Save to the private app-specific directory
          final externalDir = await getExternalStorageDirectory();
          final externalFilePath = '${externalDir!.path}/$filename';
          final externalFile = File(externalFilePath);
          await externalFile.writeAsBytes(response.bodyBytes);

          // Save to the public Downloads directory
          final downloadsDir = Directory('/storage/emulated/0/Download');
          if (!await downloadsDir.exists()) {
            await downloadsDir.create(recursive: true);
          }
          final downloadsFilePath = '${downloadsDir.path}/$filename';
          final downloadsFile = File(downloadsFilePath);
          await downloadsFile.writeAsBytes(response.bodyBytes);

          // Show notification after download
          await _showNotification(externalFilePath, filename);

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Downloaded $filename.')),
          );
        } else {
          throw Exception('Failed to download file');
        }
      } else {
        // // Show message if permission was not granted
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //       content:
        //           Text('Storage permission is required to download files.')),
        // );
      }
    } catch (e) {
      print('Error downloading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download $filename')),
      );
    }
  }

  Future<void> _showNotification(String filePath, String filename) async {
    var androidDetails = AndroidNotificationDetails(
      'channel_id', // Channel ID (required)
      'Downloads', // Channel name (required)
      channelDescription:
          'File Download Notifications', // Channel description (named)
      importance: Importance.max, // Importance level
      priority: Priority.high, // Priority level
      showWhen: true, // Show the timestamp when the notification is displayed
      playSound: true, // Play a sound when the notification is displayed
      icon: 'ic_notification',
    );

    var platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      'Download complete', // Title
      '$filename downloaded', // Body
      platformDetails,
      payload: filePath, // Pass the file path as payload
    );
  }

  void _launchWebView(String url) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewScreen(url: url)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg2.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50),
                  if (widget.urls.isNotEmpty) ...[
                    Text(
                      'UI/UX Design URLs:',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12.0),
                    for (int i = 0; i < widget.urls.length; i++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: ElevatedButton(
                          onPressed: () =>
                              _downloadFile(widget.urls[i], 'image_$i.png'),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(50),
                            backgroundColor: Colors.white.withOpacity(0.2),
                            padding: EdgeInsets.symmetric(vertical: 12.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(
                                color: Colors.white.withOpacity(0.5),
                                width: 1.5,
                              ),
                            ),
                            elevation: 5,
                            shadowColor: Colors.white.withOpacity(0.3),
                          ),
                          child: Text(
                            'Download Image ${i + 1}',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
                          ),
                        ),
                      ),
                  ],
                  if (widget.message.isNotEmpty) ...[
                    SizedBox(height: 24.0),
                    Text(
                      'Prototype:',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 12.0),
                    Text(
                      widget.message,
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () => _launchWebView(
                          'https://utility-end-pts-1.onrender.com${widget.viewUrl}'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        backgroundColor: Colors.white.withOpacity(0.2),
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        elevation: 5,
                        shadowColor: Colors.white.withOpacity(0.3),
                      ),
                      child: Text(
                        'View Website',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    ElevatedButton(
                      onPressed: () => _downloadFile(
                          'https://utility-end-pts-1.onrender.com${widget.downloadUrl}',
                          'website_download.zip'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(50),
                        backgroundColor: Colors.white.withOpacity(0.2),
                        padding: EdgeInsets.symmetric(vertical: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(
                            color: Colors.white.withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        elevation: 5,
                        shadowColor: Colors.white.withOpacity(0.3),
                      ),
                      child: Text(
                        'Download Website',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WebViewScreen extends StatefulWidget {
  final String url;

  WebViewScreen({required this.url});

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    final params = PlatformWebViewControllerCreationParams();
    _controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Color.fromARGB(255, 255, 255, 255))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));

    if (_controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (_controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
