import 'dart:async';
import 'dart:convert';

import 'package:app_links/app_links.dart';
import 'package:core/core.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:url_launcher/url_launcher.dart';

import '../entites/account.dart';
import 'account_service.dart';

class Auth0AccountService implements AccountService {
  @override
  Account? current;
  oauth2.Client? _client;
  String baseUrl;
  String clientId;
  String returnTo;
  LocalStorage storage;

  oauth2.Client? get client {
    if (_client == null) return null;
    if (!_client!.credentials.isExpired) return _client;

    _client!.credentials.refresh();
    return _client;
  }

  Auth0AccountService(
      {this.baseUrl = 'https://rtabet.us.auth0.com',
      this.clientId = 'sD3FxjTurJ4C7hvwxdP6bekTQdx2EqDY',
      this.returnTo = 'precastapp://precastapp.web.app/home',
      required this.storage});

  Future<oauth2.Client?> createClient({bool byStorageOnly = false}) async {
    final authorizationEndpoint = Uri.parse('${baseUrl}/authorize');
    final tokenEndpoint = Uri.parse('${baseUrl}/oauth/token');
    final redirectUrl = Uri.parse(returnTo);

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

    AppLinks().allStringLinkStream.listen((url) async {
      if (!url.startsWith(redirectUrl)) return;
      var uri = Uri.parse(url);
      if (uri.queryParameters.isEmpty) return;
      var client = await grant.handleAuthorizationResponse(uri.queryParameters);
      result.complete(client);
    });

    return result.future;
  }

  Future<Account?> loadUser() async {
    _client = await createClient(byStorageOnly: true);
    if (_client == null) return null;
    current = tokenToUser(_client?.credentials.idToken ?? '');
    return current;
  }

  @override
  Future<void> loggout() async {
    await launchUrl(
        Uri.parse('$baseUrl/v2/logout?client_id=$clientId&returnTo=$returnTo'),
        mode: LaunchMode.externalApplication);
    var result = await AppLinks()
        .allStringLinkStream
        .firstWhere((url) => url == returnTo);
    await storage.clear();
  }

  Account tokenToUser(String token) {
    var data = JwtDecoder.decode(token);
    return Account(
        id: data['sub'],
        name: data['name'],
        username: data['nickname'],
        email: data['email'],
        phone: data['phone'],
        image: data['picture']);
  }

  @override
  Future<Account?> signIn() async {
    var client = _client ?? await createClient();
    if (client == null) return null;
    current = tokenToUser(client.credentials.idToken ?? '');
    return current;
  }

  @override
  Future<bool> signUp(Account user, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  Future saveUser(Account user) async {
    var resp = await client!.put(Uri.parse('$baseUrl/api/v2/users/${user.id}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()));
    if (resp.statusCode != 200)
      return Future.error(resp.reasonPhrase ?? resp.body);
  }
}
