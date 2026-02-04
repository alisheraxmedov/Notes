import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:notes/core/const/colors.dart';
import 'package:notes/core/widgets/selectable_text.dart';
import 'package:notes/core/widgets/text.dart';
import 'package:notes/features/settings/controller/settings_controller.dart';
import 'package:notes/features/settings/controller/auth_controller.dart';
import 'package:notes/features/settings/view/edit_profile_view.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final SettingsController settingsController = Get.find();
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surfaceDim,
      body: SafeArea(
        child: Column(
          children: [
//===============================================================================
//================================ BACK BUTTON ==================================
//===============================================================================
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
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
              ],
            ),
//===============================================================================
//=============================== PROFILE SECTION ===============================
//===============================================================================
            SizedBox(height: width * 0.02),
            // Profile Image - Dynamic based on auth state
            Obx(() => Container(
                  width: width * 0.28,
                  height: width * 0.28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.secondary.withAlpha(30),
                    border: Border.all(
                      color: colorScheme.secondary.withAlpha(80),
                      width: 3,
                    ),
                  ),
                  child: ClipOval(
                    child: authController.photoUrl != null
                        ? Image.network(
                            authController.photoUrl!,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Icon(
                              Icons.person_rounded,
                              size: width * 0.15,
                              color: colorScheme.secondary.withAlpha(150),
                            ),
                          )
                        : Icon(
                            Icons.person_rounded,
                            size: width * 0.15,
                            color: colorScheme.secondary.withAlpha(150),
                          ),
                  ),
                )),
            SizedBox(height: width * 0.05),
            // User Name - Dynamic
            Obx(() => TextWidget(
                  width: width,
                  text: authController.displayName,
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.w700,
                  textColor: colorScheme.secondary,
                )),
            SizedBox(height: width * 0.04),
            // Email Badge - Dynamic
            Obx(() => Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: width * 0.06,
                    vertical: width * 0.025,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.secondary.withAlpha(25),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: colorScheme.secondary.withAlpha(60),
                      width: 1.5,
                    ),
                  ),
                  child: SelectableTextWidget(
                    width: width,
                    text: authController.email,
                    fontSize: width * 0.035,
                    fontWeight: FontWeight.w600,
                    textColor: colorScheme.secondary,
                  ),
                )),
            SizedBox(height: width * 0.08),
//===============================================================================
//=============================== SETTINGS LIST =================================
//===============================================================================
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: colorScheme.onSurfaceVariant,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(width * 0.08),
                    topRight: Radius.circular(width * 0.08),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.onSurface.withAlpha(15),
                      blurRadius: 20,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(width * 0.05),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: width * 0.03),
                        // Edit Profile
                        _buildSettingsItem(
                          context: context,
                          width: width,
                          icon: Icons.edit_outlined,
                          title: "edit_profile".tr(),
                          onTap: () => Get.to(() => const EditProfileView()),
                        ),
                        _buildDivider(colorScheme),
                        // Theme Toggle
                        _buildThemeItem(
                          context: context,
                          width: width,
                          colorScheme: colorScheme,
                        ),
                        _buildDivider(colorScheme),
                        // Language
                        _buildLanguageItem(
                          context: context,
                          width: width,
                          colorScheme: colorScheme,
                        ),
                        // Logout - only show when logged in
                        Obx(() => authController.isLoggedIn
                            ? Column(
                                children: [
                                  _buildDivider(colorScheme),
                                  _buildSettingsItem(
                                    context: context,
                                    width: width,
                                    icon: Icons.logout_rounded,
                                    title: "logout".tr(),
                                    iconColor: ColorClass.red,
                                    textColor: ColorClass.red,
                                    onTap: () => _showLogoutDialog(context),
                                  ),
                                ],
                              )
                            : const SizedBox.shrink()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //================================================================================
  //=============================== SETTINGS ITEMS =================================
  //================================================================================

  Widget _buildSettingsItem({
    required BuildContext context,
    required double width,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: width * 0.04),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(width * 0.025),
              decoration: BoxDecoration(
                color: (iconColor ?? colorScheme.secondary).withAlpha(20),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: width * 0.055,
                color: iconColor ?? colorScheme.secondary,
              ),
            ),
            SizedBox(width: width * 0.04),
            Expanded(
              child: TextWidget(
                width: width,
                text: title,
                fontSize: width * 0.04,
                fontWeight: FontWeight.w500,
                textColor: textColor ?? colorScheme.onSurface,
              ),
            ),
            Icon(
              Icons.chevron_right_rounded,
              size: width * 0.06,
              color: colorScheme.secondary,
            ),
          ],
        ),
      ),
    );
  }

  //================================================================================
  //=============================== THEME ITEM =====================================
  //================================================================================

  Widget _buildThemeItem({
    required BuildContext context,
    required double width,
    required ColorScheme colorScheme,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.04),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(width * 0.025),
            decoration: BoxDecoration(
              color: colorScheme.secondary.withAlpha(20),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.palette_outlined,
              size: width * 0.055,
              color: colorScheme.secondary,
            ),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: TextWidget(
              width: width,
              text: "theme".tr(),
              fontSize: width * 0.04,
              fontWeight: FontWeight.w500,
              textColor: colorScheme.onSurface,
            ),
          ),
          Obx(
            () => Switch(
              value: settingsController.isLight.value,
              onChanged: (bool value) {
                settingsController.changeTheme(value);
              },
              activeThumbColor: colorScheme.secondary,
              activeTrackColor: colorScheme.secondary.withAlpha(80),
              inactiveThumbColor: colorScheme.secondary.withAlpha(150),
              inactiveTrackColor: colorScheme.secondary.withAlpha(40),
            ),
          ),
        ],
      ),
    );
  }

  //================================================================================
  //=============================== LANGUAGE ITEM ==================================
  //================================================================================

  Widget _buildLanguageItem({
    required BuildContext context,
    required double width,
    required ColorScheme colorScheme,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: width * 0.04),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(width * 0.025),
            decoration: BoxDecoration(
              color: colorScheme.secondary.withAlpha(20),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.language_rounded,
              size: width * 0.055,
              color: colorScheme.secondary,
            ),
          ),
          SizedBox(width: width * 0.04),
          Expanded(
            child: TextWidget(
              width: width,
              text: "language".tr(),
              fontSize: width * 0.04,
              fontWeight: FontWeight.w500,
              textColor: colorScheme.onSurface,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.03,
              vertical: width * 0.01,
            ),
            decoration: BoxDecoration(
              color: colorScheme.secondary.withAlpha(15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Locale>(
                dropdownColor: colorScheme.surface,
                elevation: 4,
                value: context.locale,
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: colorScheme.secondary,
                  size: width * 0.05,
                ),
                style: TextStyle(
                  fontFamily: "Courier",
                  fontSize: width * 0.035,
                  color: colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
                items: context.supportedLocales.map((Locale locale) {
                  String name = "";
                  if (locale.languageCode == 'en') name = "EN";
                  if (locale.languageCode == 'ru') name = "RU";
                  if (locale.languageCode == 'uz') name = "UZ";
                  return DropdownMenuItem<Locale>(
                    value: locale,
                    child: TextWidget(
                      width: width,
                      text: name,
                      fontSize: width * 0.035,
                      fontWeight: FontWeight.w600,
                      textColor: colorScheme.secondary,
                    ),
                  );
                }).toList(),
                onChanged: (Locale? newLocale) {
                  if (newLocale != null) {
                    context.setLocale(newLocale);
                    Get.updateLocale(newLocale);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(ColorScheme colorScheme) {
    return Divider(
      color: colorScheme.onSurface.withAlpha(20),
      thickness: 1,
    );
  }

  //================================================================================
  //=============================== LOGOUT DIALOG ==================================
  //================================================================================

  /// Shows logout confirmation dialog.
  void _showLogoutDialog(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final width = MediaQuery.sizeOf(context).width;

    Get.dialog(
      AlertDialog(
        backgroundColor: colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: TextWidget(
          width: width,
          text: "logout".tr(),
          fontSize: width * 0.05,
          fontWeight: FontWeight.w700,
          textColor: colorScheme.onSurface,
        ),
        content: TextWidget(
          width: width,
          text: "logout_confirm".tr(),
          fontSize: width * 0.038,
          fontWeight: FontWeight.w400,
          textColor: colorScheme.onSurface.withAlpha(180),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: TextWidget(
              width: width,
              text: "cancel".tr(),
              fontSize: width * 0.038,
              fontWeight: FontWeight.w600,
              textColor: colorScheme.primary,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              authController.signOut();
            },
            child: TextWidget(
              width: width,
              text: "logout".tr(),
              fontSize: width * 0.038,
              fontWeight: FontWeight.w600,
              textColor: ColorClass.red,
            ),
          ),
        ],
      ),
    );
  }
}
