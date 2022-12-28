# Block API Endpoints 
  

1. [Block User](#block) 
2. [Get Block Records by BlockedById (User ID)](#getblock) 
1. [Edit Block Record](#editblock) 

---

### Block User <a name="block"></a>

#### URL:
`/block`

#### Method:
`POST`

#### Request Body:
```json 
{
	"blockedUserId" : "e96e7808-67fb-4b5b-b18b-764532eb3b92",
	"blockedById": "9ccd8fc6-bf68-4054-85d3-d8a72f66342a",
	"reported" : false,
	"issue" : 0
}
```

#### Success Response:
200 OK
```json 
{
	"blockedUserId": "E96E7808-67FB-4B5B-B18B-764532EB3B92",
	"id": "ED3AECB5-4444-4D0D-A6DB-D423A12965BB",
	"reported": false,
	"blockedById": "9CCD8FC6-BF68-4054-85D3-D8A72F66342A",
	"issue": 0
}
```

#### Error Response: 
404 Not Found (or 400 Bad Request if some of the JSON is missing)
```json
{
	"error": true,
	"reason": "No user record found with ID: E96E7808-67FB-4B5B-B18B-764532EB3B93."
}
```

#### Example

<img width="1028" alt="Screen Shot 2022-11-30 at 4 32 27 PM" src="https://user-images.githubusercontent.com/80468156/204902365-754feea1-8bd3-461c-9507-fc2d5e1ff3f1.png">

<img width="1028" alt="Screen Shot 2022-11-30 at 4 34 11 PM" src="https://user-images.githubusercontent.com/80468156/204902376-651b2f5f-f67b-4e21-9400-e102e073c4f6.png">

<img width="1028" alt="Screen Shot 2022-11-30 at 4 34 58 PM" src="https://user-images.githubusercontent.com/80468156/204902504-2cf21497-70d5-4db4-8e1f-c86de6bc3bc5.png">

---

### Get Blocked Records by BlockedById <a name="getblock"></a>

#### URL:
`/block/:blockedById`

#### Method:
`GET`

#### URL Parameters:
###### :blockedById
UUID   
User ID of the user who created the blocked record, user must exist in the database.  


#### Success Response:
_NOTE: If no blocked records exist for the provided ID, an empty array will be returned. If a valdi UUID is provided but no user record exists - an empty array will also be returned._         
200 OK 
```json
[
	{
		"blockedUserId": "70D0740C-05EB-4904-8773-5BAF85B3E62B",
		"id": "8AC63F6D-665E-4FFB-A97B-C2627B2C15EB",
		"reported": false,
		"issue": 0,
		"blockedById": "695C8249-10B1-4CD3-BE98-E1400B1823B3"
	},
	{
		"blockedUserId": "5C818867-F4C8-46E0-A125-15C16461CE39",
		"id": "C732CB01-013B-4BF4-AA4A-54FEC0292ED7",
		"reported": false,
		"issue": 0,
		"blockedById": "695C8249-10B1-4CD3-BE98-E1400B1823B3"
	},
	{
		"blockedUserId": "70D0740C-05EB-4904-8773-5BAF85B3E62B",
		"id": "D22DDF21-2EB0-4C92-9DF4-F45097DE9175",
		"reported": false,
		"issue": 0,
		"blockedById": "695C8249-10B1-4CD3-BE98-E1400B1823B3"
	},
	{
		"blockedUserId": "70D0740C-05EB-4904-8773-5BAF85B3E62B",
		"id": "8B0CEE8E-B09F-48E9-A3DA-8572F83DC9F5",
		"reported": false,
		"issue": 0,
		"blockedById": "695C8249-10B1-4CD3-BE98-E1400B1823B3"
	}
]
```
#### Error Response:
404 Not Found (illegal ID provided)
```json
{
	"error": true,
	"reason": "Illegal nil ID."
}
```

#### Example

<img width="1201" alt="Screen Shot 2022-11-30 at 4 37 51 PM" src="https://user-images.githubusercontent.com/80468156/204903564-77cb4fee-1869-4e5b-8036-216fc338920b.png">

<img width="1028" alt="Screen Shot 2022-11-30 at 4 37 25 PM" src="https://user-images.githubusercontent.com/80468156/204903585-e00642e3-21a4-48d5-bbd9-e57502fcd73e.png">


<img width="1201" alt="Screen Shot 2022-11-30 at 4 40 13 PM" src="https://user-images.githubusercontent.com/80468156/204903597-92718f0b-bc5e-49a3-80a2-9dbb508f3b47.png">


---

### Edit Block Record <a name="editblock"></a>

#### URL:   
`/block`

#### Method:
`PUT` 

#### Request Body:  
_Note: Put request requires entire model body. The only parameter you can update in this requets is the reported param._   
```json
{
	"id" : "8ac63f6d-665e-4ffb-a97b-c2627b2c15eb",
	"blockedUserId" : "70d0740c-05eb-4904-8773-5baf85b3e62b",
	"blockedById": "695c8249-10b1-4cd3-be98-e1400b1823b3",
	"reported" : true,
	"issue" : 0
}
```   

#### Success Response:       
200 OK
```json
{
	"id": "8AC63F6D-665E-4FFB-A97B-C2627B2C15EB",
	"blockedUserId": "70D0740C-05EB-4904-8773-5BAF85B3E62B",
	"reported": true,
	"issue": 0,
	"blockedById": "695C8249-10B1-4CD3-BE98-E1400B1823B3"
}
```

#### Error Response:            
404 Bad Request
```json
{
	"error": true,
	"reason": "Value of type 'Int16' required for key 'issue'."
}
```

#### Example    

<img width="996" alt="Screen Shot 2022-11-30 at 4 43 23 PM" src="https://user-images.githubusercontent.com/80468156/204904621-9f7eea3c-f292-4fa3-b8d1-d335438cdc22.png">

<img width="996" alt="Screen Shot 2022-11-30 at 4 45 43 PM" src="https://user-images.githubusercontent.com/80468156/204904634-899be0c2-20aa-4f02-87aa-976d0e1e697f.png">

---
