import 'dart:convert';
import 'package:http/http.dart' as http;

class BackendState {
  static final String backendUrl = "http://10.0.2.2:8000/chat_stream";
  static String? checkpointId;
  static Future<void> sendMessage(
      String msg, Function(String) onReply) async {

    var url = "$backendUrl/$msg";
    if (checkpointId != null) {
      url += "?checkpoint_id=$checkpointId";
    }
    var request = http.Request("GET", Uri.parse(url));
    final response = await http.Client().send(request);


    response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .listen((line) {
      if (line.startsWith("data:")) {
        final dataStr = line.substring(5).trim();
        if (dataStr.isEmpty) return;

        try {
          final jsonData = jsonDecode(dataStr);
          if (jsonData["type"] == "content") {
            onReply(jsonData["content"]);
          }else if(jsonData['type']=='checkpoint'){
            checkpointId=jsonData['checkpoint_id'];
          }
        } catch (_) {}
      }
    });
  }
}

