class ApiEndpoints {
  static const String base = '/api/v2';

  // ---------------- AUTH ----------------
  static const String continuewithGoogle = '$base/auth/google';
  static const String continueWithApple = '$base/auth/apple';
  static const String registerWithEmailPassword = '$base/auth/register';
  static const String loginWithEmailPassword = '$base/auth/login';
  static const String verifyLinkAccount = '$base/auth/register/verify';
  static const String forgotPassword = '$base/auth/forgot-password';
  static const String resetPassword = '$base/auth/reset-password';
  static const String refreshToken = '$base/auth/refresh';
  static const String logout = '$base/auth/logout';
  static const String deleteStudentAccount = '$base/student/account';
  static const String deleteLecturerAccount = '$base/lecturer/account';
  static const String deleteAdminAccount = '$base/admin/account';

  // ---------------- LECTURER ----------------
  static const String fetchLecturerName = '$base/lecturer/name';
  static const String createSession = '$base/lecturer/create';
  static const String fetchLiveSessionLecturer = '$base/lecturer/live';
  static String endSession(String sessionId) => '$base/lecturer/$sessionId/end';
  static String endInstance(String sessionId) =>
      '$base/lecturer/$sessionId/end-instance';
  static String addIntermittentSession(String sessionId) =>
      '$base/lecturer/$sessionId/intermittent';
  static const String fetchNumberOfPastSessions = '$base/lecturer/past/count';
  static const String fetchPastSessions = '$base/lecturer/past';
  static const String fetchLecturerCourses = '$base/lecturer/courses';
  static const String fetchLecturerLocations = '$base/lecturer/locations';
  static const String fetchLecturerCourseHistory =
      '$base/lecturer/history/courses';
  static String fetchLecturerCourseSessionHistory(String courseId) =>
      '$base/lecturer/history/courses/$courseId/sessions';
  static String downloadLecturerCourseHistory(String courseId) =>
      '$base/lecturer/history/courses/$courseId/download';
  static String downloadLecturerSessionHistory(
    String courseId,
    String sessionId,
  ) => '$base/lecturer/history/courses/$courseId/sessions/$sessionId/download';

  // ---------------- STUDENT ----------------

  // Account & Profile
  static const String activateAccount = '$base/student/activate-account';
  static const String fetchStudentName = '$base/student/name';
  static const String fetchStudentProfile = '$base/student/profile';

  // Academics
  static const String fetchCourses = '$base/student/courses';
  static const String registerCourses = '$base/student/register-courses';
  static const String fetchRegisteredCourses =
      '$base/student/registered-courses';
  static const String fetchLiveSessions = '$base/student/live-sessions';

  // Attendance
  static const String markAttendance = '$base/student/mark-attendance';
  static const String markAttendanceSelfie =
      '$base/student/mark-attendance/selfie';
  static const String submitOverrideRequest = '$base/student/override-request';

  // History
  static const String fetchGeneralAttendanceHistory =
      '$base/student/attendance/history';

  // Student's own request results (unacknowledged rejections only)
  static const String fetchMyOverrides = '$base/student/my-overrides';
  static const String fetchMyAttendanceSelfies =
      '$base/student/my-attendance-selfies';
  static const String acknowledgeNotes = '$base/student/notes/acknowledge';

  // Dynamic Route for specific course history
  static String fetchIndividualCourseHistory(String courseId) =>
      '$base/student/attendance/history/$courseId';

  // ---------------- ADMIN ----------------

  // Departments
  static const String adminDepartments = '$base/admin/departments';
  static String updateDepartment(String deptId) =>
      '$base/admin/departments/$deptId';

  // Courses
  static const String adminCourses = '$base/admin/courses';
  static String updateCourse(String courseId) =>
      '$base/admin/courses/$courseId';

  // Lecturers
  static const String adminLecturers = '$base/admin/lecturers';
  static String updateLecturer(String lecturerId) =>
      '$base/admin/lecturers/$lecturerId';

  // Locations
  static const String adminLocations = '$base/admin/locations';
  static String adminLocation(String locationId) =>
      '$base/admin/locations/$locationId';

  // Selfie Reviews
  static const String fetchSelfieRequests = '$base/admin/selfie-requests';
  static String approveSelfie(String studentId) =>
      '$base/admin/selfie-requests/$studentId/approve';
  static String rejectSelfie(String studentId) =>
      '$base/admin/selfie-requests/$studentId/reject';

  // Override Reviews
  static const String fetchPendingOverrides = '$base/admin/overrides';
  static String approveOverride(String overrideId) =>
      '$base/admin/overrides/$overrideId/approve';
  static String rejectOverride(String overrideId) =>
      '$base/admin/overrides/$overrideId/reject';

  // Attendance Selfie Reviews (20%)
  static const String fetchAttendanceSelfies = '$base/admin/attendance-selfies';
  static String approveAttendanceSelfie(String selfieId) =>
      '$base/admin/attendance-selfies/$selfieId/approve';
  static String rejectAttendanceSelfie(String selfieId) =>
      '$base/admin/attendance-selfies/$selfieId/reject';
}
