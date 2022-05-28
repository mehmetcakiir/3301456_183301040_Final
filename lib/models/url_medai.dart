import 'package:url_launcher/url_launcher.dart';

void facebookURL() async =>
    await canLaunch(_urlm) ? await launch(_urlm) : print("Bir sorun oluştu");
const _urlm = 'https://tr-tr.facebook.com/';

void twitterURL() async =>
    await canLaunch(urlm) ? await launch(urlm) : print("Bir sorun oluştu");
const urlm = 'https://twitter.com/';

void googlePlusURL() async =>
    await canLaunch(urlmgo) ? await launch(urlmgo) : print("Bir sorun oluştu");
const urlmgo = 'https://myaccount.google.com/';