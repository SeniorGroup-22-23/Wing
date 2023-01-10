# Wing API Endpoints 
  

1. [Create Wing](#createwing) 
2. [Get Wings](#getwings)

---

### Create Wing <a name="createwing"></a>

#### URL:
`/wing`

#### Method:
`POST`

#### Request Body:
_NOTE: Refer to Models package for status meanings._       
```json 
{
	"senderId": "78887cd7-43cc-492e-8165-3803642256e8",
	"recipientId": "cf2afc12-47c4-4db5-860e-89890fbcb013",
	"prospectId": "dc730399-e21c-4ba4-8248-3e7a8753947b",
	"status": 2
}
```

#### Success Response:
200 OK
```json 
{
	"recipientId": "CF2AFC12-47C4-4DB5-860E-89890FBCB013",
	"id": "4C7E3064-487A-46AF-86E3-A16CA31FDC95",
	"status": 2,
	"prospectId": "DC730399-E21C-4BA4-8248-3E7A8753947B",
	"senderId": "78887CD7-43CC-492E-8165-3803642256E8"
}
```

#### Error Response:     
400 Bad Request (if some json is missing) or 404 Not Found (if userId does not exist in users table)
```json
{
	"error": true,
	"reason": "No user record found with ID: 7318E3CF-624A-4646-97EF-2253FAE1BD5F."
}
```

#### Example

<img width="974" alt="Screenshot 2023-01-10 at 6 19 49 PM" src="https://user-images.githubusercontent.com/80468156/211681531-a8f7689e-222f-48cc-bf3a-4cccfedebb4a.png">

<img width="974" alt="Screenshot 2023-01-10 at 6 19 59 PM" src="https://user-images.githubusercontent.com/80468156/211681573-99212db3-ea47-459b-b523-884e4ffe8d6a.png">


<img width="1086" alt="Screenshot 2023-01-10 at 6 20 10 PM" src="https://user-images.githubusercontent.com/80468156/211681583-9541930d-c1b7-4a52-a7b9-f307a36a3802.png">

---

### Get Wings <a name="getwings"></a>

#### URL:
`/wings/:userId`

#### Method:
`GET`

#### Parameters:
##### userId
UUID 
The id of the User whose pending Wings you would like to recieve. (where recipientId == UserId)


#### Success Response:
_Note: If not wings are associated with given id, empty array is returned._       
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
404 Not Found (Invalid UUID format)
```json
{
	"error": true,
	"reason": "Illegal nil ID."
}
```

#### Example

<img width="1289" alt="Screenshot 2023-01-10 at 6 38 15 PM" src="https://user-images.githubusercontent.com/80468156/211682228-24dc7255-81d3-4f9e-ae5c-aafbf629cc9f.png">

<img width="1289" alt="Screenshot 2023-01-10 at 6 38 22 PM" src="https://user-images.githubusercontent.com/80468156/211682238-c68b6ac3-95fb-4514-8ded-f138309253a4.png">


<img width="1289" alt="Screenshot 2023-01-10 at 6 38 28 PM" src="https://user-images.githubusercontent.com/80468156/211682250-5f230471-777f-4414-96f0-4b671554a494.png">


---
