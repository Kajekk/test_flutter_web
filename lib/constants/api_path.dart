abstract class ApiPath {
  static const String BaseUrl = 'https://inclus-mapi.tihub.net';
  // static const String BaseUrl = 'http://localhost';
  static const String Login = '/admin/v1/login';
  static const String GetMe = '/admin/v1/me';

  static const String AccountUri = '/admin/v1/account-management';
  static const String PermissionUri = '/admin/v1/permission';
  static const String PermissionModuleUri = '/admin/v1/permission-module';
  static const String RoleUri = '/admin/v1/role';
  static const String OrganisationUri = '/admin/v1/organisation';

  static const String TermOfServiceUri = '/admin/v1/term-of-service';
  static const String PolicyUri = '/admin/v1/policy';

  static const String GetEmotionalLogs = '/admin/v1/emotion-log';
  static const String CreateEmotionLog = '/admin/v1/emotion-log';
  static const String UpdateEmotionLog = '/admin/v1/emotion-log';
  static const String DeleteEmotionLogs = '/admin/v1/emotion-log';
  static const String EmotionTypeUri = '/admin/v1/emotion-type';

  static const String GetEmotionTypes = '/admin/v1/emotion';

  static const String GetEmploymentLists = '/admin/v1/employment';
  static const String CreateEmployment = '/admin/v1/employment';
  static const String UpdateEmployment = '/admin/v1/employment';
  static const String DeleteEmployments = '/admin/v1/employment';
  static const String GetWorkplaceDetailLists = '/admin/v1/workplace-detail';
  static const String CreateWorkplace = '/admin/v1/workplace-detail';
  static const String UpdateWorkplace = '/admin/v1/workplace-detail';
  static const String DeleteWorkplaces = '/admin/v1/workplace-detail';
  static const String ProScheduleUri = '/admin/v1/pro-schedule';
  static const String ContactFormUri = '/admin/v1/contact-form';

  static const String GetAttendanceList = '/admin/v1/attendance';
  static const String CreateAttendance = '/admin/v1/attendance';
  static const String UpdateAttendance = '/admin/v1/attendance';
  static const String DeleteAttendances = '/admin/v1/attendance';

  static const String SupportMetricUri = '/admin/v1/support-metric';
  static const String SupportLogUri = '/admin/v1/support-log';
  static const String LocationTrackingUri = '/admin/v1/location';

  static const String GetQuoteList = '/admin/v1/quotes';
  static const String CreateQuote = '/admin/v1/quotes';
  static const String UpdateQuote = '/admin/v1/quotes';
  static const String DeleteQuotes = '/admin/v1/quotes';

  static const String GetGoalList = '/admin/v1/goal';
  static const String CreateGoal = '/admin/v1/goal';
  static const String UpdateGoal = '/admin/v1/goal';
  static const String DeleteGoals = '/admin/v1/goal';

  static const String GetGoalFrequencyList = '/admin/v1/goal-frequency';
  static const String CreateGoalFrequency = '/admin/v1/goal-frequency';
  static const String UpdateGoalFrequency = '/admin/v1/goal-frequency';
  static const String DeleteGoalFrequencies = '/admin/v1/goal-frequency';

  static const String GetGoalRelationshipList = '/admin/v1/goal-relationship';
  static const String CreateGoalRelationship = '/admin/v1/goal-relationship';
  static const String UpdateGoalRelationship = '/admin/v1/goal-relationship';
  static const String DeleteGoalRelationships = '/admin/v1/goal-relationship';

  static const String GoalTrackingUri = '/admin/v1/goal-tracking';

  static const String CommunityTopicUri = '/admin/v1/community-topic';

  static const String FcmSaveDeviceTokenUri = '/admin/v1/firebase/register';

  static const String InclusiveEmploymentFormUri = '/admin/v1/inclusive-employment-form';
  static const String ContactUsFormUri = '/admin/v1/contact-us-form';
}
