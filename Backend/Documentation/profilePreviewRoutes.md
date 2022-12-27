# Profile Preview API Endpoints 
  

1. [Create Profile Preview](#createPreview) 
2. [Edit Profile Preview](#editPreview) 

---

### Create Profile Preview<a name="createPreview"></a>

#### URL:
`/profilePreview`

#### Method:
`POST`

#### Request Body:
```json 
{
	"userId": "50470A5A-D917-4081-AD6D-5BBDA83A3392",
	"username": "otherUser",
	"name": "otheruser",
	"primaryPhoto": null
}
```

#### Success Response:
200 OK
```json 
{
  "id": "",
	"userId": "50470A5A-D917-4081-AD6D-5BBDA83A3392",
	"username": "otherUser",
	"name": "otheruser",
	"primaryPhoto": null
}
```

#### Error Response: 
400 Bad Request (if some of the JSON is missing)
```json
{
	"error": true,

}
```

#### Example


---

### Edit Profile Preview<a name="editPreview"></a>

#### URL:
`/profilePreview`

#### Method:
`PUT`


#### Request Body:
```json 
{
	"userId": "50470A5A-D917-4081-AD6D-5BBDA83A3392",
	"username": "otherUser",
	"name": "otheruser",
	"primaryPhoto": null
}
```

#### Success Response:
_NOTE: If no profile preview record exists for the provided ID, 200 OK response but no record updated. Only name and primary photo can be updated._         
200 OK 
```json

```
#### Error Response:
400 Bad Request 
```json
{

}
```

#### Example

---

