import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

// Screen for viewing and downloading the website
class DownWebScreen extends StatefulWidget {
  @override
  _DownWebScreenState createState() => _DownWebScreenState();
}

class _DownWebScreenState extends State<DownWebScreen> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _requestPermissions();
  }

  // Initialize notification settings
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

  Future<void> _requestPermissions() async {
    if (await Permission.storage.request().isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Storage permission is required to download files.'),
        ),
      );
    }
  }

  // Method to download a file
  Future<void> _downloadFile(String url, String filename) async {
    await _requestPermissions();

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
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download $filename')),
      );
    }
  }

  // Show notification once the file is downloaded
  Future<void> _showNotification(String filePath, String filename) async {
    var androidDetails = AndroidNotificationDetails(
      'channel_id',
      'Downloads',
      channelDescription: 'File Download Notifications',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
      playSound: true,
      icon: 'ic_notification',
    );

    var platformDetails = NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      'Download complete',
      '$filename downloaded',
      platformDetails,
      payload: filePath,
    );
  }

  // Launch WebView to view the generated website
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
              'assets/images/bg2.png', // Use your background image
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Website Generated Successfully!',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.0),
                ElevatedButton(
                  onPressed: () {
                    _launchWebView(
                        'https://innovent-endpts.onrender.com/view-generated'); // Launch the WebView
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Colors.teal.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(
                        color: Colors.white.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'View Website',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Icon(
                        Icons.public,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    _downloadFile(
                        'https://innovent-endpts.onrender.com/download-zip',
                        'website_download.zip'); // Download the zip file
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    backgroundColor: Colors.purple.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(
                        color: Colors.white.withOpacity(0.5),
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Download Source Code',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(width: 8.0),
                      Icon(
                        Icons.file_download,
                        color: Colors.amber,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}

// WebView Screen to load the generated website
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
