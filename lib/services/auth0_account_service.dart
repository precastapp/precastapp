import 'dart:async';
import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:precastapp/entites/user.dart';
import 'package:precastapp/local_storage/local_storage.dart';
import 'package:precastapp/pages/welcome_page.dart';
import 'package:precastapp/services/account_service.dart';
import 'package:url_launcher/url_launcher.dart';

class Auth0AccountService implements AccountService {
  @override
  User? current;
  oauth2.Client? _client;
  String baseUrl;
  String clientId;
  String returnTo;

  oauth2.Client? get client {
    if (_client == null) return null;
    if (!_client!.credentials.isExpired) return _client;

    _client!.credentials.refresh();
    return _client;
  }

  Auth0AccountService({
    this.baseUrl = 'https://rtabet.us.auth0.com',
    this.clientId = 'sD3FxjTurJ4C7hvwxdP6bekTQdx2EqDY',
    this.returnTo = 'precastapp://precastapp.web.app/home',
  });

  Future<oauth2.Client?> createClient({bool byStorageOnly = false}) async {
    final authorizationEndpoint = Uri.parse('${baseUrl}/authorize');
    final tokenEndpoint = Uri.parse('${baseUrl}/oauth/token');
    final redirectUrl = Uri.parse(returnTo);
    final storage = Get.find<LocalStorage>();

    var user = await storage.read('user');
    if (user != null) {
      var credentials = oauth2.Credentials.fromJson(user);
      if (!credentials.isExpired)
        return oauth2.Client(credentials, identifier: clientId);
    }
    if (byStorageOnly) return null;

    var grant = oauth2.AuthorizationCodeGrant(
        clientId, authorizationEndpoint, tokenEndpoint);

    var authorizationUrl = grant.getAuthorizationUrl(redirectUrl,
        scopes: ['profile', 'email', 'openid', 'address', 'phone']);

    _client = await redirectAndAuthorization(
        authorizationUrl, redirectUrl.toString(), grant);
    await storage.write('user', _client!.credentials.toJson());
    return _client;
  }

  Future<oauth2.Client> redirectAndAuthorization(
      Uri uri, String redirectUrl, oauth2.AuthorizationCodeGrant grant) async {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
    // ------- 8< -------
    var result = Completer<oauth2.Client>();

    AppLinks()
        .allStringLinkStream
        .where((url) => url.startsWith(redirectUrl))
        .listen((url) async {
      var uri = Uri.parse(url);
      var client = await grant.handleAuthorizationResponse(uri.queryParameters);
      result.complete(client);
    });

    return result.future;
  }

  Future<User?> loadUser() async {
    _client = await createClient(byStorageOnly: true);
    if (_client == null) return null;
    current = tokenToUser(_client?.credentials.idToken ?? '');
    return current;
  }

  @override
  Future<void> loggout() async {
    // await launchUrl(
    //     Uri.parse('$baseUrl/v2/logout?client_id=$clientId&returnTo=$returnTo'),
    //     mode: LaunchMode.externalApplication);
    var storage = Get.find<LocalStorage>();
    await storage.clear();
    Get.offAllNamed(WelcomePage.routePath);
  }

  User tokenToUser(String token) {
    var data = JwtDecoder.decode(token);
    return User(
        id: data['sub'],
        name: data['name'],
        username: data['nickname'],
        email: data['email'],
        phone: data['phone'],
        image: data['picture']);
  }

  @override
  Future<bool> signIn() async {
    var client = _client ?? await createClient();
    if (client == null) return false;
    current = tokenToUser(client.credentials.idToken ?? '');
    Get.put<User>(current!, permanent: true);
    return true;
  }

  @override
  Future<bool> signUp(User user, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future saveUser(User user) async {
    var resp = await client!.put(Uri.parse('$baseUrl/api/v2/users/${user.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()));
    if (resp.statusCode != 200)
      return Future.error(resp.reasonPhrase ?? resp.body);
  }
}
