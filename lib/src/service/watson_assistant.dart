import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class WatsonAssistantV2Credential {
  String username;
  String apikey;
  String version;
  String url;
  String assistantID;

  WatsonAssistantV2Credential({
    required this.apikey,
    required this.username,
    required this.assistantID,
    required this.url,
    required this.version,
  });
}

class WatsonAssitantContext {
  Map<String, dynamic>? context;

  WatsonAssitantContext({
    this.context,
  });

  void resetContext() {
    context = {};
  }
}

class WatsonAssistantResponse {
  String? responseText;
  String? responseImage;
  String? responseOptions;
  String responseType;
  WatsonAssitantContext? context;

  WatsonAssistantResponse({
    this.responseText,
    this.responseImage,
    this.responseOptions,
    required this.responseType,
    this.context,
  });
}

class WatsonAssistantApiV2 {
  WatsonAssistantV2Credential watsonAssistantV2Credential;

  WatsonAssistantApiV2({
    required this.watsonAssistantV2Credential,
  });

  Future<WatsonAssistantResponse> sendMessage(
      {required String textInput,
      required WatsonAssitantContext watsonAssitantContext}) async {
    try {
      List<String> urlBase = watsonAssistantV2Credential.url.split('https://');
      List<String> pathURL = urlBase[0].split('/');
      String url = pathURL[0];
      String instance = pathURL[1];
      String urlPath = pathURL[2];
      String urlV = pathURL[3];
      String urlWatsonAssistant =
          "/$instance/$urlPath/$urlV/assistants/${watsonAssistantV2Credential.assistantID}/sessions";

      String token = base64Encode(utf8.encode(
          '${watsonAssistantV2Credential.username}:${watsonAssistantV2Credential.apikey}'));

      Map<String, dynamic> _body = {
        "input": {"text": textInput},
        "context": watsonAssitantContext.context
      };

      var _getSessionId = await http.post(
        Uri.https(url, urlWatsonAssistant,
            {"version": watsonAssistantV2Credential.version}),
        headers: <String, String>{
          HttpHeaders.authorizationHeader: 'Basic $token',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode(_body),
      );

      try {
        if (_getSessionId.statusCode != 201) {
          throw Exception(
              'post error: StatusCode = ${_getSessionId.statusCode}');
        }
      } on Exception {
        //print('Failed to load post');
        //print("PRINT: ${createSession.statusCode}");
      }

      var parseJsonSessionId = json.decode(_getSessionId.body);
      String sessionId = parseJsonSessionId['session_id'];
      var receivedJson = await http.post(
        Uri.https(url, '/$urlWatsonAssistant/$sessionId/message',
            {"version": watsonAssistantV2Credential.version}),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Basic $token'
        },
        body: json.encode(_body),
      );
      String? _watsonResponseText;
      String? _watsonResponseImage;
      String? _watsonResponseOptions;
      String _watsonResponseType;

      var getParsedJson = json.decode(receivedJson.body);
      var _responseType =
          getParsedJson['output']['generic'][0]['response_type'];
      _watsonResponseType = _responseType;

      switch (_responseType) {
        case 'text':
          _watsonResponseText = getParsedJson['output']['generic'][0]['text'];
          break;
        case 'image':
          _watsonResponseImage =
              jsonEncode(getParsedJson['output']['generic'][0]);
          break;
        case 'option':
          _watsonResponseOptions =
              jsonEncode(getParsedJson['output']['generic'][0]);
          break;
      }

      Map<String, dynamic> _result = json.decode(receivedJson.body);

      WatsonAssitantContext _context =
          WatsonAssitantContext(context: _result['context']);

      WatsonAssistantResponse watsonAssistantResult = WatsonAssistantResponse(
          context: _context,
          responseText: _watsonResponseText,
          responseImage: _watsonResponseImage,
          responseOptions: _watsonResponseOptions,
          responseType: _watsonResponseType);
      return watsonAssistantResult;
    } catch (err) {
      WatsonAssistantResponse watsonAssistantResult = WatsonAssistantResponse(
          responseText: "Erro de conexão!", responseType: 'text');

      return watsonAssistantResult;
    }
  }
}
