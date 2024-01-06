import 'package:url_launcher/url_launcher.dart';

class UrlLauncherUtils {
  static void launchURLToBrowser(String url) async {
    String rUrl = url.replaceAll(" ", "%20");
    if (await canLaunchUrl(Uri.parse(rUrl))) {
      launchUrl(Uri.parse(rUrl), mode: LaunchMode.externalApplication);
    }
  }
}
