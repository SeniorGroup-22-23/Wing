# Wing API Endpoints 
  
1. [Login](#login)
   1. [Get User by Phone](#getuserphone)
   2. [Get User by Email](#getuseremail)
   3. [Get Profile by UserID](#getprofile)
   4. [Get Photos by UserID](#getphotos)
   5. [Get Prompts by UserID](#getprompts)
2. [Create User Account](#createuser)
   1. [Get Usernames]
   2. [Create User](#createuser1)
   3. [Create Profile](#createprofile)
   4. [Add Photos](#addphotos)
   5. [Add Prompts](#addprompts)
3. [Matches](#matches)  
   1. [](#)
   2. [](#)
   3. [](#) 

---

# Login <a name="login"></a>

---

### Get User by Phone <a name="getuserphone"></a>

#### URL:
`/user/:phone/:password`

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
  "error" : "No user record found."
}
```

#### Example


---

### Get User by Email <a name="getuseremail"></a>

#### URL:
`/user/:email/:password`

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
  "error" : "No user record found."
}
```

#### Example

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
  "first_name" : "Jane",
  "birthdate" : "1998-04-23T18:25:43.511Z",
  "occupation" : "Teacher" ,
  "bio" : "Hey Everyone! I love the outdoors and my cats :)"
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

# Create User Account  <a name="createuser"></a>

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
  "first_name" : "Jane",
  "birthdate" : "1998-04-23T18:25:43.511Z",
  "occupation" : "Teacher" ,
  "bio" : "Hey Everyone! I love the outdoors and my cats :)"
}
```

#### Success Response:
201 Created
```json
{
  "id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
  "user_id" : "345ccff2-5878-44bc-5c3d-0242ac120002",
  "first_name" : "Jane",
  "birthdate" : "1998-04-23T18:25:43.511Z",
  "occupation" : "Teacher" ,
  "bio" : "Hey Everyone! I love the outdoors and my cats :)"
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
`photos/:userID`

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


### Add Prompts <a name="addprompts"></a>

#### URL:  
`prompts/:userID`

#### Method: 
`POST`

#### URL Parameters:  
###### :userID
UUID           
The userID associated with the profile you would like to add prompts too

#### Request Body:  
```json
{
  "prompts" : [
    {
      "prompt_id" : "273bbee2-5878-11ed-9b6a-0242ac120002",
      "response_text" : "Christmas, of course!"
    },
    {
      "prompt_id" : "273bbee2-5878-11ed-9b6a-0242ac120003",
      "response_text" : "Bali! I want to see the elephants."
    },
  ]
}
```

#### Success Response:
201 Created
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

# Matches <a name="matches"></a>

