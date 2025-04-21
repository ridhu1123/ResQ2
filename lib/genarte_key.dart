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
  "private_key_id": "3f9742262ea6d3835c84a5b40a59e273d3f6edb4",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCzBaEGMmY+4WTe\nW/Nl/+xYanV7AEnRSm1kNOHJe+Fx/sVZskdvlOfolRuS6jkVGlmsODiAWKjdT2Dk\n1R+5r4iCUYgzPFHw8bOPwZ+ee56SuYxFcDtPa3YKDG9uQ4fJbxI3VBSgUUreQINc\nOoQqiVoUS1x1CHPrcMpQAcG/EldmK/qmeXDUyIRnZGVQ2P4x3DM9jBhi4urIJmEk\nf5Xi1P2pkPEMNbKA1O2G51NkbTpmdW7P9VxqlIPsPAQNDmK2Z/sxfqTLF9TGO9ZE\nwBgy+NdAFACTwxGkg3bSJA8hiPUwYZgmE4kW0UOiDk3y1inrOS9+YnjbXqmyr059\nAGLgeFTlAgMBAAECggEAH4wlZS8qf3g+y0SO7vGbl7UjAMr7NyuTfW4oP9ZZ0znf\nU0AsgIhQGdd05X3rE0HyfXvm0Q9OqrlbTNgV4CYDu1tc0hKWKgyd5P5s/4OvXRHf\nmzj86rD4OysX0+mIm0G8hw2FGP9aXzIlM/KH6esMebkSEPmtW9cjf9ffaal0x2c6\nlJWdEmTqoTxBO9MFbRuf4mR0JjTw2Av8rzEr+JivPRu+Ktr630Fn4nEnSF/3/9vA\n5skkqKpoL3OuangNhGoKw1rSUaB4FShEHIWEGvMCKw5KEaDeLfJcBev1S0ZwU4F4\niIoSggJyZ4UVCymh54jpj/Y3JpySNRHWUVfot7Zi3QKBgQDy/5P6fm+gmAJANCL/\nnfkl8K487Wl1xGBmoNFjoZvfD+mPeGUK3lNt1FZxe4VWjSPDl52kS1IM88DtsPmr\nR9vext21PMMAVnmgk6/7OugCzQXq37R+67+L4Ta7zz2QkJcPhOPoxP64eWmzIdVD\nJ9dzCepvtnp7QE0zWIg4gq/srwKBgQC8mb9SS2WzmEIPTHOlERqZ5shjXmWu+u7F\nT51eTfn4luIpD9rm2SPSBuiI2wYpO89V6WgzgTB9tlyAKBzJEOG8Z6rlTh60s9id\nMP5dup4uu1oL3P/s5hsZVEcBi1tW7TNm9WevH/5KelZu9z9ucK7ULQJftTNuLuhc\nBQKdmIWEqwKBgQDtO5NOpI16ba0U3VGl2KZa4gRZOzcQYG31A+AosqgoN7K//Lw4\nxiERQpI6LGtaumRGGgkvUtGCD5807uhwzbDcZ64fuHhwJfyMRmMylKnZwiuayFfA\n6YuRlogHByaFsoOoBQc0Qs6jbvVAizFXZNg0WWPlOHOPTJGSJUaoVP5HxQKBgF5h\n3rHzU3D+CEkZrGH13kcYjD3WNrLLlwQdJJbWFPuHnqSH77dJATkRBfu/CCVIbikD\nRodH5ply0nW8HTOuBBnCE27vmkQ6IHQB2bnUM2cVkSmQrm7CdNtHJsWqFMq6p9el\nhf7I1vw0nt6nUxIUyBkccSyuRI+mX9f1FesCMgdDAoGBAIjY5PycmYTn7WHDqLtf\nZdT7/tlTTUVQcr808gqBbTjoY5ppShVytss0PiF3EcqfhMblpxg0A15GEMrd3rKM\nGYCKZZRWkOVeupsjkezeObd+Cs1EpluGwo9/aC5r3+WCLvKHEdjGFm1OQdhXHted\nFSGjwdhPcHqV6uawVgEG+uHm\n-----END PRIVATE KEY-----\n",
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