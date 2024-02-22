const String apiKeyChatGpt = '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';
const String apiKeyLlama2 = 'r8_Szy53LfD25WvKkQLc9XGeZqbktzPh3P04nzzg';
const String apiKeyGemini = 'AIzaSyAFZLt-OFgKUtIflc8gOmWnOx9N9n51N9Q';
const String curlGemini = '''curl https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyAFZLt-OFgKUtIflc8gOmWnOx9N9n51N9Q
    -H 'Content-Type: application/json'
    -X POST
    -d '{
      "contents": [{
        "parts":[{
          "text": "Write a story about a magic backpack."}]}]}' 2> /dev/null''';