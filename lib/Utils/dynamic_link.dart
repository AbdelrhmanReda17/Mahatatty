import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:share/share.dart';

class DynamicLinkProvider {
  Future<String> createLink(String refCode) async {
    final String url = "https://mahattaty.com?ref=$refCode";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: "https://mahattaty.page.link",
      link: Uri.parse(url),
       androidParameters: const AndroidParameters(
        packageName: "com.example.mahattaty",
        minimumVersion: 0,
      ),iosParameters:const IOSParameters(bundleId: "com.example.mahattaty",minimumVersion: "0"),
    );
     final FirebaseDynamicLinks link = await FirebaseDynamicLinks.instance;
     final refLink = await link.buildShortLink(parameters);
     return refLink.shortUrl.toString();
  }
  void initializeDynamicLinks() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (instanceLink != null) {
      final Uri refLink = instanceLink.link;
      Share.share("this is the link ${refLink.data}");
    }
  }

}
