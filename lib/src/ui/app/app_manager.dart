import 'package:gallery_app/src/config/app_constant.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppManager {
  static final AppManager _singleton = AppManager._internal();
  factory AppManager() {
    return _singleton;
  }
  AppManager._internal() {
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      print("CURRENT ACC: $account");
      _currentUser = account;
      if (_currentUser != null) {
        // Initialize the client with the new user credentials
        authHeaders = await _currentUser?.authHeaders;
      }
    });
  }

  // Google
  GoogleSignInAccount? _currentUser;
  GoogleSignInAccount? get user => _currentUser;
  Map<String, String>? authHeaders;

  bool isLoggedIn() {
    return _currentUser != null;
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: AppConstant.scopes);

  Future<GoogleSignInAccount?> signIn() => _googleSignIn.signIn();

  Future<void> signInSilently() async {
    final account = await _googleSignIn.signInSilently();
    authHeaders = await account?.authHeaders;
    _currentUser = account;
  }

  Future<void> signOut() => _googleSignIn.disconnect();
}
