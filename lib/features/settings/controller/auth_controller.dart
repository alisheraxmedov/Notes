import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:notes/core/const/colors.dart';
import 'package:notes/data/local/database.dart';
import 'package:notes/data/models/user_model.dart';
import 'package:notes/data/services/google_auth_service.dart';
import 'package:notes/data/services/google_drive_service.dart';
import 'package:notes/features/note/controller/note_controller.dart';

/// Controller for managing user authentication state.
///
/// Handles:
/// - User session persistence via GetStorage
/// - Google Sign-In/Sign-Out operations
/// - Reactive user state management
class AuthController extends GetxController {
  static const String _userStorageKey = 'user_data';

  final _storage = GetStorage();
  final _authService = GoogleAuthService();

  final Rx<UserModel> user = UserModel.guest().obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserFromStorage();
  }

  Future<void> _loadUserFromStorage() async {
    try {
      final userData = _storage.read(_userStorageKey);
      if (userData != null && userData is Map<String, dynamic>) {
        user.value = UserModel.fromJson(userData);

        if (user.value.isLoggedIn) {
          final googleUser = await _authService.signInSilently();
          if (googleUser != null) {
            user.value = googleUser;
            _saveUserToStorage();
          }
        }
      }
    } catch (e) {
      debugPrint('AuthController: Failed to load user: $e');
    }
  }

  void _saveUserToStorage() {
    _storage.write(_userStorageKey, user.value.toJson());
  }

  void _clearUserFromStorage() {
    _storage.remove(_userStorageKey);
  }

  /// Signs in with Google.
  ///
  /// Updates [user] state on success and persists to storage.
  Future<bool> signInWithGoogle() async {
    try {
      isLoading.value = true;

      final googleUser = await _authService.signIn();

      if (googleUser != null) {
        user.value = googleUser;
        _saveUserToStorage();

        await Future.delayed(const Duration(milliseconds: 1000));

        return true;
      }

      return false;
    } catch (e) {
      debugPrint('AuthController: Sign-in error: $e');

      await Future.delayed(const Duration(milliseconds: 500));

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Signs out the current user.
  ///
  /// Clears both Google session and local storage.
  Future<void> signOut({bool showSnackbar = true}) async {
    try {
      isLoading.value = true;

      await _authService.signOut();
      user.value = UserModel.guest();
      _clearUserFromStorage();

      if (showSnackbar) {
        await Future.delayed(const Duration(milliseconds: 500));
      }
    } catch (e) {
      debugPrint('AuthController: Sign-out error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  bool get isLoggedIn => user.value.isLoggedIn;

  String get displayName => user.value.displayName ?? 'guest'.tr();

  String get email => user.value.email ?? 'not_signed_in'.tr();

  String? get photoUrl => user.value.photoUrl;

  final RxString syncStatus = "ready".tr().obs;
  final RxString lastSyncTime = "".obs;

  Future<void> syncData() async {
    if (isLoading.value) return;

    try {
      isLoading.value = true;
      syncStatus.value = "syncing".tr();

      if (!isLoggedIn) {
        throw Exception("login_required".tr());
      }

      final token = await _authService.getAuthToken();
      if (token == null) {
        throw Exception("auth_token_unavailable".tr());
      }

      final driveService = GoogleDriveService(Get.find<AppDatabase>());
      driveService.setAuthToken(token);
      await driveService.syncNotes();

      if (Get.isRegistered<NoteController>()) {
        Get.find<NoteController>().fetchNotes();
      }

      final now = DateTime.now();
      lastSyncTime.value =
          "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
      syncStatus.value = "synced".tr();

      _showSnackbar("success".tr(), "sync_completed".tr(), ColorClass.green);

      _resetSyncStatusTimer?.cancel();
      _resetSyncStatusTimer = Timer(const Duration(seconds: 3), () {
        if (syncStatus.value == "synced".tr()) syncStatus.value = "ready".tr();
      });
    } catch (e) {
      syncStatus.value = "sync_failed".tr();
      debugPrint('AuthController: Sync failed: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Timer? _resetSyncStatusTimer;

  @override
  void onClose() {
    _resetSyncStatusTimer?.cancel();
    super.onClose();
  }

  void _showSnackbar(String title, String message, Color color) {
    if (Get.overlayContext == null) {
      debugPrint("Overlay context is null, cannot show snackbar");
      return;
    }

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: color.withValues(alpha: 0.8),
      colorText: ColorClass.white,
    );
  }
}
