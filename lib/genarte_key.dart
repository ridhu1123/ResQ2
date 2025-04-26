import 'package:googleapis_auth/auth_io.dart';

class get_server_key {
  Future<String> server_token() async {
    final scopes = [
    
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
  "type": "service_account",
  "project_id": "resq-72836",
  "private_key_id": "d74e7949b7ec5de11207461e214c2a1ccef0355e",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCpp8E6bO84raEz\nRQZhKUZRMDi2clQ2vWAbcnnhAZCkDkeYy0d6vtfP1K5MtXFtcw/seg7A2+Qd4h1n\nTzawRO548JmkNhxf3yps+ssMyVXN/9Qj8SXGfKLOaANk7lfyCN3SqEc9I/Z+fuXJ\nEjMtJ8C3zjmvmSF8+IhNPAnf5wRH0cLHI9cIvXylRcOu5N5kSYSllFgd4khUGahd\nCflc2uBlKLob39yynjEk0PzZUH9uXYKcZZaaWjz/EYUGmurbhdC4E5roRNfM98a4\nGwS0sp2PakUjbKd4C1gl7Mxvc95MB1zkLl3bsiVCNZ8QYEDdzCyIflGMYGdFAuhS\n4mKQSDcdAgMBAAECggEAE2ZRXCL0v+Bq3Hf6IMYdek8vTP2Jz7Cb+sd+VFJffcL8\nQOaNx+VmvCcvvynITKGponrakQcT8K7YeeW+9S0Mr9ujVfmyCOx153xOF6o2G5Yz\nZeC/VxENdNjD+pieidiltN71NnKUTyank/R20aUIDnyQcBnskGPDAkHpRycdgDC2\nKhnqpVP4saioRkN7tEfqnJ/Q6rY99xJ+NzFbM6m/GSDou85L7q0Aee3mmMZFezKf\nh7qR6Irr+upgVq/Jb+jiB35vmc1UsUhSO0M1rMJAdBrYztUEy0wE0h/sthifLkxM\ngqfla4dq+p6d9uYoBuoGR89tePdk1oiKzWwVjMYDAQKBgQDtZeglrzfi5CCh1NQ5\nhrV2Ivm5nsKz20nf2B8ue6EHYGkEkKiH7qyBW6B+AbJA8aA2JhYph4V7PS14P9zL\nvHSTNyle/CVKnJyV7GsvXfqNG2736kTh3S3ozyz7VZSXCC7lvvfBOcDKl1kwHQRj\nQYE578iUtl4qINyKtFnrTyIV4QKBgQC28vW0yqQSN7RnghNPRFi5KIq3R3hf408X\nGXZcBxymBV0O0Ltnubt374E7ukdUpDnBWRC4MGLHbwE/o7CFeiD0y/v10QlDCg/H\nzMyQik3Z/SBec4H4A+pX99NUAQan+gILpK/hLbMYmXPzPLtY5Nkm3jPiID6SwBSO\neGEl2sAQvQKBgQCuuk6/TdOoX5fVBLyfCpMMvHlpMXzEvCYHZx6sK7o9n6wr+/zO\n79Bv9WyO0djNDAqLUEUHlAOezUxmMTrliXOT1wnQK22XGOX3QucxGc6LhSGLvxWr\n2AsuSy4kXrza3N8HoiLgSQ2pDvRKAVF1bIUci2vqaL+t6jnorQ1xr/C6gQKBgHlo\nJDwU2eqpAtRJ0sygm4xMZjmYeT6Q1zSKFiyeH5nhJ08kn6kG7Wx7CTT8ukdmMFmp\n5FmG6pZUiOyVkRgS4vnwwETxsobFj5FUzFADKATIYQms94wB9SrpcFln0OX6GA9n\n+7ugGyDw/KxnGiC0xZJwlNez9DJou3uMUVPQpfK1AoGBAKHDYQbqQDLnNBsKnRwD\nxkMIDWItvAFloifMtpzaBrOFnfWT2QqIfsoHRncSiBxUF/hQfafFWLpeopNrOnOF\nj6La6xBOoiuEwscaOkmqirv7pVGX3dqEXxdNrmAeJwNadc4JYqc+AC9yVbhbjz/V\na/jhsouYmuJN7U1b3fzFVNol\n-----END PRIVATE KEY-----\n",
  "client_email": "firebase-adminsdk-fbsvc@resq-72836.iam.gserviceaccount.com",
  "client_id": "110451333649398116289",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-fbsvc%40resq-72836.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}


),
        scopes);
    final accessserverkey = client.credentials.accessToken.data;
    return accessserverkey;
  }
}