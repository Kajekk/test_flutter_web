abstract class ApiPath {
  static const String BaseUrl = 'https://inclus-mapi.tihub.net';
  // static const String BaseUrl = 'http://localhost';
  static const String Login = '/admin/v1/login';
  static const String GetMe = '/admin/v1/me';

  static const String GetEmotionalLogs = '/admin/v1/emotion-log/list';

  static const String GetEmploymentLists = '/admin/v1/employment/list';

  static const String GetAttendanceList = '/admin/v1/attendance';

  static const String FcmSaveDeviceTokenUri = '/admin/v1/firebase/register';
}
