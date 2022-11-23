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

# Description of Entities

## User
The User model stores the data necessary to keep track of a user for login purposes. The id generated in this object is used to relate a user to all other entities. 

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to refence a specific User | UUID |
| username | used to search for friends | String |
| password | used to authenticate users on login, chosen by user upon account createion| String |
| phone | used for login. must be unique amongst other users. optional (if email provided) | String | 
| email | used for login. must be unique amongst other users. optional (if phone provided)| String |


## Profile
The Profile model stores all the data relevent to display on the application. It also stores a particular user's preferences used in generated potential matches.

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to refence a specific Profile | UUID |
| user_id | reference to the specific User who the profile belongs to | UUID |
| name | name to be displayed on the Application | String |
| birthdate | birthday to determine age. Age should be verified in the front end | Date | 
| occupation | current occupation of the user to be displated on the Application. Entered by the user. Optional field. | String |
| bio | short textual description written by the user about themseleves upon account creation | String |
| gender | gender identity of the User. Specified by the User upon account creation. Can be altered. Used for generating potential matches. Not displayed. | Int16 |
| preference | the sexual preference of the User. Specified by the user upon account creation. Can be altered after account creation. Not displayed. | Int16| 
| min_age | the minimum age of the potential prospects a User would like to view. Can be altered after account creation. | Int16 |
| max_age | the maximum age of the potential prospects a User would like to view. Can be altered after account creation. | Int16 |
| max_distance | the maximum distance of the potential prospects a User would like to view. Can be altered after account creation | Int 16 |

## Prompt
The Prompt model contains textual prompts available to users to respond to when building their profiles. These will be generated internally. 

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to refence a specific Prompt | UUID |
| prompt_text | textual string displayed to the user | String |


## Prompt Response
The Prompt Response model is an associative entity that stores all responses to a particular prompt by a particular user. 

| Attribute | Description | Type |
|:---------:|:-----------:|:----:|
| id | used to refence a specific Prompt | UUID |
| user_id | reference to the specific User who responded to a particular prompt | UUID |
|prompt_id | reference to the specific Prompt the particular User responded to | UUID |
| response_text | the textual response entered by the User to be displayed on their Profile | String |

## Photo
The Photo model stores the image file of a photo to be displayed by a particular user and a reference to that particular user. 


## Swipe
The Swipe model stores the 



## Match


## Friendship

## Wing

## Message

## Block

