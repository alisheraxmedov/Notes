class ApiConstants {
  static const String notificationBaseUrl = "https://remindernotes.dhook.uz";
  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 10);

  // Google Drive
  static const String driveBackupFileName = 'notes_backup.json';
  static const String driveAppFolderName = 'NotesAppBackup';
  static const String driveBaseUrl = 'https://www.googleapis.com/drive/v3';
  static const String driveUploadUrl = 'https://www.googleapis.com/upload/drive/v3';
}
