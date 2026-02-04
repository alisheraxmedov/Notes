import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:notes/core/const/colors.dart';
import 'package:notes/core/widgets/text.dart';
import 'package:notes/features/settings/controller/auth_controller.dart';

/// Edit Profile screen with Google Sign-In integration.
///
/// Shows:
/// - Google Sign-In button (if not logged in)
/// - User profile information (if logged in)
class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final width = MediaQuery.sizeOf(context).width;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.only(left: width * 0.02),
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Container(
              padding: EdgeInsets.all(width * 0.02),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.secondary.withAlpha(30),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: colorScheme.inversePrimary,
                size: width * 0.05,
              ),
            ),
          ),
        ),
        title: TextWidget(
          width: width,
          text: "edit_profile".tr(),
          fontSize: width * 0.05,
          fontWeight: FontWeight.w600,
          textColor: colorScheme.onSurface,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * 0.06),
          child: Obx(() => authController.isLoggedIn
              ? _buildLoggedInView(context, authController, width, colorScheme)
              : _buildSignInView(context, authController, width, colorScheme)),
        ),
      ),
    );
  }

  //================================================================================
  //=============================== SIGN IN VIEW ===================================
  //================================================================================

  /// Builds the view when user is NOT logged in.
  Widget _buildSignInView(
    BuildContext context,
    AuthController authController,
    double width,
    ColorScheme colorScheme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon
          Container(
            padding: EdgeInsets.all(width * 0.08),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.primary.withAlpha(15),
            ),
            child: Icon(
              Icons.account_circle_outlined,
              size: width * 0.2,
              color: colorScheme.primary.withAlpha(180),
            ),
          ),
          SizedBox(height: width * 0.08),

          // Title
          TextWidget(
            width: width,
            text: "sign_in_title".tr(),
            fontSize: width * 0.055,
            fontWeight: FontWeight.w700,
            textColor: colorScheme.onSurface,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: width * 0.03),

          // Subtitle
          TextWidget(
            width: width,
            text: "sign_in_subtitle".tr(),
            fontSize: width * 0.035,
            fontWeight: FontWeight.w400,
            textColor: colorScheme.onSurface.withAlpha(150),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: width * 0.1),

          // Google Sign-In Button
          Obx(() => _buildGoogleButton(
                context: context,
                width: width,
                colorScheme: colorScheme,
                isLoading: authController.isLoading.value,
                onTap: () => authController.signInWithGoogle(),
              )),
        ],
      ),
    );
  }

  //================================================================================
  //=============================== LOGGED IN VIEW =================================
  //================================================================================

  /// Builds the view when user IS logged in.
  Widget _buildLoggedInView(
    BuildContext context,
    AuthController authController,
    double width,
    ColorScheme colorScheme,
  ) {
    return Column(
      children: [
        SizedBox(height: width * 0.06),

        // Profile Image
        Container(
          width: width * 0.32,
          height: width * 0.32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: colorScheme.primary.withAlpha(60),
              width: 3,
            ),
            boxShadow: [
              BoxShadow(
                color: colorScheme.primary.withAlpha(20),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ClipOval(
            child: authController.photoUrl != null
                ? Image.network(
                    authController.photoUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => _buildDefaultAvatar(
                      width,
                      colorScheme,
                    ),
                  )
                : _buildDefaultAvatar(width, colorScheme),
          ),
        ),
        SizedBox(height: width * 0.06),

        // User Name
        TextWidget(
          width: width,
          text: authController.displayName,
          fontSize: width * 0.06,
          fontWeight: FontWeight.w700,
          textColor: colorScheme.onSurface,
          textAlign: TextAlign.center,
        ),
        SizedBox(height: width * 0.02),

        // Email
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: width * 0.02,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primary.withAlpha(15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextWidget(
            width: width,
            text: authController.email,
            fontSize: width * 0.035,
            fontWeight: FontWeight.w500,
            textColor: colorScheme.primary,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: width * 0.1),

        // Account Info Card
        Container(
          padding: EdgeInsets.all(width * 0.05),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withAlpha(50),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorScheme.outline.withAlpha(30),
            ),
          ),
          child: Column(
            children: [
              _buildInfoRow(
                icon: Icons.verified_user_outlined,
                label: "account_status".tr(),
                value: "verified".tr(),
                colorScheme: colorScheme,
                width: width,
              ),
              Divider(
                color: colorScheme.outline.withAlpha(30),
                height: width * 0.06,
              ),
              // Dynamic Sync Status with Action
              InkWell(
                onTap: () => authController.syncData(),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: width * 0.01),
                  child: Obx(() => Row(
                        children: [
                          // Rotating icon when syncing
                          authController.syncStatus.value == "Syncing..."
                              ? SizedBox(
                                  width: width * 0.05,
                                  height: width * 0.05,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: colorScheme.primary,
                                  ),
                                )
                              : Icon(Icons.cloud_sync_outlined,
                                  size: width * 0.05,
                                  color: colorScheme.primary),
                          SizedBox(width: width * 0.03),
                          TextWidget(
                            width: width,
                            text: "sync_status".tr(),
                            fontSize: width * 0.035,
                            fontWeight: FontWeight.w500,
                            textColor: colorScheme.onSurface.withAlpha(150),
                          ),
                          const Spacer(),
                          // Show "Sync Now" button if Ready/Failed, else show Status
                          authController.syncStatus.value == "Ready" ||
                                  authController.syncStatus.value == "Failed"
                              ? Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.03,
                                    vertical: width * 0.01,
                                  ),
                                  decoration: BoxDecoration(
                                    color: colorScheme.primary.withAlpha(10),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: colorScheme.primary.withAlpha(30),
                                    ),
                                  ),
                                  child: TextWidget(
                                    width: width,
                                    text: "sync_now".tr(),
                                    fontSize: width * 0.03,
                                    fontWeight: FontWeight.w600,
                                    textColor: colorScheme.primary,
                                  ),
                                )
                              : TextWidget(
                                  width: width,
                                  text: authController.syncStatus.value,
                                  fontSize: width * 0.035,
                                  fontWeight: FontWeight.w600,
                                  textColor: authController.syncStatus.value ==
                                          "Failed"
                                      ? ColorClass.red
                                      : colorScheme.primary,
                                ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),

        const Spacer(),

        // Sign out button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => authController.signOut(),
            icon: const Icon(Icons.logout_rounded, color: ColorClass.red),
            label: TextWidget(
              width: width,
              text: "logout".tr(),
              fontSize: width * 0.04,
              fontWeight: FontWeight.w600,
              textColor: ColorClass.red,
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: ColorClass.red, width: 1.5),
              padding: EdgeInsets.symmetric(vertical: width * 0.04),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        SizedBox(height: width * 0.04),
      ],
    );
  }

  //================================================================================
  //=============================== HELPER WIDGETS =================================
  //================================================================================

  /// Builds the Google Sign-In button.
  Widget _buildGoogleButton({
    required BuildContext context,
    required double width,
    required ColorScheme colorScheme,
    required bool isLoading,
    required VoidCallback onTap,
  }) {
    return Material(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(12),
      elevation: 2,
      shadowColor: colorScheme.onSurface.withAlpha(30),
      child: InkWell(
        onTap: isLoading ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.06,
            vertical: width * 0.04,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isLoading)
                SizedBox(
                  width: width * 0.06,
                  height: width * 0.06,
                  child: const CircularProgressIndicator(strokeWidth: 2),
                )
              else
                Image.network(
                  'https://www.google.com/favicon.ico',
                  width: width * 0.06,
                  height: width * 0.06,
                  errorBuilder: (_, __, ___) => Icon(
                    Icons.g_mobiledata,
                    size: width * 0.06,
                    color: ColorClass.blue,
                  ),
                ),
              SizedBox(width: width * 0.03),
              Text(
                "sign_in_google".tr(),
                style: TextStyle(
                  fontFamily: "Courier",
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds default avatar when no photo is available.
  Widget _buildDefaultAvatar(double width, ColorScheme colorScheme) {
    return Container(
      color: colorScheme.primary.withAlpha(30),
      child: Icon(
        Icons.person_rounded,
        size: width * 0.18,
        color: colorScheme.primary.withAlpha(150),
      ),
    );
  }

  /// Builds an info row for account details.
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required ColorScheme colorScheme,
    required double width,
  }) {
    return Row(
      children: [
        Icon(icon, size: width * 0.05, color: colorScheme.primary),
        SizedBox(width: width * 0.03),
        TextWidget(
          width: width,
          text: label,
          fontSize: width * 0.035,
          fontWeight: FontWeight.w500,
          textColor: colorScheme.onSurface.withAlpha(150),
        ),
        const Spacer(),
        TextWidget(
          width: width,
          text: value,
          fontSize: width * 0.035,
          fontWeight: FontWeight.w600,
          textColor: colorScheme.primary,
        ),
      ],
    );
  }
}
