# User API Endpoints 
  

1. [Get User by Phone](#getuserphone) 
2. [Get User by Email](#getuseremail) 
1. [Get Usernames](#getusernames) 
2. [Check Phone](#checkphone)
3. [Check Email](#checkemail)
4. [Create User](#createuser1) 
5. [Create Profile](#createprofile)
6. [Edit User](#edituser) 
7. [Get Profile by UserID](#getprofile)
8. [Get Profile by ID](#getprofileid)
9. [Edit Profile](#editprofile)
   


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
  "phone" : "506 1234567",
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
	"occupation": "Bartender",
	"maxDistance": 50,
	"currLongitude": 1.8575757,
	"maxAge": 40,
	"birthdate": "1991-05-27T00:00:00Z",
	"userId": "DC730399-E21C-4BA4-8248-3E7A8753947B",
	"minAge": 20,
	"bio": "Hi my name is Jane!",
	"preference": 1,
	"currLatitude": 1000.93939393,
	"gender": 2,
	"name": "Jane"
}

```

#### Success Response:
200 OK
```json
{
	"id": "93968C3A-6CB6-4053-9EEE-6202EFB6A5CB",
	"occupation": "Bartender",
	"maxDistance": 50,
	"currLongitude": 1.8575756999999999,
	"preference": 1,
	"bio": "Hi my name is Jane!",
	"userId": "DC730399-E21C-4BA4-8248-3E7A8753947B",
	"minAge": 20,
	"birthdate": "1991-05-27T00:00:00Z",
	"maxAge": 40,
	"currLatitude": 1000.9393939300001,
	"gender": 2,
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

<img width="1093" alt="Screenshot 2023-01-05 at 10 56 55 AM" src="https://user-images.githubusercontent.com/80468156/210811493-df2b8f50-71c0-4898-b0e8-07e73640f559.png">

<img width="1281" alt="Screen Shot 2022-11-24 at 10 39 37 AM" src="https://user-images.githubusercontent.com/80468156/203811150-20cd137b-bb6f-4784-a69d-af1e7eb1920c.png">

<img width="1105" alt="Screen Shot 2022-11-28 at 10 49 12 PM" src="https://user-images.githubusercontent.com/80468156/204427345-a9be6ddb-98ad-4f2c-a46f-1ba6a73de96e.png">

---

### Edit User <a name="edituser"></a>

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

#### Request Body:     
_Note: Put requests require the entire object body to be passed in. If there is a profile that matches the given id, that profile will be updated. The birthday, id, userId fields, will not be updated under any circumstances._      
```json
{
	"id": "93968C3A-6CB6-4053-9EEE-6202EFB6A5CB",
	"occupation": "Bartender",
	"maxDistance": 50,
	"currLongitude": 1.8575757,
	"maxAge": 40,
	"birthdate": "1991-05-27T00:00:00Z",
	"userId": "DC730399-E21C-4BA4-8248-3E7A8753947B",
	"minAge": 20,
	"bio": "Hi my name is Jane!",
	"preference": 1,
	"currLatitude": 1000.93939393,
	"gender": 2,
	"name": "Jane"
}
```


#### Success Response:
200 OK  
```json
{
	"id": "93968C3A-6CB6-4053-9EEE-6202EFB6A5CB",
	"occupation": "Bartender",
	"maxDistance": 50,
	"currLongitude": 1.8575756999999999,
	"preference": 1,
	"bio": "Hi my name is Jane!",
	"userId": "DC730399-E21C-4BA4-8248-3E7A8753947B",
	"minAge": 20,
	"birthdate": "1991-05-27T00:00:00Z",
	"maxAge": 40,
	"currLatitude": 1000.9393939300001,
	"gender": 2,
	"name": "Jane"
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

<img width="1093" alt="Screenshot 2023-01-05 at 11 00 59 AM" src="https://user-images.githubusercontent.com/80468156/210812029-9a4a2887-1edb-4989-8287-f5a76bed27ce.png">


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

---

### Get Profile by ID <a name="getprofileid"></a>

#### URL:
`/profileId/:profileId`

#### Method:
`GET`

#### URL Parameters:
###### :profileID  
UUID           
The ID associated with the profile you would like to retrieve

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

<img width="943" alt="Screenshot 2022-12-28 at 6 00 57 PM" src="https://user-images.githubusercontent.com/80468156/209876888-c640abf0-eaf1-4bcb-a61f-66fb62f33fc1.png">

<img width="1115" alt="Screenshot 2022-12-28 at 6 01 07 PM" src="https://user-images.githubusercontent.com/80468156/209876899-2ff117dc-9a70-4f2c-ae0a-9cb26ca0bd68.png">

---

### Check Phone <a name="checkphone"></a>

#### URL:   
`/check/phone/:phone`

#### Method:
`GET` 

#### URL Parameters:  
###### :phone
String           
Phone number you would like to check.             


#### Success Response:
_Note: Will return true if phone number is okay to use (not a duplicate) false otherwise._       
200 OK
```json
true
```

#### Error Response: 
If no phone number is provided.           
404 Not Found
```json
{
	"error": true,
	"reason": "Not Found"
}
```

#### Example    

<img width="1109" alt="Screenshot 2023-01-30 at 5 38 43 PM" src="https://user-images.githubusercontent.com/80468156/215601527-154778bb-bb0a-411a-be44-4f63aa232373.png">

<img width="1109" alt="Screenshot 2023-01-30 at 5 38 53 PM" src="https://user-images.githubusercontent.com/80468156/215601540-edaf6efc-6200-4374-916d-3f55bcac2b4c.png">

---

### Check Email <a name="checkemail"></a>

#### URL:   
`/check/email/:email`

#### Method:
`GET` 

#### URL Parameters:  
###### :email
String           
Email you would like to check.          


#### Success Response:
_Note: Will return true if email is okay to use (not a duplicate) false otherwise._        
200 OK
```json
true
```

#### Error Response: 
If no email is provided.           
404 Not Found
```json
{
	"error": true,
	"reason": "Not Found"
}
```

#### Example  

<img width="1109" alt="Screenshot 2023-01-30 at 5 42 25 PM" src="https://user-images.githubusercontent.com/80468156/215601932-9d914b13-c730-47c1-98af-4bea34e2e324.png">

<img width="1109" alt="Screenshot 2023-01-30 at 5 42 32 PM" src="https://user-images.githubusercontent.com/80468156/215601942-03fc5d6e-eca3-47a8-9a93-b95820a900e9.png">


<img width="1109" alt="Screenshot 2023-01-30 at 5 42 42 PM" src="https://user-images.githubusercontent.com/80468156/215601992-b93db2be-be1a-4016-897b-d31db84bd5c8.png">


