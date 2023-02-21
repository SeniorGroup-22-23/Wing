# API Authentication Instructions 

1. [Token Usage and Generation](#tokenusage) 
2. [Trouble Shooting](#troubleshooting) 

---

The Wing API uses JWT (JSON Web Token) to authenticate users trying to access endpoints. Authentication needs to be added to each API request, this ensures only valid parties can access information stored in the database. As of now, JWT is the primary authentication method used in Wing. Future work will expand on Wing security measures. 

---
## Token usage and Generation <a name="tokenusage"></a>

In Insomnia, add authentication to an API request by selecting _Auth_ tab and _Bearer Token_ option. The prefix for our API is _Bearer_.     

<img width="832" alt="Screenshot 2023-02-20 at 7 47 19 PM" src="https://user-images.githubusercontent.com/80468156/220214216-5b5a2154-ec10-4516-93d3-0541cba170f9.png">

The token is generated based on:

1. Algorithm Used 
2. Payload Data
3. Signature

<img width="1229" alt="Screenshot 2023-02-20 at 7 52 36 PM" src="https://user-images.githubusercontent.com/80468156/220214528-7b1165fb-f192-4e5e-b9cf-5b04839ad43f.png">

For now - we will use the following data for all token generation:

### Header 
```
{
  "alg": "HS256",
  "typ": "JWT"
}

```

### Payload
```
{
  "sub": "frontend",
  "exp": 64092211200,
  "admin": true
}
```

### Signature

```
HMACSHA256(
  base64UrlEncode(header) + "." +
  base64UrlEncode(payload),
  SECRET-KEY
)
```

### Token

`eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJmcm9udGVuZCIsImV4cCI6NjQwOTIyMTEyMDAsImFkbWluIjp0cnVlfQ.6ZBS25YqW-NBc4HGH9PRyRU7MFdvwRECE8umsVettXM`

### Key Access

TBD

To generate a JWT token use this website: https://jwt.io/

---

## Troubleshooting <a name="troubleshooting"></a>

#### No Auth    
No authorization header provided in request. Add Bearer prefix and token to request authorization header.     

<img width="1320" alt="Screenshot 2023-02-20 at 8 04 30 PM" src="https://user-images.githubusercontent.com/80468156/220216039-91d7945c-257b-4bf7-8945-89504a15919d.png">

#### Invalid Key
Invalid secret key in signature, regenerate your token with the proper secret, payload, and header.     

<img width="1320" alt="Screenshot 2023-02-20 at 8 05 40 PM" src="https://user-images.githubusercontent.com/80468156/220215860-abbd122f-beae-4da4-a8c7-7ec29c63bb41.png">


#### Congrats!     
Authorization is working properly.    

<img width="1320" alt="Screenshot 2023-02-20 at 8 05 07 PM" src="https://user-images.githubusercontent.com/80468156/220215838-d1f96184-7a8e-4caf-9f90-3c03682f2f5d.png">




