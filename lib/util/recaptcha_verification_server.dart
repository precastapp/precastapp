import 'dart:io';

class RecaptchaVerificationServer {
  final String siteKey;
  late void Function(Exception e) _onError;
  HttpServer? _server;
  late String url;

  RecaptchaVerificationServer(this.siteKey);

  set onError(void Function(Exception e) callback) {
    _onError = callback;
  }

  Future<void> start() async {
    final address = InternetAddress.loopbackIPv4;
    _server = await HttpServer.bind(address, 0);

    _server!.listen((req) async {
      try {
        final res = req.response;
        final body = _handleRequest(req);

        if (body == null) {
          res
            ..statusCode = 404
            ..write('Not found');
        } else {
          res
            ..statusCode = 200
            ..headers.add('content-type', 'text/html')
            ..write(body);
        }

        await req.response.close();
      } on Exception catch (e) {
        _onError(e);
      }
    });

    url = 'http://${address.host}:${_server!.port}';
  }

  Future<void> close() async {
    await _server?.close();
  }

  String? _handleRequest(HttpRequest req) {
    final uri = req.requestedUri;

    if (uri.path == '/' && uri.queryParameters.isEmpty) {
      return recaptchaHTML(siteKey, null);
    }

    if (uri.query.contains('response')) {
      return responseHTML(
        'Success',
        'Successful verification!',
      );
    }

    if (uri.query.contains('error-code')) {
      Future.microtask(() {
        _onError(Exception(uri.queryParameters['error-code']));
      });

      return responseHTML(
        'Captcha check failed.',
        '${uri.queryParameters['error-code']}',
      );
    }

    return null;
  }

  String recaptchaHTML(
    String? siteKey,
    String? token, {
    String? theme,
    String? size,
  }) {
    return '''
  <!DOCTYPE html>
<html>
<head>
    <title>reCAPTCHA</title>
    <script src="https://www.google.com/recaptcha/api.js" async defer></script>
    $style
</head>
<body>
<div class="g-recaptcha"
     data-sitekey="$siteKey"
     data-callback="callback"
     data-expired-callback="expiredCallback"
     data-error-callback="errorCallback"
     ></div>

<script type="text/javascript">
  var callback = function (token) {
      var url = window.location.href + ('?response=' + token)
      window.location.href = url
      Window.close()
  };

  var errorCallback = function (token) {
      var url = window.location.href + ('?error-code=CAPTCHA_CHECK_FAILED&token='+token)
      window.location.href = url
      alert(token);
  };

  var expiredCallback = function (token) {
      var url = window.location.href + ('?error-code=CAPTCHA_CHECK_FAILED')
      window.location.href = url
  };

  var onloadCallback = function() {
    grecaptcha.render('g-recaptcha', {
      'sitekey' : "$siteKey",
      'theme': "$theme",
      'size': "$size",
      'callback': "callback",
      'expired-callback': "expiredCallback",
      'error-callback': "errorCallback"
    });
  };
</script>
</body>
</html>
<html>
<body>
  ''';
    return '''
  <!DOCTYPE html>
  <html>

  <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        $style

        <title>reCAPTCHA check</title>
        <script type="text/javascript">
              var callback = function (token) {
                  var url = window.location.href + ('?response=' + token)
                  window.location.href = url
              };

              var errorCallback = function (token) {
                  var url = window.location.href + ('?error-code=CAPTCHA_CHECK_FAILED&token='+token)
                  window.location.href = url
                  alert(token);
              };

              var expiredCallback = function (token) {
                  var url = window.location.href + ('?error-code=CAPTCHA_CHECK_FAILED')
                  window.location.href = url
              };

              var onloadCallback = function() {
                grecaptcha.render('g-recaptcha', {
                  'sitekey' : "$siteKey",
                  'theme': "$theme",
                  'size': "$size",
                  'callback': "callback",
                  'expired-callback': "expiredCallback",
                  'error-callback': "errorCallback"
                });
              };
        </script>
        
  </head>

  <body>
        <div class="mdl-card firebase-container">
              <div id="g-recaptcha">
              </div>
        </div>

        <script src="https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit"
            async defer>
        </script>
  </body>

  </html>''';
  }

  String responseHTML(String title, String message) {
    return '''
  <!DOCTYPE html>
  <html>

  <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>$title</title>
        $style
  </head>

  <body>
        <div id="app-verification-screen" class="mdl-card mdl-shadow--2dp firebase-container">
              <div id="status-container">
                    <h1 class="firebase-title" id="status-container-label">$message</h1>
                    <h6 class="mdl-card__subtitle-text">This window can be closed now.</h6>
              </div>
        </div>
  </body>

  </html>''';
  }

  String style = '''
      <style>
            .mdl-card {
                  display: flex;
                  flex-direction: column;
                  font-size: 16px;
                  font-weight: 400;
                  min-height: 200px;
                  overflow: hidden;
                  width: 400px;
                  z-index: 1;
                  position: relative;
                  background: #fff;
                  border-radius: 2px;
                  box-sizing: border-box
            }

            .mdl-card__title {
                  align-items: center;
                  color: #000;
                  display: block;
                  display: flex;
                  justify-content: stretch;
                  line-height: normal;
                  padding: 16px 16px;
                  perspective-origin: 165px 56px;
                  transform-origin: 165px 56px;
                  box-sizing: border-box
            }

            .mdl-card__title-text {
                  align-self: flex-end;
                  color: inherit;
                  display: block;
                  display: flex;
                  font-size: 24px;
                  font-weight: 300;
                  line-height: normal;
                  overflow: hidden;
                  transform-origin: 149px 48px;
                  margin: 0
            }

            .mdl-card__subtitle-text {
                  font-size: 14px;
                  color: rgba(0, 0, 0, .54);
                  margin: 0;
                  text-align: center
            }

            @supports (-webkit-appearance:none) {

                  .mdl-progress:not(.mdl-progress--indeterminate):not(.mdl-progress--indeterminate)>.auxbar,
                  .mdl-progress:not(.mdl-progress__indeterminate):not(.mdl-progress__indeterminate)>.auxbar {
                        background-image: linear-gradient(to right, rgba(255, 255, 255, .7), rgba(255, 255, 255, .7)), linear-gradient(to right, #3f51b5, #3f51b5);
                        mask: url(data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+Cjxzdmcgd2lkdGg9IjEyIiBoZWlnaHQ9IjQiIHZpZXdQb3J0PSIwIDAgMTIgNCIgdmVyc2lvbj0iMS4xIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxlbGxpcHNlIGN4PSIyIiBjeT0iMiIgcng9IjIiIHJ5PSIyIj4KICAgIDxhbmltYXRlIGF0dHJpYnV0ZU5hbWU9ImN4IiBmcm9tPSIyIiB0bz0iLTEwIiBkdXI9IjAuNnMiIHJlcGVhdENvdW50PSJpbmRlZmluaXRlIiAvPgogIDwvZWxsaXBzZT4KICA8ZWxsaXBzZSBjeD0iMTQiIGN5PSIyIiByeD0iMiIgcnk9IjIiIGNsYXNzPSJsb2FkZXIiPgogICAgPGFuaW1hdGUgYXR0cmlidXRlTmFtZT0iY3giIGZyb209IjE0IiB0bz0iMiIgZHVyPSIwLjZzIiByZXBlYXRDb3VudD0iaW5kZWZpbml0ZSIgLz4KICA8L2VsbGlwc2U+Cjwvc3ZnPgo=)
                  }
            }

            @keyframes indeterminate1 {
                  0% {
                        left: 0;
                        width: 0
                  }

                  50% {
                        left: 25%;
                        width: 75%
                  }

                  75% {
                        left: 100%;
                        width: 0
                  }
            }

            @keyframes indeterminate2 {
                  0% {
                        left: 0;
                        width: 0
                  }

                  50% {
                        left: 0;
                        width: 0
                  }

                  75% {
                        left: 0;
                        width: 25%
                  }

                  100% {
                        left: 100%;
                        width: 0
                  }
            }

            .firebase-container {
                  background-color: #fff;
                  box-sizing: border-box;
                  -moz-box-sizing: border-box;
                  -webkit-box-sizing: border-box;
                  color: rgba(0, 0, 0, .87);
                  direction: ltr;
                  font: 16px Roboto, arial, sans-serif;
                  margin: 0 auto;
                  max-width: 360px;
                  overflow: hidden;
                  padding-top: 8px;
                  position: relative;
                  width: 100%
            }

            .firebase-container#app-verification-screen {
                  top: 50px
            }

            .firebase-title {
                  color: rgba(0, 0, 0, .87);
                  direction: ltr;
                  font-size: 24px;
                  font-weight: 500;
                  line-height: 24px;
                  margin: 0;
                  padding: 0;
                  text-align: center
            }

            @media (max-width:520px) {
                  .firebase-container {
                        box-shadow: none;
                        max-width: none;
                        width: 100%
                  }
            }

            body {
                  margin: 0
            }

            .firebase-container {
                  background-color: #fff;
                  box-sizing: border-box;
                  -moz-box-sizing: border-box;
                  -webkit-box-sizing: border-box;
                  color: rgba(0, 0, 0, .87);
                  direction: ltr;
                  font: 16px Roboto, arial, sans-serif;
                  margin: 0 auto;
                  max-width: 360px;
                  overflow: hidden;
                  padding-top: 8px;
                  position: relative;
                  width: 100%
            }

            .firebase-container#app-verification-screen {
                  top: 50px
            }

            .firebase-title {
                  color: rgba(0, 0, 0, .87);
                  direction: ltr;
                  font-size: 24px;
                  font-weight: 500;
                  line-height: 50px;
                  margin: 0;
                  padding: 0;
                  text-align: center
            }

            @media (max-width:520px) {
                  .firebase-container {
                        box-shadow: none;
                        max-width: none;
                        width: 100%
                  }
            }
      </style>
''';
}
