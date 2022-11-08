# Wing API Endpoints 
  
1. [Login](#login)
   1. [Get User by Phone](#getuserphone) DONE
   2. [Get User by Email](#getuseremail) DONE
2. [Create User Account](#createuser)
   1. [Get Usernames](#getusernames) 
   2. [Create User](#createuser1)
   3. [Create Profile](#createprofile)
   4. [Add Photos](#addphotos)
   5. [Get All Prompts](#getallprompts) DONE
   6. [Add Prompt Response to User Account](#addpromptsuser) DONE
3. [Match](#matches)  
   1. [Get Prospects]
5. [Settings](#settings)
   1. [Get Profile by UserID](#getprofile)
   2. [Edit Profile]
   3. [Get Photos by UserID](#getphotos)
   4. [Edit Photos]
   5. [Get Prompts by UserID](#getprompts)
   6. [Edit Prompts]
   

---

# Login <a name="login"></a>

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

<img width="1101" alt="Screen Shot 2022-11-08 at 5 31 31 PM" src="https://user-images.githubusercontent.com/80468156/200680765-54b95ad2-15b3-422c-8148-795ce41f9eda.png">


---

# Create User Account  <a name="createuser"></a>

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
201 Created
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
400 Bad Request
```json
{
  "error" : {
    "message" : "Bad syntax",
    "field" : "phone",
    "error" : "Phone cannot contain characters."
  }
}
```

#### Example    

---

### Create Profile <a name="createprofile"></a>

#### URL:  
`/profile`

#### Method:
`POST`

#### Request Body:   
```json
{
  "user_id" : "345ccff2-5878-44bc-5c3d-0242ac120002",
  "name" : "Jane",
  "birthdate" : "1998-04-23T18:25:43.511Z",
  "occupation" : "Teacher" ,
  "bio" : "Hey Everyone! I love the outdoors and my cats :)",
  "gender" : 1,
  "preference" : 0, 
  "min_age" : 25,
  "max_age" : 40, 
  "max_distance" : 50
}
```

#### Success Response:
201 Created
```json
{
  "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
  "user_id" : "345ccff2-5878-44bc-5c3d-0242ac120002",
  "name" : "Jane",
  "birthdate" : "1998-04-23T18:25:43.511Z",
  "occupation" : "Teacher" ,
  "bio" : "Hey Everyone! I love the outdoors and my cats :)",
  "gender" : 1,
  "preference" : 0, 
  "min_age" : 25,
  "max_age" : 40, 
  "max_distance" : 50
}
```

#### Error Response: 
400 Bad Request
```json
{
  "error" : {
    "message" : "Bad syntax",
    "field" : "birthdate",
    "error" : "Invalid birthdate."
  }
}
```

#### Example  

---

### Add Photos <a name="addphotos"></a>

#### URL:  
`/photos/:userID`

#### Method: 
`POST`

#### URL Parameters:  
###### :userID
UUID           
The userID associated with the profile you would like to add photos too

#### Request Body:  
Multipart Form

#### Success Response:
201 Created
```json
{
  "photos": [
    {
      "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
      "user_id" : "345ccff2-5878-44bc-5c3d-0242ac120002" ,
      "photo" : "photo/url"
    },
    {
      "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
      "user_id" : "345ccff2-5878-44bc-5c3d-0242ac120002" ,
      "photo" : "photo/url"
    }
  ]
}
```

#### Error Response: 
400 Bad Request
```json
{
  "error" : {
    "message" : "Bad syntax",
    "field" : ":userID",
    "error" : "Invalid userID."
  }
}
```

#### Example

---


### Get All Prompts <a name="getallprompts"></a>

#### URL:  
`/prompts`

#### Method: 
`GET`

#### Success Response:
200 OK
```json
  [
    {
      "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
      "promptText" : "What is your favorite holiday?" 
    },
    {
      "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
      "promptText" : "If you could pick one superpower, what would it be?"
    },
    {
      "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
      "promptText" : "Where in the world would you like to travel?"
    }
  ]
```

#### Error Response:  
(*NOTE:* This endpoint should not result in error.)            
404 Not Found
```json
{
  "error" : "Endpoint not found"
}
```

#### Example

<img width="957" alt="Screen Shot 2022-11-08 at 2 53 44 PM" src="https://user-images.githubusercontent.com/80468156/200650968-9946f25f-b995-46b7-874e-59b10ddebfaa.png">

---


### Add Prompt Response to User Account <a name="addpromptsuser"></a>

#### URL:  
`/prompts/user`

#### Method: 
`POST`

#### Request Body:  
```json
{
  "userId" : "F104C4E8-3039-48B1-917C-D3227CAFEBCB",
  "promptId" : "62EE0688-F322-43EB-8C48-A78CBA0918A6",
  "responseText" : "Christmas, of course!"
}
```

#### Success Response:
200 OK
```json
{
  "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
  "promptId" : "273bbee2-5878-11ed-9b6a-0242ac120002",
  "userId" : "345ccff2-5878-44bc-5c3d-0242ac120002",
  "responseText" : "Christmas, of course!"
}
```

#### Error Response: 
400 Bad Request
```json
{
  "error" : true,
  "reason": "Value of type 'String' required for key 'responseText'."
}
```

#### Example

<img width="957" alt="Screen Shot 2022-11-08 at 3 07 44 PM" src="https://user-images.githubusercontent.com/80468156/200653656-922eefcd-602d-4397-bb3d-f5835d962917.png">

<img width="957" alt="Screen Shot 2022-11-08 at 3 08 08 PM" src="https://user-images.githubusercontent.com/80468156/200653675-b9d47198-f90d-4eaa-a981-6007f2a9f15f.png">

---

# Matches <a name="matches"></a>

---

# Settings <a name="settings"></a>

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
  "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
  "user_id" : "345ccff2-5878-44bc-5c3d-0242ac120002",
  "name" : "Jane",
  "birthdate" : "1998-04-23T18:25:43.511Z",
  "occupation" : "Teacher" ,
  "bio" : "Hey Everyone! I love the outdoors and my cats :)",
  "gender" : 1,
  "preference" : 0, 
  "min_age" : 25,
  "max_age" : 40, 
  "max_distance" : 50
}
```

#### Error Response: 
404 Not Found
```json
{
 "error" : "No profile found."
}
```

#### Example

---

### Get Photos by UserID <a name="getphotos"></a>

#### URL:
`/photos/:userID`

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
  "photos" : [
    {
      "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
      "user_id" : "345ccff2-5878-44bc-5c3d-0242ac120002",
      "photo" : "photo/url"
    }, 
    {
      "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
      "user_id" : "345ccff2-5878-44bc-5c3d-0242ac120002",
      "photo" : "photo/url"
    }
  ]
}
```

#### Error Response: 
404 Not Found
```json
{
 "error" : "No profile found."
}
```

#### Example

---

### Get Prompts by UserID <a name="getprompts"></a>

#### URL:
`/prompts/:userID`

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
   "prompts" : [
    {
      "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
      "prompt_id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
      "user_id" : "345ccff2-5878-44bc-5c3d-0242ac120002",
      "response_text" : "Christmas, of course!"
    },
    {
      "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
      "prompt_id" : "273bbee2-5878-11ed-9b6a-0242ac120003",
      "user_id" : "345ccff2-5878-44bc-5c3d-0242ac120002",
      "response_text" : "Bali! I want to see the elephants."
    }
  ]
}
```

#### Error Response: 
404 Not Found
```json
{
 "error" : "No profile found."
}
```

#### Example

---

