import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes/core/config/app_secrets.dart';
import 'package:notes/data/models/user_model.dart';

class GoogleAuthService {
  static final GoogleAuthService _instance = GoogleAuthService._internal();

  factory GoogleAuthService() => _instance;

  GoogleAuthService._internal();

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _isInitialized = false;
  GoogleSignInAccount? _currentUser;

  GoogleSignInAccount? get currentAccount => _currentUser;

  bool get isSignedIn => _currentUser != null;

  //================================================================================
  //=============================== INITIALIZATION =================================
  //================================================================================

  /// Initializes Google Sign-In with client ID.
  Future<void> initialize() async {
    if (_isInitialized) return;
    try {
      await _googleSignIn.initialize(clientId: AppSecrets.googleClientId);
      _isInitialized = true;
    } catch (e) {
      debugPrint('GoogleAuthService: Initialization failed: $e');
    }
  }

  //================================================================================
  //=============================== AUTHENTICATION =================================
  //================================================================================

  /// Retrieves the OAuth2 access token, handling both silent and interactive flows.
  Future<String?> getAuthToken() async {
    final user = _currentUser;
    if (user == null) return null;

    try {
      var auth = await user.authorizationClient
          .authorizationForScopes(AppSecrets.googleScopes);

      auth ??= await user.authorizationClient
          .authorizeScopes(AppSecrets.googleScopes);

      return auth.accessToken;
    } catch (e) {
      debugPrint('GoogleAuthService: Failed to get auth token: $e');
      return null;
    }
  }

  /// Attempts to sign in silently at app startup.
  Future<UserModel?> signInSilently() async {
    try {
      await initialize();
      final result = await _googleSignIn.attemptLightweightAuthentication();
      if (result != null) {
        _currentUser = result;
        return _mapAccountToUser(result);
      }
      return null;
    } catch (e) {
      debugPrint('GoogleAuthService: Silent sign-in failed: $e');
      return null;
    }
  }

  /// Initiates the interactive sign-in flow.
  Future<UserModel?> signIn() async {
    try {
      await initialize();
      final result = await _googleSignIn.authenticate();
      _currentUser = result;
      return _mapAccountToUser(result);
    } catch (e) {
      debugPrint('GoogleAuthService: Sign-in failed: $e');
      return null;
    }
  }

  //================================================================================
  //=============================== SESSION MGT ====================================
  //================================================================================

  /// Signs out the current user.
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      _currentUser = null;
    } catch (e) {
      debugPrint('GoogleAuthService: Sign-out failed: $e');
    }
  }

  /// Revokes app access.
  Future<void> disconnect() async {
    try {
      await _googleSignIn.disconnect();
      _currentUser = null;
    } catch (e) {
      debugPrint('GoogleAuthService: Disconnect failed: $e');
    }
  }

  //================================================================================
  //=============================== HELPER METHODS =================================
  //================================================================================

  UserModel _mapAccountToUser(GoogleSignInAccount account) {
    return UserModel(
      id: account.id,
      displayName: account.displayName,
      email: account.email,
      photoUrl: account.photoUrl,
      isLoggedIn: true,
    );
  }
}
