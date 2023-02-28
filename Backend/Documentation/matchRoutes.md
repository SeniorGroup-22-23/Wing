# Match API Endpoints 

1. [Post Swipe](#createswipe)
2. [Get Prospects](#getprospects)
3. [Unmatch](#unmatch)
4. [Check for Existing Wing Like](#checkwing)

---

### Post Swipe <a name="createswipe"></a>     

![Post Swipe Workflow](https://user-images.githubusercontent.com/80468156/210401602-e45b640a-dd6d-4acd-976c-13e569ebe5ef.jpeg)

#### URL:  
`/swipe`

#### Method: 
`POST`

#### Request Body:       
_NOTE: Date and ID are auto populated._      
```json
{
	"swiperId" : "331C5812-F123-457C-AF69-B24E1D1AB971",
	"prospectId": "50470A5A-D917-4081-AD6D-5BBDA83A3392",
	"type": 1
}
```

#### Success Response:
##### Match Found:      
200 OK
```json
{
	true
}
```
##### No Match Found:     
200 OK
```json
{
	false
}
```

#### Error Response:    
_Note: This ednpoint will result in error if one of the users does not exist in user table, if request body is incomplete, or if there are connectivity issues with database (500 error)._

400 Bad Request
```json
{
	"error": true,
	"reason": "Value of type 'Int16' required for key 'type'."
}
```

#### Example

<img width="1115" alt="Screenshot 2023-01-03 at 12 49 42 PM" src="https://user-images.githubusercontent.com/80468156/210402902-7edcafdb-31ec-4aca-b7c4-e76f948c1721.png">

<img width="1115" alt="Screenshot 2023-01-03 at 12 50 05 PM" src="https://user-images.githubusercontent.com/80468156/210402915-e1c9257e-a3a5-4d8a-9328-9f4f239099cc.png">

<img width="1209" alt="Screenshot 2023-01-03 at 12 50 32 PM" src="https://user-images.githubusercontent.com/80468156/210402926-c5e54e0d-a591-4dad-a44c-f7abea708396.png">

<img width="1209" alt="Screenshot 2023-01-03 at 12 50 54 PM" src="https://user-images.githubusercontent.com/80468156/210402939-3cb10c7c-7f8c-4416-b9d0-7068bfaa50e5.png">

---

### Get Prospects <a name="getprospects"></a>        
This endpoint returns an array of profile IDs, each profile ID corresponds to a prospect for the user. Given the profileID of a prospect, the prospects profile (via profile ID), prompts (via user ID), and photos (via user ID) can be queried and rendered for display.   

#### URL:  
`/prospects/:userId`

#### Method: 
`GET`

#### Parameters: 
###### :userId
The ID of the user you would like to retrieve prospects for 

#### Success Response:      
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

### Unmatch <a name="unmatch"></a>      
This endpoint deletes any match record that exists between the two provided users.       
#### URL:  
`/unmatch/:id1/:id2`

#### Method: 
`POST`

#### Parameters: 
###### :userId1
The id of the first user invloved in the unmatch. 

###### :userId2
The id of the second user invloved in the unmatch. 


#### Success Response:         
_Note: If no match record found, no error will be returned._        
202 Accepted

#### Error Response: 
_Note: If invalid ID is provided for either parameter error will occur._      
404 Not Found
```json
{
        "error": true,
	"reason": "Illegal nil ID."
}
```

#### Example
<img width="1209" alt="Screenshot 2023-01-03 at 1 04 32 PM" src="https://user-images.githubusercontent.com/80468156/210405782-02966293-a7a6-41ac-9287-50ac6d6c0297.png">


<img width="1183" alt="Screenshot 2023-01-03 at 1 07 13 PM" src="https://user-images.githubusercontent.com/80468156/210405790-5da02dfb-6141-406d-abcc-8cc073f5b7ce.png">


---

### Check for Wing Like <a name="checkwing"></a>      
Returns true if a swipe record exists where given swiper id has liked given prospect id via wing (swipe type 3). Returns false otherwise. 

#### URL:  
`/wing/like/:swiperId/:prospectId`

#### Method: 
`GET`

#### Parameters: 
###### :swiperId
The id of the user who may have previously "wing liked" the current user (in this use case a prospect).

###### :prospectId
The id of the user who may have previously been liked (in this use case the ID of the user currently using the app). 


#### Success Response:
_Note: Endpoint will return false if no swipe record with type 3 exists._       
```json
true
```

#### Error Response: 
_Note: If invalid ID is provided for either parameter error will occur._      
404 Not Found
```json
{
        "error": true,
	"reason": "Illegal nil ID."
}
```

#### Example

<img width="1464" alt="Screenshot 2023-02-28 at 9 55 04 AM" src="https://user-images.githubusercontent.com/80468156/221876997-d62b19fe-fd4e-4fb6-a246-19297bcd9b1f.png">

<img width="1464" alt="Screenshot 2023-02-28 at 9 55 18 AM" src="https://user-images.githubusercontent.com/80468156/221877020-6ff65ba6-dd0e-44fd-8f58-1726bfb957a8.png">

<img width="1464" alt="Screenshot 2023-02-28 at 9 55 26 AM" src="https://user-images.githubusercontent.com/80468156/221877054-3d5395ad-0260-4e67-a184-f4cd2910b172.png">

---
