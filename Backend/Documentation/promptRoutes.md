# Prompt API Endpoints 

1. [Get Prompts by UserID](#getprompts)
2. [Get Prompt by ID](#getprompt) 
3. [Edit Prompt Response](#editpromptresponse)
4. [Get All Prompts](#getallprompts)
5. [Add Prompt Response to User Account](#addpromptsuser)
6. [Delete Prompt Response](#deletepromptresponse)
7. [Post Prompt](#postpromptinternal)

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


### Edit Prompt Response <a name="editpromptresponse"></a>

#### URL:
`/promptResponse`

#### Method:
`PUT`       
_Note: Put requests require the entire object body to be passed in. If there is a prompt response record that matches the given id, that record will be updated._


#### Request Body:  
The following request body will update the prompt response record with the new response text.     

```json
{
  "id": "B709FC3D-1EED-4FF1-BDC3-D2FB91C8D1C3",
  "userId": "695C8249-10B1-4CD3-BE98-E1400B1823B3",
  "promptId" : "0DD6065E-A2E9-4BF8-8C34-12F9CE546F18",
  "responseText": "Invisibility."
}

```


#### Success Response:
200 OK  
```json
{
  "id": "B709FC3D-1EED-4FF1-BDC3-D2FB91C8D1C3",
  "userId": "695C8249-10B1-4CD3-BE98-E1400B1823B3",
  "promptId" : "0DD6065E-A2E9-4BF8-8C34-12F9CE546F18",
  "responseText": "Invisibility."
}
```

#### Error Response: 
400 Bad Request       
_Note: This will occur when a field is missing, or invalid UUID is given_
```json
{
 "error" : true, 
 "reason" : "Invalid nil ID."
}
```

#### Example

<img width="1178" alt="Screen Shot 2022-11-24 at 12 01 42 PM" src="https://user-images.githubusercontent.com/80468156/203827336-609c1191-3ef5-4db7-ab74-8d86b414cf18.png">

<img width="1178" alt="Screen Shot 2022-11-24 at 12 01 49 PM" src="https://user-images.githubusercontent.com/80468156/203827362-f2e59995-e781-4630-a598-f2ee2c4ffe89.png">

<img width="1334" alt="Screen Shot 2022-11-24 at 12 02 08 PM" src="https://user-images.githubusercontent.com/80468156/203827394-50969f32-95f5-420b-a60c-19185fa24011.png">

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

<img width="1158" alt="Screen Shot 2022-11-24 at 10 25 14 AM" src="https://user-images.githubusercontent.com/80468156/203807632-8734b230-02eb-4e39-8966-89ec2433e001.png">

<img width="1158" alt="Screen Shot 2022-11-24 at 10 25 25 AM" src="https://user-images.githubusercontent.com/80468156/203807652-6cfb69b5-3de4-4770-a370-7a85e137ec47.png">


---

### Post Prompt <a name="postpromptinternal"></a>

#### URL:
`/prompts`

#### Method:
`POST`

#### Body: 
``` json
{
	"promptText" : "What is your fav color?"
}
```

#### Success Response:
200 OK 
``` json
{
	"id": "A8BD93F9-A385-452C-8DC4-B0FCD05023E5",
	"promptText": "What is your fav color?"
}
```

#### Error Response: 
400 Bad Request
``` json
{
	"error": true,
	"reason": "Value of type 'String' required for key 'promptText'."
}
```

#### Example

<img width="1158" alt="Screen Shot 2022-11-23 at 10 18 19 AM" src="https://user-images.githubusercontent.com/80468156/203569463-c5c12313-e62e-4361-8783-74e2594f75e8.png">

<img width="1158" alt="Screen Shot 2022-11-23 at 10 20 04 AM" src="https://user-images.githubusercontent.com/80468156/203569858-5466141b-6384-49bd-b39c-42ea409ada62.png">

---
