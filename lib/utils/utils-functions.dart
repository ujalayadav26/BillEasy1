import 'package:url_launcher/url_launcher.dart';

class UtilsFunctions {
  static String truncateText(String text, int length) {
    if (text == null || text.length <= length) {
      return text;
    }
    return text.substring(0, length)+"...";
  }
  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
  static Future<void> openInWhatsapp(String phoneNumber,String message) async{
    if (!await launchUrl(
      Uri.parse(
          "https://api.whatsapp.com/send/?phone=91${phoneNumber}&text=${message}&type=phone_number&app_absent=0"),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch url');
    }
  }
}
