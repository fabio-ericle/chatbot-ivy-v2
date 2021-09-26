import 'package:http/http.dart' as http;
import 'dart:convert';

class WatsonAssistantResponse {
  String? resultText;
  WatsonAssitantContext? context;

  WatsonAssistantResponse({
    this.resultText,
    this.context,
  });
}

class WatsonAssitantContext {
  Map<String, dynamic> context;

  WatsonAssitantContext({
    required this.context,
  });

  void resetContext() {
    context = {};
  }
}

class WatsonAssistantV2Credential {
  String username;
  String apikey;
  String version;
  String url;
  String assistantID;

  WatsonAssistantV2Credential({
    this.username = 'apikey',
    required this.apikey,
    this.version = "2019-02-28",
    required this.url,
    required this.assistantID,
  });
}

class WatsonAssistantApiV2 {
  WatsonAssistantV2Credential watsonAssistantV2Credential;

  WatsonAssistantApiV2({
    required this.watsonAssistantV2Credential,
  });

  Future<WatsonAssistantResponse> sendMessage(
      {required String textInput,
      WatsonAssitantContext? watsonAssitantContext}) async {
    try {
      String urlWatsonAssistan =
          "/assistants/${watsonAssistantV2Credential.assistantID}/sessions";

      var auth = 'Basic' +
          base64Encode(utf8.encode(
              '${watsonAssistantV2Credential.username}:${watsonAssistantV2Credential.apikey}'));

      Map<String, dynamic> _body = {
        "input": {"text": textInput},
        "context": watsonAssitantContext!.context
      };
      //Crashed application
      var newSess = await http.post(
          Uri.https(watsonAssistantV2Credential.url, urlWatsonAssistan,
              {"version": watsonAssistantV2Credential.version}),
          headers: {'Content-Type': 'application/json', 'Authorization': auth},
          body: json.encode(_body));
      print(newSess);
      try {
        if (newSess.statusCode != 201) {
          throw Exception('post error: StatusCode = ${newSess.statusCode}');
        }
      } on Exception {
        print('Failed to load post');
        print("PRINT: ${newSess.statusCode}");
      }

      print("PRINT: ${newSess.body}");

      var parseJsonSession = json.decode(newSess.body);
      String sessionId = parseJsonSession['session_id'];

      var receivedText = await http.post(
        Uri.https(
            watsonAssistantV2Credential.url,
            '$urlWatsonAssistan/$sessionId/message',
            {"version": watsonAssistantV2Credential.version}),
        headers: {'Content-Type': 'application/json', 'Authorization': auth},
        body: json.encode(_body),
      );

      var parsedJson = json.decode(receivedText.body);
      var _watsonResponse = parsedJson['output']['generic'][0]['text'];

      Map<String, dynamic> _result = json.decode(receivedText.body);

      WatsonAssitantContext _context =
          WatsonAssitantContext(context: _result['context']);

      WatsonAssistantResponse watsonAssistantResult = WatsonAssistantResponse(
          context: _context, resultText: _watsonResponse);
      return watsonAssistantResult;
    } catch (err) {
      //Only debug
      WatsonAssistantResponse watsonAssistantResult =
          WatsonAssistantResponse(resultText: "$err");
      return watsonAssistantResult;
    }
  }
}
