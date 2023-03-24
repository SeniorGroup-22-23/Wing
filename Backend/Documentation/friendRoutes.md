# Friend API Endpoints 
  

1. [Create Friendship](#createfriendship) 
2. [Edit Friendship](#editfriendship) 
1. [Get Friends](#getfriends) 
2. [Get Friend Requests](#getfriendrequests)
2. [Get Requested Friends](#getrequestedfriends)
---

### Create Friendship <a name="createfriendship"></a>

#### URL:
`/friend`

#### Method:
`POST`

#### Request Body:
_NOTE: Refer to Models package for status meanings._       
```json 
{
	"requesterId" : "70d0740c-05eb-4904-8773-5baf85b3e62b",
	"respondentId": "5c818867-f4c8-46e0-a125-15c16461ce39",
	"status" : 1 
}
```

#### Success Response:
200 OK
```json 
{
	"status": 2,
	"id": "DA577515-10EF-4AAE-877D-E0839816FDC1",
	"respondentId": "5C818867-F4C8-46E0-A125-15C16461CE39",
	"requesterId": "70D0740C-05EB-4904-8773-5BAF85B3E62B"
}
```

#### Error Response:     
400 Bad Request or 404 Not Found (if userId does not exist in users table)
```json
{
	"error": true,
	"reason": "No user record found with ID: 7318E3CF-624A-4646-97EF-2253FAE1BD5F."
}
```

#### Example

<img width="996" alt="Screen Shot 2022-12-08 at 4 15 41 PM" src="https://user-images.githubusercontent.com/80468156/206559117-5b2c4886-b5b0-4a83-bba1-ee467a00ec0b.png">

<img width="996" alt="Screen Shot 2022-12-08 at 4 16 30 PM" src="https://user-images.githubusercontent.com/80468156/206559147-5f2713d5-ef64-4ea4-b793-deb96f69c4d5.png">

<img width="1088" alt="Screenshot 2023-01-05 at 4 16 09 PM" src="https://user-images.githubusercontent.com/80468156/210872053-3f327def-d836-4a67-8ede-fc224873b816.png">

---

### Edit Friendship <a name="editfriendship"></a>

#### URL:
`/friend`

#### Method:
`PUT`

#### Request Body:
_NOTE: Edit is done based on friendship record ID ("id"). Only the status of the record will be updated - even if a different UUID is given for requester/respondent Id. Refer to Models package for status meanings._       
```json 
{
	"status": 1,
	"id": "F741C747-B292-4152-BAC8-F3A58A70DA4E",
	"respondentId": "E96E7808-67FB-4B5B-B18B-764532EB3B92",
	"requesterId": "5C818867-F4C8-46E0-A125-15C16461CE39"
}
```

#### Success Response:      
_NOTE: If status is set to 3 and record is found, that record will be deleted. 200 OK response means "Deleted Successfully"._       
200 OK 
```json
{
	"status": 1,
	"id": "F741C747-B292-4152-BAC8-F3A58A70DA4E",
	"respondentId": "E96E7808-67FB-4B5B-B18B-764532EB3B92",
	"requesterId": "5C818867-F4C8-46E0-A125-15C16461CE39"
}
```

#### Error Response:
_Note: No error will occur if invalid (not empty) id is provided - will still receive 200 OK message.       
400 Bad Request
```json
{
	"error": true,
	"reason": "Illegal nil ID."
}
```

#### Example

<img width="996" alt="Screen Shot 2022-12-08 at 4 21 23 PM" src="https://user-images.githubusercontent.com/80468156/206560045-782f1e34-436b-4c2d-a92e-b1a5d5713411.png">

<img width="996" alt="Screen Shot 2022-12-08 at 4 23 22 PM" src="https://user-images.githubusercontent.com/80468156/206560064-cfb257b3-0092-4a35-864f-53b4ea5ab185.png">

<img width="996" alt="Screenshot 2022-12-21 at 12 42 09 PM" src="https://user-images.githubusercontent.com/80468156/208958325-78e24624-2788-4aec-835d-c9244695f78c.png">

---

### Get Friends <a name="getfriends"></a>
Returns an array of profilePreview Ids corresponding to the current users friends. Follow this endpoint with calls to "Get Profile Preview by ID" to render and display friends.     

#### URL:   
`/friends/:userId`

#### Method:
`GET` 

#### URL Parameters:
###### :userId
UUID   
User ID of the user whos friends you would like to retrieve. 

#### Success Response:   
_Note: If no friends are found empty array is returned._   
200 OK
```json
[
	"38DB8EA1-8E57-4B8E-BB3D-84248FE888DF"
]
```

#### Error Response:  
404 Not Found (invalid UUID format)
```json
{
	"error": true,
	"reason": "Illegal nil ID."
}
```

#### Example    

<img width="1088" alt="Screenshot 2023-01-05 at 4 23 46 PM" src="https://user-images.githubusercontent.com/80468156/210873200-3cc3815b-7380-4af6-b075-a270cf8dca79.png">

<img width="1088" alt="Screenshot 2023-01-05 at 4 23 54 PM" src="https://user-images.githubusercontent.com/80468156/210873211-2c252b73-cee5-4219-9187-a6e366abf445.png">

<img width="1088" alt="Screenshot 2023-01-05 at 4 24 01 PM" src="https://user-images.githubusercontent.com/80468156/210873227-371d409c-4e09-45dd-a0a0-6f7b084edf26.png">

---

### Get Friend Requests <a name="getfriendrequests"></a>
Returns an array of Friendship objects. To render and display friend requests, follow this enpoint with calls to "Get Profile Preview by User Id", passing in the requester's userId.      

#### URL:   
`/friendRequests/:userId`

#### Method:
`GET` 

#### URL Parameters:
###### :userId
UUID   
User ID of the user whos friend requests you would like to retrieve (pending friend requests where userId == respondentId). 

#### Success Response:   
200 OK
```json
[
	{
		"status": 1,
		"id": "A27AEB2A-4E84-439F-8108-79A84A7FA7FD",
		"respondentId": "CF2AFC12-47C4-4DB5-860E-89890FBCB013",
		"requesterId": "DC730399-E21C-4BA4-8248-3E7A8753947B"
	},
	{
		"status": 1,
		"id": "A682E044-CFA2-45F9-A99E-79F54BDBCD44",
		"respondentId": "CF2AFC12-47C4-4DB5-860E-89890FBCB013",
		"requesterId": "DC730399-E21C-4BA4-8248-3E7A8753947B"
	}
]
```

#### Error Response:  
404 Not Found (invalid UUID format)
```json
{
	"error": true,
	"reason": "Illegal nil ID."
}
```

#### Example    

<img width="1088" alt="Screenshot 2023-01-05 at 4 28 56 PM" src="https://user-images.githubusercontent.com/80468156/210874297-427417a8-f3f2-4dc3-ad0f-81a7c6b03c4c.png">

<img width="1088" alt="Screenshot 2023-01-05 at 4 29 14 PM" src="https://user-images.githubusercontent.com/80468156/210874313-113adb6f-9a3c-4706-8c58-1d4e499ddf42.png">

---

### Get Requested Friends <a name="#getrequestedfriends"></a>
Returns an array of Friendship objects the user has sent. To render and display friend requests, follow this enpoint with calls to "Get Profile Preview by User Id", passing in the requester's userId.      

#### URL:   
`/requestedFriends/:userId`

#### Method:
`GET` 

#### URL Parameters:
###### :userId
UUID   
User ID of the user whos sent requests you would like to retrieve (pending friend requests where userId == resquesterId). 

#### Success Response:   
200 OK
```json
[
	{
		"status": 1,
		"id": "A27AEB2A-4E84-439F-8108-79A84A7FA7FD",
		"respondentId": "CF2AFC12-47C4-4DB5-860E-89890FBCB013",
		"requesterId": "DC730399-E21C-4BA4-8248-3E7A8753947B"
	},
	{
		"status": 1,
		"id": "A682E044-CFA2-45F9-A99E-79F54BDBCD44",
		"respondentId": "CF2AFC12-47C4-4DB5-860E-89890FBCB013",
		"requesterId": "DC730399-E21C-4BA4-8248-3E7A8753947B"
	}
]
```

#### Error Response:  
404 Not Found (invalid UUID format)
```json
{
	"error": true,
	"reason": "Illegal nil ID."
}
```

#### Example    

//TODO:

---
