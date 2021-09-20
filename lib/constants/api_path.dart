abstract class ApiPath {
  static const String BaseUrl = 'https://inclus-mapi.tihub.net';
  // static const String BaseUrl = 'http://localhost';
  static const String Login = '/admin/v1/login';
  static const String GetMe = '/admin/v1/me';

  static const String GetEmotionalLogs = '/admin/v1/emotion-log/list';
  static const String CreateEmotionLog = '/admin/v1/emotion-log';
  static const String UpdateEmotionLog = '/admin/v1/emotion-log';

  static const String GetEmotionTypes = '/admin/v1/emotion/list';

  static const String GetEmploymentLists = '/admin/v1/employment/list';
  static const String CreateEmployment = '/admin/v1/employment';
  static const String UpdateEmployment = '/admin/v1/employment';
  static const String GetWorkplaceDetailLists = '/admin/v1/workplace-detail/list';
  static const String CreateWorkplace = '/admin/v1/workplace-detail';
  static const String UpdateWorkplace = '/admin/v1/workplace-detail';

  static const String GetAttendanceList = '/admin/v1/attendance';
  static const String CreateAttendance = '/admin/v1/attendance';
  static const String UpdateAttendance = '/admin/v1/attendance';

  static const String GetGoalList = '/admin/v1/goal';
  static const String CreateGoal = '/admin/v1/goal';
  static const String UpdateGoal = '/admin/v1/goal';

  static const String GetGoalFrequencyList = '/admin/v1/goal-frequency';
  static const String CreateGoalFrequency = '/admin/v1/goal-frequency';
  static const String UpdateGoalFrequency = '/admin/v1/goal-frequency';

  static const String FcmSaveDeviceTokenUri = '/admin/v1/firebase/register';
}
