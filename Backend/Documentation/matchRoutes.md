# Match API Endpoints 

1. [Create Swipe Record](#createSwipe)

---

### Create Swipe Record <a name="createSwipe"></a>      
TODO.   
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
