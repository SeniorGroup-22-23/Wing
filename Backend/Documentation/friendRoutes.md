# Friend API Endpoints 
  

1. [Create Friendship](#createfriendship) 
2. [Edit Friendship](#editfriendship) 
1. [Get Friends](#getfriends) 
2. [Get Friend Requests](#getfriendrequests)
3. [Get Friend by Username](#getfriendusername)

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
_NOTE: There is no FK constraint on Friends table - UUIDs of users that do not exist will still result in 200 OK._      
400 Bad Request
```json
{
	"error": true,
	"reason": "Value of type 'Int16' required for key 'status'."
}
```

#### Example

<img width="996" alt="Screen Shot 2022-12-08 at 4 15 41 PM" src="https://user-images.githubusercontent.com/80468156/206559117-5b2c4886-b5b0-4a83-bba1-ee467a00ec0b.png">

<img width="996" alt="Screen Shot 2022-12-08 at 4 16 30 PM" src="https://user-images.githubusercontent.com/80468156/206559147-5f2713d5-ef64-4ea4-b793-deb96f69c4d5.png">

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

#### URL:   
`/friends/:userId`

#### Method:
`GET` 

#### URL Parameters:
###### :userId
UUID   
User ID of the user whos friends you would like to retrieve. 

#### Success Response:       
TODO

#### Error Response:            
TODO

#### Example    
TODO

---

### Get Friend Requests <a name="getfriendrequests"></a>

#### URL:   
`/friendRequests/:userId`

#### Method:
`GET` 

#### URL Parameters:
###### :userId
UUID   
User ID of the user whos friend requests you would like to retrieve (pending friend requests where userId == respondentId). 

#### Success Response:       
TODO

#### Error Response:            
TODO

#### Example    
TODO

---

### Get Friend by Username <a name="getfriendusername"></a>

#### URL:   
`/friend/:username`

#### Method:
`GET` 

#### URL Parameters:
###### :username
String   
Username (exact match only) of the friend you would like to retrieve. 

#### Success Response:       
TODO

#### Error Response:            
TODO

#### Example    
TODO

---
