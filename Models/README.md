# Models

This package contains descriptions for the entities (objects) stored in our database.

# Importing the Models Package 

1. Go to the menu bar in Xcode. "File" ->  "Add Packages"

<img width="384" alt="Screenshot 2022-11-16 at 11 24 57 AM" src="https://user-images.githubusercontent.com/77448773/202222180-9e237e14-c4e6-42f1-84d3-bd9bf5fe4738.png">

#### 2. Choose "Add Local"

<img width="1109" alt="Screenshot 2022-11-16 at 11 26 24 AM" src="https://user-images.githubusercontent.com/77448773/202222181-7861de4c-3041-4081-83a3-d87eb5ac1bc3.png">

#### 3. Navigate to the "Models" and copy the dependency 

<img width="816" alt="Screenshot 2022-11-16 at 11 27 16 AM" src="https://user-images.githubusercontent.com/77448773/202222391-68c00adf-176d-4c05-98a6-0bfd73ab827c.png">

#### 4. Go to the "Package.swift" file in your project and paste the dependency to the end of the "dependencies" array. 

<img width="988" alt="Screenshot 2022-11-16 at 11 28 19 AM" src="https://user-images.githubusercontent.com/77448773/202222672-60268e29-89bb-4745-b1d3-04812805750c.png">

#### 5. Add the product to the "Targets" array. 

<img width="635" alt="Screenshot 2022-11-16 at 11 29 06 AM" src="https://user-images.githubusercontent.com/77448773/202222841-68f133ef-39aa-4184-84f1-9522782012b7.png">

# If Importing Doesn't Work
You may run into this issue when you try to build: "Missing package product". If this happens to you follow these steps. 
  1. Make sure you do not have the Models package open in a window in Xcode.
  2. Go to the nav bar under Product -> Clear All Issues and Product -> Clean Build Folder
  3. Quit Xcode.
  4. Try again. 

# Descriptions of Entities

## User
The User model stores the data necessary to keep track of a user for login purposes. The id generated in this object is used to relate a user to all other entities. 

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to reference a specific User | UUID |
| username | used to search for friends | String |
| password | used to authenticate users on login, chosen by user upon account createion| String |
| phone | used for login. must be unique amongst other users. optional (if email provided) | String | 
| email | used for login. must be unique amongst other users. optional (if phone provided)| String |


## Profile
The Profile model stores all the data of a particular User relevant to display and be viewed on the application. It also stores a particular user's preferences used in generating potential matches.

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to reference a specific Profile | UUID |
| user_id | reference to the specific User who the profile belongs to | UUID |
| name | name to be displayed on the Application | String |
| birthdate | birthday to determine age. Age should be verified in the front end | Date | 
| occupation | current occupation of the user to be displated on the Application. Entered by the user. Optional field. | String |
| bio | short textual description written by the user about themseleves upon account creation | String |
| gender | gender identity of the User. Specified by the User upon account creation. Can be altered. Used for generating potential matches. Not displayed. | Int16 |
| preference | the sexual preference of the User. Specified by the user upon account creation. Can be altered after account creation. Not displayed. | Int16| 
| min_age | the minimum age of the potential prospects a User would like to view. Can be altered after account creation. | Int16 |
| max_age | the maximum age of the potential prospects a User would like to view. Can be altered after account creation. | Int16 |
| max_distance | the maximum distance of the potential prospects a User would like to view. Can be altered after account creation | Int16 |
| curr_latitude | the current latitude of the User | Double |
|curr_longitude | the current longitude of the User | Double |

## Profile Preview
The Profile Preview model contains minimal data about a particular User that will be used to display a preview of this User's profile. For example, in the friendship and messaging views. 
| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to reference a specific ProfilePreview | UUID |
| user_id | reference to the specific User who the profile belongs to | UUID |
| username | used to be displayed to friends | String |
| name | name to be displayed on the Application | String |
| primary_photo | photo used as when a preview of the profile is displayed | Data |


## Prompt
The Prompt model contains textual prompts available to users to respond to when building their profiles. These will be generated internally. 

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to reference a specific Prompt | UUID |
| prompt_text | textual string displayed to the user | String |


## Prompt Response
The Prompt Response model is an associative entity that stores all responses to a particular prompt by a particular user. 

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to reference a specific Prompt | UUID |
| user_id | reference to the specific User who responded to a particular prompt | UUID |
| prompt_id | reference to the specific Prompt the particular User responded to | UUID |
| response_text | the textual response entered by the User to be displayed on their Profile | String |

## Photo
The Photo model stores the binary data of a photo file to be displayed by a particular user and a reference to that particular user.  
| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to reference a specific Photo | UUID |
| uesr_id | reference to a specific User who uplaoded the photo | UUID |
| photo | the binary data of a photo | Data |
| index | an integer indicating the rank of the photo to determine the order it should be displayed on a user's profile | Int16 |


## Swipe
The Swipe model stores the response of a particular User to a prospect, whether it is a like, dislike, or a like via a wing. 

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to reference a specific Swipe | UUID |
| swiper_id | a reference to a specific User who swiped on the profile of another User | UUID |
| prospect_id | a reference to the User whose profile the swiper swiped on | UUID |
| type | an integer indicating if the swiper, liked (1), disliked (2), or like the prospect via wing (3). | Int16 |
| created_at | a timestamp indicating when the swipe occured used for deleting expired records | Date |



## Match
The Match model is used to store two users who have been matched together and whether it was a direct match or a match via a wing.

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to reference a specific Match | UUID |
| first_user_id | a reference to one of two User members of the match | UUID |
| second_user_id | a reference to one of two User members of the match | UUID |
| type | an integer indicating if the match was direct (1) between users or via a wing (2) | Int16 |



## Friendship
The Friendship model stores two users who are friends. A single record exists for two users who are friends. The status indicates whether a request for friendship has been sent, “pending” or if it has been accepted. If a request is not accepted the record for the Friendship is deleted. 

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to reference a specific Friendship | UUID |
| requester_id | a reference to the User who requested the friendship | UUID |
| respondent_id | a reference to the User who received a request for friendship | UUID |
| status | an integer indicating if the request for the friendship is pending (1), accepted (2), or declined (3) | Int16 |


## Wing
The Wing model stores an instance when a user sends a friend the profile of a potential date. It has a status indicating that it is pending a response. If the response is liked by the recipient of the Wing, a Swipe record is created in its place. If it is disliked the Wing record is deleted. 

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to reference a specific Wing | UUID |
| sender_id | a reference to the User who sent a profile to a friend | UUID |
| recipient_id | a reference to the User who received a profile for a prospect from a friend | UUID |
| prospect_id | a reference to the User whose profile the sender winged to the recipient | UUID |
| status | an integer indicating if the wing is waiting for a response from the recipient (1), if the recipient has liked the prospect (2), or if the recipient has disliked the prospect (3) | Int16 |


## Message
The Message model stores a reference to a User who is a sender and a User who is a recipient. It stores the content of the message, which is exclusively text. It also stores a timestamp of when the message was sent and a status indicating whether it has been read by the recipient. 

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to reference a specific Message | UUID |
| sender_id | a reference to the User who sent a message | UUID |
| recipient_id | a reference to the User who received a message | UUID |
| content | the contents of the message | String |
| status | an integer indicating if the message has been sent to the recipient (1) or if they have read the message (2) | Int16 |
| sent_at | a timestamp indicating when the message was sent | Date |



## Block

The Block model stores a reference to a User who has blocked another User. It keeps track of whether or not the User has reported the User they blocked and if so what the issue was.

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to reference a specific Block | UUID |
| blocked_user_id | a reference to the User who was blocked by another User | UUID |
| blocked_by_id | a reference to the User who blocked a particular User | UUID |
| reported | did the User who blocked the other User also report them | Bool |
| issue | an integer indicating the particular issue that led to a user being reported. Null if "reported" is false | Int16 |





