# Wing API Enpoints 

Do a Table of Contents (Maybe share meta data from the below command).   

To see routes currently supported by Wing Server run:      
`swift run Run routes`     

Note: Validation is done in front end to quickly give input queues to user.   

---

# Login

---

### Get User by Phone

#### URL:
`/user/:phone/:password`

#### Method:
`GET`

#### URL Parameters:
###### :phone   
The phone number the user is trying to log in with  

###### :password     
The password the user is trying to log in with

#### Success Response:

#### Error Response: 

#### Example

---

### Get User by Email

#### URL:
`/user/:email/:password`

#### Method:
`GET`

#### URL Parameters:
###### :email
The email the user is trying to log in with  

###### :password     
The password the user is trying to log in with

#### Success Response:

#### Error Response: 

#### Example

---

# Create Account

---

### Create User

#### URL:   
`/user`

#### Method:
`POST` 

#### Request Body:    
TODO: user struct (JSON) 

#### Success Response:

#### Error Response: 

#### Example    

---

### Create Profile

#### URL:  
`/profile/:userID`

#### Method:
`POST`

#### URL Parameters: 
###### :userID
UUID of user account to which the profile belongs

#### Request Body:   
profile struct (JSON)

#### Success Response:

#### Error Response: 

#### Example  

---

### Add Photos

#### URL:  
`profile/photos/:profileID`

#### Method: 
`POST`

#### URL Parameters:  
###### :profileID
UUID of profile account to which the photos belongs

#### Request Body:  
multipart files

#### Success Response:

#### Error Response: 

#### Example

---


