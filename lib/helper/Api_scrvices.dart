import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:googleapis_auth/auth_io.dart';

class ApiService {
  ApiService._();

  static ApiService apiService = ApiService._();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  static const String baseUrl =
      'https://fcm.googleapis.com/v1/projects/chat-d0a8a/messages:send';

  // Future<void> getServerToken() async {
  //   final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
  //   final privateKey = jsonEncode(_Json);
  //   final client = ServiceAccountCredentials.fromJson(privateKey);
  //
  //   final servicesClient = await clientViaServiceAccount(client, scopes);
  //
  //   final serverToken = servicesClient.credentials.accessToken.data;
  //   log("Server Token: \n \n $serverToken \n \n");
  // }



  // onclick method call
  Future<void> sendMessage({required String title, required String body, required String token}) async {
    String accessToken = await getAccessToken();
    Map notification = {
      "message": {
        "token": token, //device token;
        "notification": {"title": title, "body": body},
        "data": {"response": "Message Done !"}
      }
    };

    final jsonNotification = jsonEncode(notification);

    try {
      var response = await http.post(Uri.parse(baseUrl),
          body: jsonNotification,
          headers: <String, String>{
            'Authorization': 'Bearer $accessToken',
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        log('Successfully sent message: ${response.body}');
      } else {
        log('Error sending message: ${response.body}');
      }
    } catch (e) {
      log("Api error:${e.toString()}");
    }
  }


  // Function to get OAuth 2.0 Bearer token
  Future<String> getAccessToken() async {
    // Load the service account credentials from the JSON file
    var accountCredentials = ServiceAccountCredentials.fromJson(_Json);

    // Define the scopes required for FCM (Cloud Platform scope)
    var scopes = ['https://www.googleapis.com/auth/firebase.messaging'];

    // Use the credentials to get an authenticated client
    var authClient = await clientViaServiceAccount(accountCredentials, scopes);

    // Return the OAuth 2.0 access token
    return authClient.credentials.accessToken.data;
  }
}
const String serverKey ='ya29.a0AcM612yZHjs1xoT-EasOpM52Epi0-S19HmjwQc9f9NMcXnEj_W_eeSIAdcFh5TTU_8vNo010jfVFiaGVJKOzSgeIQ9zK2ketpcGTxwHXiPKUPXfxprmsvUKPxOCjbhXLLiAGUZCeya5qBxgD398ALSlgw3M4yha_0669HRs2aCgYKAbgSARESFQHGX2MiBGq-KkZyMS-fEOMP0Woo6w0175';
final _Json = {
  "type": "service_account",
  "project_id": "chat-d0a8a",
  "private_key_id": "0a95761c6c747ac89b76f8f690e398a72339f66c",
  "private_key":
      "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCa6pKuzXh5uKuW\n0NFQr5es1DwjDdWvD7JyPAq+l0UmY80JZV2lVedlThA6USNzx/Wf4fn4ey88JICK\nt4eDtp7KQoyspn+47niohFeUejYCtxYDJs7NpfMCq+pUm54PBvTyvP2rxzYxfntP\nRzd17Ac37yurMnHIKm/11vqK9iusgK0PGSwEwtHYlS5mWuP8HDMm/Z9ftNIAUxvi\nt4Sw+JZK1B0V5EHmblZ3DN/AkbQM+RjzshFXg7vtDeBwhTa3aEEfSbDqsWNPwnV+\n1zNxJlEiv1qbYkqaSY4aYXIdYd7bscIbNj3eTfG/b05VzLMarXfl75pAV6SvO+p/\nC1XbhKKVAgMBAAECggEAC03yFZFm04hh9RJt2R5xyf8pbZa/22jLfmyFODKKWD/Q\nzCO6eVXTGeBgF3FTo0pEe+id42pRyxNlfI83SKmV3W/icLgsT865vUpS/cG2mUIf\nosE9NrfVC4KHX1SFFyxMdD4i9gWxHbF7cWXiqoHmZkgsqUR4FcGLA/yDsd+UK5/n\nGvjw97ovPiyIR5XKGGdnALsESy2eH2IIO961uvkZmcdQloRrSxmO64PXNqbbk30j\nIN81KUBiQDxp/H//z8K8QJRszSJ5ie0Hvu9C1e89pRKxEAQ9J1aHMc3RxHqH0k9C\nTCKjbXoFV8vP6Y4faDyX7MZQSwukDU/vQzy+FRb+7QKBgQDI14HqcM/BDdP4lCyu\nsseDSXFhpRAEbc7VKiIIUb6T4VS6l+i6/MtuFIo4mLdnbaLEkTyZkTn3vhQz6Kqp\nXnx8afebQ5yb41kML77yn11GAD5T3WaWiETqNphfatCVZ4BBuvYRZyjLJUdGt9rw\naF6f2MdWlvVU1nGXPaPo2CApkwKBgQDFdjN2AHuoqAH5vF9CUdVVlpnobUwRu/oC\nkHT/F5ywTZO+CbtoY/F9P7FYkIlU1Gax2R4fVe84ONMxCm7QheACROgFQqAnYchE\nUkU/s+S5LkxhgnD6sxcUZI+WJvHEq+V0s/5RrkHjbm59xkTJwtlM7JSI5JME8UpE\nhoLsXvX8NwKBgDDHTpFO9tZPcnUEH9oKJ7S2KKhre3ln5f0Vr5BPsjaeWoK7FFYd\nwZapvGxEgv7GvOp6z7oIcIjADI4S6ygZf6iD4BRAlo+x5tWz3u90TyYKNxkNQ7Y5\nwGsV+WnrOl+e9KKCMvNFF75G/ompa65J2vl9n+Ri45DISGxQFzgdDaqrAoGAPBNp\nNraQ6NAswbFY/hFtqXuHWdqe8SpStyMCJXYmmtEPaRsG5Iy7tRKCv2JCFggFMojP\nDFOV03IeduYortJ8Q9R5DtilZzXtuzOYk/gEV37JiEUqYGvKUs8BjHpOxjpSNj5o\n2qr8qtg3T5bZ6NSaTjgQPNHmFPPgV5bhEE8X4eMCgYBpd7wfdRYYf6UJlXCVb/3b\nQqeXy49zhbb5ZCrPuC/n8H5dhd9835F/UwOZgY6t04Rd2dDysVtBqB1tsOdXaNuS\nc7FEF+cTARwBx2vJW9gjF0atqBF97U+p5L9Om+m9u6sve4v+NWyJ+F5uKSU1M8Kw\nvBVIz8t3VMDDrOIJ4ir9ng==\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-xcyxw@chat-d0a8a.iam.gserviceaccount.com",
  "client_id": "100584799137321064164",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url":
      "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-xcyxw%40chat-d0a8a.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
};
