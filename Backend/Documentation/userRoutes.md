# User API Endpoints 
  

1. [Get User by Phone](#getuserphone) 
2. [Get User by Email](#getuseremail) 
1. [Get Usernames](#getusernames) 
2. [Create User](#createuser1) 
3. [Create Profile](#createprofile)
1. [Edit User Account](#edituser) 
2. [Get Profile by UserID](#getprofile)
3. [Edit Profile](#editprofile)
12. [Delete User] TODO (also delete all corresponding records in other tables)
   


---

### Get User by Phone <a name="getuserphone"></a>

#### URL:
`/user/phone/:phone/:password`

#### Method:
`GET`

#### URL Parameters:
###### :phone  
string   
The phone number the user is trying to log in with  

###### :password   
bytea    
The password the user is trying to log in with

#### Success Response:
200 OK
```json 
{
  "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
  "username" : "janeDoe123", 
  "password" : "Password1", 
  "phone" : "506 1234567"
  "email" : "jane@hotmail.com" 
}
```

#### Error Response: 
404 Not Found
```json
{
  "error" : true, 
  "reason" : "No user record found."
}
```

#### Example
<img width="1101" alt="Screen Shot 2022-11-08 at 5 33 30 PM" src="https://user-images.githubusercontent.com/80468156/200680686-3daa63c4-76ae-435a-aab9-a9f65894a2e6.png">

<img width="1101" alt="Screen Shot 2022-11-08 at 5 33 05 PM" src="https://user-images.githubusercontent.com/80468156/200680636-0848c794-c328-40d0-9e07-3ce1b3f6c1d4.png">


---

### Get User by Email <a name="getuseremail"></a>

#### URL:
`/user/email/:email/:password`

#### Method:
`GET`

#### URL Parameters:
###### :email
string   
The email the user is trying to log in with  

###### :password  
bytea        
The password the user is trying to log in with

#### Success Response:
200 OK 
```json
{
  "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
  "username" : "janeDoe123", 
  "password" : "Password1", 
  "phone" : "506 1234567"
  "email" : "jane@hotmail.com" 
}
```

#### Error Response: 
404 Not Found
```json
{
  "error" : true, 
  "reason" : "No user record found."
}
```

#### Example
<img width="1101" alt="Screen Shot 2022-11-08 at 5 33 56 PM" src="https://user-images.githubusercontent.com/80468156/200680729-519a2e7d-b2bd-487a-b86a-9f40a3dd2994.png">

<img width="1101" alt="Screen Shot 2022-11-08 at 5 39 57 PM" src="https://user-images.githubusercontent.com/80468156/200681577-07f57fc5-eaa2-4f6d-8792-185fbc53e156.png">

---

### Get Usernames <a name="getusernames"></a>

#### URL:   
`/usernames/:usernameMatch`

#### Method:
`GET` 

#### URL Parameters:  
###### :usernameMatch
String           
The first 3 characters of the username the user would like to use     
_Note: This is case sensitive (can be changed)_       


#### Success Response:
(*NOTE:* Only usernames that match the first 3 characters are returned. Results listed in alphabetical order. If no usernames match the first 3 characters empty array is returned.)        
200 OK
```json
[
  "jan",
  "jane",
  "jane13",
  "jannieDoe13"
]
```

#### Error Response: 
(*NOTE:* This endpoint should not result in error message.)            
404 Not Found
```json
{
  "error" : "Endpoint does not exist"
}
```

#### Example    

<img width="1134" alt="Screen Shot 2022-11-08 at 6 08 08 PM" src="https://user-images.githubusercontent.com/80468156/200686406-eb08f8bf-9ea4-4f69-87d1-c18d61f4707f.png">

<img width="1134" alt="Screen Shot 2022-11-08 at 6 03 15 PM" src="https://user-images.githubusercontent.com/80468156/200686443-59003c61-132c-40c9-8bbb-87379d018627.png">

---

### Create User <a name="createuser1"></a>

#### URL:   
`/user`

#### Method:
`POST` 

#### Request Body:    
```json
{
  "username" : "janeDoe123", 
  "password" : "Password1", 
  "phone" : "506 1234567"
  "email" : "jane@hotmail.com" 
}
```

#### Success Response:
200 OK
```json
{ 
  "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
  "username" : "janeDoe123", 
  "password" : "Password1", 
  "phone" : "506 1234567"
  "email" : "jane@hotmail.com" 
}
```

#### Error Response: 
500 Internal Server Error (for duplicate username, phone, email) 
```json
{
	"error": true,
	"reason": "Illegal username value: allieGriffin1."
}
```
400 Bad Request
```json
{
  "error" : true, 
  "reason" : "An error message that describes missing field"
}
```
_Note: Phone or Email field may be empty, but must still be included in request body._    


#### Example    

<img width="1101" alt="Screen Shot 2022-11-08 at 5 50 55 PM" src="https://user-images.githubusercontent.com/80468156/200684347-3ed243ca-b772-4366-baa5-d39562faaa1b.png">

<img width="1134" alt="Screen Shot 2022-11-08 at 5 52 20 PM" src="https://user-images.githubusercontent.com/80468156/200684363-5abac93d-2564-4c27-8354-3bf0c00c0da1.png">

<img width="1105" alt="Screen Shot 2022-11-28 at 10 48 59 PM" src="https://user-images.githubusercontent.com/80468156/204427163-98e553a9-3e39-40d8-a4af-089d558b10bb.png">


---

### Create Profile <a name="createprofile"></a>

#### URL:  
`/profile`

#### Method:
`POST`

#### Request Body:  
_NOTE: User must be created before profile._          
```json
{
  "userId": "695C8249-10B1-4CD3-BE98-E1400B1823B3",
  "name": "Jane",
  "occupation": "Teacher" ,
  "birthdate": "2001-05-27T00:00:00Z",
  "bio": "Hey Everyone! I love the outdoors and my cats :)",
  "gender": 1,
  "preference": 0, 
  "minAge": 25,
  "maxAge": 40, 
  "maxDistance": 50
}

```

#### Success Response:
200 OK
```json
{
   "userId": "695C8249-10B1-4CD3-BE98-E1400B1823B3",
   "minAge": 25,
   "maxAge": 40,
   "id": "7CD9800F-AE36-40B5-A0DA-B355014E09F2",
   "bio": "Hey Everyone! I love the outdoors and my cats :)",
   "gender": 1,
   "maxDistance": 50,
   "occupation": "Teacher",
   "birthdate": "2001-05-27T00:00:00Z",
   "preference": 0,
   "name": "Jane"
}
```

#### Error Response: 
404 Not Found 
```json
{
	"error": true,
	"reason": "No user record found with ID: 5FA66D14-F1C2-43EF-B98D-789297C61B65."
}
```
400 Bad Request
```json
{
  "error": true,
  "reason": "Value of type 'Int16' required for key 'maxDistance'."
}
```

#### Example  

<img width="1281" alt="Screen Shot 2022-11-24 at 10 39 26 AM" src="https://user-images.githubusercontent.com/80468156/203811106-e4706487-4760-4ea1-b51a-94c78fb3a8e8.png">

<img width="1281" alt="Screen Shot 2022-11-24 at 10 39 37 AM" src="https://user-images.githubusercontent.com/80468156/203811150-20cd137b-bb6f-4784-a69d-af1e7eb1920c.png">

<img width="1105" alt="Screen Shot 2022-11-28 at 10 49 12 PM" src="https://user-images.githubusercontent.com/80468156/204427345-a9be6ddb-98ad-4f2c-a46f-1ba6a73de96e.png">


---

### Edit User Account <a name="edituser"></a>

#### URL:
`/user`

#### Method: 
`PUT`       
_Note: Put requests require the entire object body to be passed in. If there is a user record that matches the given id, that record will be updated. For our use ONLY email, phone, and password will be updated. If there is no user record that matches given id - nothing will happen in database (still 200 OK)._


#### Request Body:  
The following request body will update the user record with the new phone number.     

```json
{
  "id" : "F104C4E8-3039-48B1-917C-D3227CAFEBCB",
  "username" : "AllieG",
  "email": "",
  "phone"  : "5061234567" 
}
```


#### Success Response:
200 OK  
```json
{
  "id" : "F104C4E8-3039-48B1-917C-D3227CAFEBCB",
  "username" : "AllieG",
  "email": "",
  "phone"  : "5061234567"
}
```

#### Error Response: 
400 Bad Request       
_Note: This will occur when a field is missing, or invalid UUID is given_
```json
{
 "error" : true, 
 "reason" : "Value of type 'String' required for key 'email'."
}
```

#### Example

<img width="1134" alt="Screen Shot 2022-11-09 at 3 02 36 PM" src="https://user-images.githubusercontent.com/80468156/200919694-00ab571e-2af0-4f5b-b480-39921e7d4678.png">

<img width="1134" alt="Screen Shot 2022-11-09 at 3 02 57 PM" src="https://user-images.githubusercontent.com/80468156/200919949-9ef3b9b7-fa68-42c2-b077-0705c50f02b3.png">


<img width="1134" alt="Screen Shot 2022-11-09 at 3 03 20 PM" src="https://user-images.githubusercontent.com/80468156/200919723-8880c5a7-4174-4e5e-b9fe-5320b017c6c5.png">


---


### Edit Profile <a name="editprofile"></a>

#### URL:
`/profile`

#### Method:
`PUT`       
_Note: Put requests require the entire object body to be passed in. If there is a profile that matches the given id, that profile will be updated. The birthday field will not be updated under any circumstances._


#### Request Body:     

```json
{
  "id": "F5DBA633-EAFF-4A6C-9FE1-C8ADBC78A1C5",
  "userId": "695C8249-10B1-4CD3-BE98-E1400B1823B3",
  "name": "Janey",
  "occupation": "Unemployed" ,
  "birthdate": "2001-05-27T00:00:00Z",
  "bio": "Hey Everyone! I love the outdoors and my cats :)",
  "gender": 1,
  "preference": 0, 
  "minAge": 25,
  "maxAge": 40, 
  "maxDistance": 50
}
```


#### Success Response:
200 OK  
```json
{
  "userId": "695C8249-10B1-4CD3-BE98-E1400B1823B3",
  "maxAge": 40,
  "gender": 1,
  "id": "F5DBA633-EAFF-4A6C-9FE1-C8ADBC78A1C5",
  "minAge": 25,
  "bio": "Hey Everyone! I love the outdoors and my cats :)",
  "maxDistance": 50,
  "birthdate": "2001-05-27T00:00:00Z",
  "occupation": "Unemployed",
  "preference": 0,
  "name": "Janey"
}
```

#### Error Response: 
400 Bad Request       
_Note: This will occur when a field is missing, or invalid/nil UUID is given._
```json
{
  "error": true,
  "reason": "Illegal nil ID."
}
```

#### Example

<img width="1026" alt="Screen Shot 2022-11-24 at 11 03 01 AM" src="https://user-images.githubusercontent.com/80468156/203818754-16b56bca-a5d6-4597-8736-0731e49bfa13.png">

<img width="1026" alt="Screen Shot 2022-11-24 at 11 14 20 AM" src="https://user-images.githubusercontent.com/80468156/203818812-3e4b2587-e604-47bc-9080-c54fb10985ba.png">


---

### Get Profile by UserID <a name="getprofile"></a>

#### URL:
`/profile/:userID`

#### Method:
`GET`

#### URL Parameters:
###### :userID  
UUID           
The userID associated with the profile you would like to retrieve

#### Success Response:
200 OK  
```json
{
  "gender": 1,
  "maxAge": 40,
  "userId": "695C8249-10B1-4CD3-BE98-E1400B1823B3",
  "id": "710E4BAD-63E1-4C03-A76D-EB8DED59C7D6",
  "bio": "Hey Everyone! I love the outdoors and my cats :)",
  "minAge": 25,
  "maxDistance": 50,
  "occupation": "Teacher",
  "birthdate": "2001-05-27T00:00:00Z",
  "preference": 0,
   "name": "Jane"
}
```

#### Error Response: 
404 Not Found
```json
{
  "error": true,
  "reason": "Illegal nil ID."
}
```

#### Example

<img width="1112" alt="Screen Shot 2022-11-24 at 11 29 26 AM" src="https://user-images.githubusercontent.com/80468156/203821327-915943e3-d488-445f-bb54-9c8ef03975e6.png">

<img width="1112" alt="Screen Shot 2022-11-24 at 11 29 12 AM" src="https://user-images.githubusercontent.com/80468156/203821340-508c69b2-c708-430a-89f3-7298d18d9093.png">
