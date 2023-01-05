# Profile Preview API Endpoints 
  

1. [Create Profile Preview](#createpreview) 
2. [Edit Profile Preview](#editpreview) 
3. [Get Profile Preview by ID](#getid)
4. [Get Profile Preview by Username](#getusername)
5. [Get Profile Preview by UserID](#getuserid)

---

### Create Profile Preview<a name="createpreview"></a>

#### URL:
`/profilePreview`

#### Method:
`POST`

#### Request Body:
_NOTE: The primary photo must be encoded in base64. Right now this is done with a function in insomnia, will change. Contact Allie or Courtney for more info._   
```json 
{
	"userId": "0206D2A4-5450-457C-BA71-71F9D90E8B3B",
	"username": "BobtheBuilder",
	"name": "Bobby",
	"primaryPhoto": "{% base64 'encode', 'normal', 'TestPhoto' %}"
}
```

#### Success Response:
200 OK
```json 
{
	"username": "BobtheBuilder",
	"id": "C9ABB634-8878-43CC-814E-9BCAC21F0517",
	"primaryPhoto": "VGVzdFBob3Rv",
	"name": "Bobby",
	"userId": "0206D2A4-5450-457C-BA71-71F9D90E8B3B"
}
```

#### Error Response: 
404 Not Found (not user found with given userId) or 400 Bad Request (some json missing)
```json
{
	"error": true,
	"reason": "No user record found with ID: 0206D2A4-5450-457C-BA71-71F9D90E8B3C."
}
```

#### Example
<img width="999" alt="Screenshot 2023-01-04 at 4 29 07 PM" src="https://user-images.githubusercontent.com/80468156/210644606-cb2501de-157a-429c-aead-5ef30af682bd.png">

<img width="999" alt="Screenshot 2023-01-04 at 4 29 23 PM" src="https://user-images.githubusercontent.com/80468156/210644619-1c234f88-75e0-42f1-9308-31e33a219e67.png">

<img width="999" alt="Screenshot 2023-01-04 at 4 31 39 PM" src="https://user-images.githubusercontent.com/80468156/210644630-eb8314a0-f82f-47d9-bcf8-ec4d5b5dc939.png">


---

### Edit Profile Preview<a name="editpreview"></a>

#### URL:
`/profilePreview`

#### Method:
`PUT`

#### Request Body:
_NOTE: Full model must be provided._        
```json 
{
	"username": "seanBean",
	"id": "A2E1DFCC-E4BB-4477-A8B7-49F8D467F91F",
	"primaryPhoto": "VGVzdFBob3Rv",
	"name": "Seany",
	"userId": "E7237406-2A79-4D0D-A4D5-805E7CF57575"
}
```

#### Success Response:
_NOTE: If no profile preview record exists for the provided ID, 200 OK response but no record updated (ie no consequence). Only name and primary photo can be updated._         
200 OK 
```json
{
	"username": "seanBean",
	"id": "A2E1DFCC-E4BB-4477-A8B7-49F8D467F91F",
	"primaryPhoto": "VGVzdFBob3Rv",
	"name": "Seany",
	"userId": "E7237406-2A79-4D0D-A4D5-805E7CF57575"
}
```
#### Error Response:
400 Bad Request - Will occur if some of the json is missing or invalid UUIDs (inproper form) are provided.
```json
{
	"error": true,
	"reason": "Value of type 'String' required for key 'name'."
}
```

#### Example

<img width="999" alt="Screenshot 2023-01-04 at 4 39 28 PM" src="https://user-images.githubusercontent.com/80468156/210645664-ff8e9994-dce9-4551-a09f-0b2d61fdfd70.png">

<img width="999" alt="Screenshot 2023-01-04 at 4 37 53 PM" src="https://user-images.githubusercontent.com/80468156/210645542-cbe81e63-ff99-4999-a787-e40c2be9ddd1.png">

---

### Get Profile Preview by ID<a name="#getid"></a>

#### URL:
`/profilePreview/id/:id`

#### Method:
`GET`

#### URL Parameters:
##### :id
UUID        
The ID of the profile preview you would like to retreive. 

#### Success Response:
200 OK
```json 
{
	"username": "JaneDoe",
	"id": "105BCFF7-E520-4C32-8DC6-42453F1C4B7D",
	"primaryPhoto": "VGVzdFBob3Rv",
	"userId": "DC730399-E21C-4BA4-8248-3E7A8753947B",
	"name": "Jane"
}
```

#### Error Response: 
404 Not Found (not user found with given userId) or 400 Bad Request (invalid UUID form)
```json
{
	"error": true,
	"reason": "No Profile Preview record found with ID: 0206D2A4-5450-457C-BA71-71F9D90E8B3B."
}
```

#### Example

<img width="1088" alt="Screenshot 2023-01-05 at 4 09 35 PM" src="https://user-images.githubusercontent.com/80468156/210870839-868031c7-633c-4075-956f-855705e6d59a.png">

<img width="1088" alt="Screenshot 2023-01-05 at 4 09 23 PM" src="https://user-images.githubusercontent.com/80468156/210870850-a1a824b5-06f9-4686-a108-246407e14522.png">

---

### Get Profile Preview by Username<a name="#getusername"></a>

#### URL:
`/profilePreview/username/:username`

#### Method:
`GET`

#### URL Parameters:
##### :username
String        
Username on the profile preview you would like to retrieve. 

#### Success Response:
200 OK
```json 
{
	"username": "JaneDoe",
	"id": "105BCFF7-E520-4C32-8DC6-42453F1C4B7D",
	"primaryPhoto": "VGVzdFBob3Rv",
	"name": "Jane",
	"userId": "DC730399-E21C-4BA4-8248-3E7A8753947B"
}
```

#### Error Response: 
404 Not Found 
```json
{
	"error": true,
	"reason": "No user record found."
}
```

#### Example

<img width="1088" alt="Screenshot 2023-01-05 at 4 10 32 PM" src="https://user-images.githubusercontent.com/80468156/210870998-f024b4ce-bc4b-4b66-96f4-e2a7485e4a89.png">

<img width="1088" alt="Screenshot 2023-01-05 at 4 10 40 PM" src="https://user-images.githubusercontent.com/80468156/210871015-b6ea4b0b-45a9-40f1-984d-021cf0c119fb.png">


---

### Get Profile Preview by UserID<a name="#getid"></a>

#### URL:
`/profilePreview/userId/:userid`

#### Method:
`GET`

#### URL Parameters:
##### :userid
UUID        
The ID of the user whose profile preview you would like to retreive. 

#### Success Response:
200 OK
```json 
{
	"username": "JaneDoe",
	"id": "105BCFF7-E520-4C32-8DC6-42453F1C4B7D",
	"primaryPhoto": "VGVzdFBob3Rv",
	"name": "Jane",
	"userId": "DC730399-E21C-4BA4-8248-3E7A8753947B"
}
```

#### Error Response: 
404 Not Found (not user found with given userId) or 400 Bad Request (invalid UUID form)
```json
{
	"error": true,
	"reason": "No Profile Preview record found with ID: DC730399-E21C-4BA4-8248-3E7A8753947D."
}
```

#### Example

<img width="1088" alt="Screenshot 2023-01-05 at 4 11 21 PM" src="https://user-images.githubusercontent.com/80468156/210871205-1eb6b73e-3e77-48fa-b515-b42c329635a7.png">

<img width="1088" alt="Screenshot 2023-01-05 at 4 11 31 PM" src="https://user-images.githubusercontent.com/80468156/210871218-9ad127a9-0e34-434f-88ae-b70f84a28fc2.png">

