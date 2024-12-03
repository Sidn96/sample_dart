import 'package:url_launcher/url_launcher.dart';

launchURL({required String url,bool isNewTab=true}) async {
  final Uri pdfUrl = Uri.parse(url);
  if (await canLaunchUrl(pdfUrl)) {
    await launchUrl(pdfUrl,webOnlyWindowName: isNewTab ? '_blank' : '_self',);
  } else {
    throw 'Could not launch $pdfUrl';
  }
}
