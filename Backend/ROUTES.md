# Wing API Endpoints 
  
1. [Login](#login)
   1. [Get User by Phone](#getuserphone) 
   2. [Get User by Email](#getuseremail) 
2. [Create User Account](#createuser)
   1. [Get Usernames](#getusernames) 
   2. [Create User](#createuser1) 
   3. [Create Profile](#createprofile) TODO
   4. [Add Photos](#addphotos) TODO
   5. [Get All Prompts](#getallprompts)
   6. [Add Prompt Response to User Account](#addpromptsuser)
3. [Match](#matches)  
   1. [Get Prospects] TODO
5. [Settings](#settings)
   1. [Edit User Account](#edituser) 
   2. [Get Profile by UserID](#getprofile) TODO
   3. [Edit Profile] TODO
   4. [Get Photos by UserID](#getphotos) TODO
   5. [Edit Photos] TODO
   6. [Get Prompts by UserID](#getprompts)
   7. [Get Prompt by ID](#getprompt) 
   8. [Edit Prompts] TODO
   9. [Delete Prompt Response](#deletepromptresponse)
   

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

<img width="1101" alt="Screen Shot 2022-11-08 at 5 39 57 PM" src="https://user-images.githubusercontent.com/80468156/200681577-07f57fc5-eaa2-4f6d-8792-185fbc53e156.png">


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
_Note: If the userID is invalid or no prompts have been answered, an empty array will be returned._    
200 OK  
```json
[
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
```

#### Error Response:    
_Note: this endpoint should not result in error._   
400 Bad Request      
```json
{
 "error" : "Endpoint does not exist. "
}
```

#### Example

<img width="1134" alt="Screen Shot 2022-11-09 at 1 20 20 PM" src="https://user-images.githubusercontent.com/80468156/200898682-8941281f-9bd5-4ece-a9db-3d3cb502965b.png">


<img width="1134" alt="Screen Shot 2022-11-09 at 1 20 06 PM" src="https://user-images.githubusercontent.com/80468156/200898630-84e437ef-d0f2-4307-81c0-335c95022ede.png">

---


### Get Prompt by ID <a name="getprompt"></a>

#### URL:
`/prompts/:promptId`

#### Method:
`GET`

#### URL Parameters:
###### :promptId 
UUID           
The promptID associated with the prompt you would like to retrieve

#### Success Response:
200 OK  
```json
{
   "promptText" : "Whats your favorite color?",
   "id" : "3F4BDDFA-6E65-4302-82D1-1E05724B7C8A"
}
```

#### Error Response: 
404 Not Found
```json
{
 "error" : true, 
 "reason" : "No prompt record found."
}
```

#### Example

<img width="1134" alt="Screen Shot 2022-11-09 at 1 07 48 PM" src="https://user-images.githubusercontent.com/80468156/200896081-d7f808b5-ba49-47a5-bf77-f456385bb05c.png">

<img width="1134" alt="Screen Shot 2022-11-09 at 1 07 57 PM" src="https://user-images.githubusercontent.com/80468156/200896096-a35d03c4-7d53-42ef-bec3-8444798f0c7d.png">

---

### Delete Prompt Response <a name="deletepromptresponse"></a>

#### URL:
`/promptResponse/:id`

#### Method:
`DELETE`

#### URL Parameters:
###### :id 
UUID           
The id associated with the prompt response record you would like to delete

#### Success Response:
202 Accepted  

No return body, record has been deleted. 

#### Error Response: 
400 Bad Request

No return body, this occurs when invalid UUID was supplied. 

#### Example

<img width="1134" alt="Screen Shot 2022-11-09 at 1 52 12 PM" src="https://user-images.githubusercontent.com/80468156/200905045-c1a7d615-a512-4128-bbcb-371839fdb481.png">

<img width="1134" alt="Screen Shot 2022-11-09 at 1 54 14 PM" src="https://user-images.githubusercontent.com/80468156/200905086-830d8574-c32a-4fe5-9600-cc68573e8d65.png">

---

