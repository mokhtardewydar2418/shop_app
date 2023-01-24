
import 'package:marketing/modules/login/login_screen.dart';
import 'package:marketing/shared/components/components.dart';
import 'package:marketing/shared/network/local/cache_helper.dart';

String token = '';

void signOut(context)
{
  CacheHelper.removeData(key: 'token').then((value)
  {
    navigateAndFinish(context, LoginScreen());
  }
  );
}