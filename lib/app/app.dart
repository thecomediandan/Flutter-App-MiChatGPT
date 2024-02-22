import 'package:flutter_application_chatgpt/infrastructure/helpers/api_keys.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
    // Access your API key as an environment variable (see "Set up your API key" above)
  // final apiKey = Platform.environment['API_KEY'];
  // if (apiKey == null) {
  //   print('No \$API_KEY environment variable');
  //   exit(1);
  // }
  // For text-only input, use the gemini-pro model
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKeyGemini);
  final content = [Content.text('Write a story about a magic backpack.')];
  final response = await model.generateContent(content);
  print(response.text);
}
//animate_do, FadeIn, BounceInLeft