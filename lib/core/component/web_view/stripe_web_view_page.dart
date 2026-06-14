import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class StripeWebViewPage extends StatefulWidget {
  final String paymentUrl;
  final String successEndpoint;
  final String cancelEndpoint;

  const StripeWebViewPage({
    super.key,
    required this.paymentUrl,
    required this.successEndpoint,
    required this.cancelEndpoint,
  });

  @override
  State<StripeWebViewPage> createState() => _StripeWebViewPageState();
}

class _StripeWebViewPageState extends State<StripeWebViewPage> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() => isLoading = true);
          },
          onPageFinished: (url) {
            setState(() => isLoading = false);
          },
          onNavigationRequest: (NavigationRequest request) {
            final url = request.url;

            // ✅ SUCCESS DETECTION (endpoint match)
            if (url.contains(widget.successEndpoint)) {
              Navigator.pop(context, {
                "status": "success",
                "url": url,
              });
              return NavigationDecision.prevent;
            }

            // ❌ CANCEL DETECTION (endpoint match)
            if (url.contains(widget.cancelEndpoint)) {
              Navigator.pop(context, {
                "status": "cancel",
                "url": url,
              });
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stripe Payment"),
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),

          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}



// / import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class StripeWebViewPage extends StatefulWidget {
//   final String paymentUrl;
//   final String successUrl;
//   final String cancelUrl;

//   const StripeWebViewPage({
//     super.key,
//     required this.paymentUrl,
//     required this.successUrl,
//     required this.cancelUrl,
//   });

//   @override
//   State<StripeWebViewPage> createState() => _StripeWebViewPageState();
// }

// class _StripeWebViewPageState extends State<StripeWebViewPage> {
//   late final WebViewController _controller;
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();

//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageStarted: (url) {
//             setState(() => isLoading = true);
//           },
//           onPageFinished: (url) {
//             setState(() => isLoading = false);
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             final url = request.url;

//             // ✅ SUCCESS URL DETECT
//             if (url.startsWith(widget.successUrl)) {
//               Navigator.pop(context, {
//                 "status": "success",
//                 "url": url,
//               });
//               return NavigationDecision.prevent;
//             }

//             // ❌ CANCEL URL DETECT
//             if (url.startsWith(widget.cancelUrl)) {
//               Navigator.pop(context, {
//                 "status": "cancel",
//                 "url": url,
//               });
//               return NavigationDecision.prevent;
//             }

//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.paymentUrl));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Stripe Payment"),
//       ),
//       body: Stack(
//         children: [
//           WebViewWidget(controller: _controller),

//           // Loading indicator
//           if (isLoading)
//             const Center(
//               child: CircularProgressIndicator(),
//             ),
//         ],
//       ),
//     );
//   }
// }