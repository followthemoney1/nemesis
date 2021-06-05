import 'package:flutter/cupertino.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class InAppWebView extends StatefulWidget {
  InAppWebView({Key? key}) : super(key: key);

  @override
  _InAppWebViewState createState() => _InAppWebViewState();
}

class _InAppWebViewState extends State<InAppWebView> {
  final ChromeSafariBrowser browser = ChromeSafariBrowser();
  @override
  void initState() {
    browser.addMenuItem(new ChromeSafariBrowserMenuItem(
        id: 1,
        label: 'Custom item menu 1',
        action: (url, title) {
          print('Custom item menu 1 clicked!');
          print(url);
          print(title);
        }));
    browser.addMenuItem(new ChromeSafariBrowserMenuItem(
        id: 2,
        label: 'Custom item menu 2',
        action: (url, title) {
          print('Custom item menu 2 clicked!');
          print(url);
          print(title);
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
