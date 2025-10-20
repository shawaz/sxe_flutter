import 'package:intl/intl.dart';
import 'package:appwrite/appwrite.dart';
import 'package:sxe/data/models/log.dart';
import 'package:sxe/data/models/project_info.dart';
import 'package:sxe/data/services/auth_service.dart';

/// A repository responsible for handling network interactions with the Appwrite server.
///
/// It provides a helper method to ping the server and manages the Appwrite client.
class AppwriteRepository {
  static const String pingPath = "/ping";
  static const String appwriteProjectId = "68f60c15000f272323f4";
  static const String appwriteProjectName = 'SXE';
  static const String appwritePublicEndpoint = 'https://fra.cloud.appwrite.io/v1';

  final Client _client = Client()
      .setProject(appwriteProjectId)
      .setEndpoint(appwritePublicEndpoint);

  late final Account _account;
  late final Databases _databases;
  late final AuthService _authService;

  AppwriteRepository._internal() {
    _account = Account(_client);
    _databases = Databases(_client);
    _authService = AuthService(_client);
  }

  static final AppwriteRepository _instance = AppwriteRepository._internal();

  /// Singleton instance getter
  factory AppwriteRepository() => _instance;

  /// Get the auth service instance
  AuthService get authService => _authService;

  /// Get the client instance
  Client get client => _client;

  /// Get the account instance
  Account get account => _account;

  /// Get the databases instance
  Databases get databases => _databases;

  ProjectInfo getProjectInfo() {
    return ProjectInfo(
      endpoint: appwritePublicEndpoint,
      projectId: appwriteProjectId,
      projectName: appwriteProjectName,
    );
  }

  /// Pings the Appwrite server and captures the response.
  ///
  /// @return [Log] containing request and response details.
  Future<Log> ping() async {
    try {
      final response = await _client.ping();

      return Log(
        date: _getCurrentDate(),
        status: 200,
        method: "GET",
        path: pingPath,
        response: response,
      );
    } on AppwriteException catch (error) {
      return Log(
        date: _getCurrentDate(),
        status: error.code ?? 500,
        method: "GET",
        path: pingPath,
        response: error.message ?? "Unknown error",
      );
    }
  }

  /// Retrieves the current date in the format "MMM dd, HH:mm".
  ///
  /// @return [String] A formatted date.
  String _getCurrentDate() {
    return DateFormat("MMM dd, HH:mm").format(DateTime.now());
  }
}
