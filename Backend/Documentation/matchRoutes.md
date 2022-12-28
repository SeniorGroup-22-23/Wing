# Match API Endpoints 

1. [Create Swipe Record](#createswipe)
2. [Get Prospects](#getprospects)

---

### Create Swipe Record <a name="createswipe"></a>        
#### URL:  
`/swipe`

#### Method: 
`POST`

#### Request Body: 
```json
{
	"swiperId" : "331C5812-F123-457C-AF69-B24E1D1AB971",
	"prospectId": "50470A5A-D917-4081-AD6D-5BBDA83A3392",
	"type": 1
}
```

#### Success Response:
200 OK
```json
{
	"id": "96D59EBA-A1B5-423F-81CB-2C3CB8D380E5",
	"swiperId": "331C5812-F123-457C-AF69-B24E1D1AB971",
	"type": 1,
	"prospectId": "50470A5A-D917-4081-AD6D-5BBDA83A3392",
	"createdAt": "2022-12-22T19:05:39Z"
}
```

#### Error Response:            
400 Bad Request
```json
{
	"error": true,
	"reason": "Value of type 'Int16' required for key 'type'."
}
```

#### Example

<img width="996" alt="Screenshot 2022-12-22 at 3 07 33 PM" src="https://user-images.githubusercontent.com/80468156/209209004-2b669dc2-bafe-44eb-881e-c0abaa1be1f6.png">

<img width="943" alt="Screenshot 2022-12-22 at 3 08 50 PM" src="https://user-images.githubusercontent.com/80468156/209209015-252173a6-c208-4400-9518-4769100870a1.png">

---

### Get Prospects <a name="getprospects"></a>        
#### URL:  
`/prospects/:userId`

#### Method: 
`GET`

#### Parameters: 
###### :userId
The ID of the user you would like to retrieve prospects for 

#### Success Response: 
This endpoint returns an array of profile IDs, each profile ID corresponds to a prospect for the user.      
_Note: If no prospects are found an empty array will be returned._        
200 OK
```json
[
	"26CB9351-40D0-4805-973B-CA3A7A49278D"
]
```

#### Error Response: 
_Note: If invalid ID is provided or there is no profile associated userId 404 Error will be returned._      
404 Not Found
```json
{
        "error": true,
	"reason": "Illegal nil ID."
}
```

#### Example

<img width="1115" alt="Screenshot 2022-12-28 at 7 39 36 PM" src="https://user-images.githubusercontent.com/80468156/209885235-aa2a4c36-a60f-44e1-be64-b3ae9e4b0fb6.png">


<img width="1115" alt="Screenshot 2022-12-28 at 7 35 30 PM" src="https://user-images.githubusercontent.com/80468156/209885080-901a8e20-5eb9-45a7-80ad-f42a62800419.png">

---
