# On this Page 
1. [Running the backend locally](#runLocally)
2. [Common Errors](#commonErrors)
3. [Installation Instructions](#installation)


# Running the Backend Locally <a name="runLocally"></a>

1. If you have not already - clone the Wing repo. You can do this from Xcode (after your Github account has been linked).  

<img width="820" alt="Screen Shot 2022-10-13 at 4 51 45 PM" src="https://user-images.githubusercontent.com/80468156/195696008-334a5ee8-f48d-4674-9df1-f82cf62bac62.png">

2. Start the postgres database using the postgres application. 

<img width="820" alt="Screen Shot 2022-10-13 at 4 53 34 PM" src="https://user-images.githubusercontent.com/80468156/195696463-2bd83537-276a-4e31-b381-fd67cca4ef69.png">

3. Migrate Data     
Open a terminal instance and move to your local version of the Backend Wing project (Wing > Backend > Wing). Run the command listed below. When prompted answer 'y' to "Would you like to continue?". This will populate your local database with all of the project tables.    

`vapor run migrate`    

4. Build the project in Xcode    
Open the project in xcode (Wing > Backend > Wing) and press play button in the top left hand corner. The first build will take some time, subsequent builds will go much quicker.   

5. View API endpoints       
Navigate to `http://127.0.0.1:8080`. Try out different endpoints to see how they work. All endpoints are outlined in the ROUTES.md file and the routes.swift file.   

6. Test API endpoints     
Formulate a http request in insomnia and try sending it to the server you are running locally.   
  
  
 <img width="1196" alt="Screen Shot 2022-10-13 at 5 08 30 PM" src="https://user-images.githubusercontent.com/80468156/195699130-b9532219-608a-4d78-a980-0e81136da847.png">

7. To run unit tests     
In terminal, navigate to project directory and run `swift test`      
In Xcode, go to Product>Test      


## Common Errors  <a name="commonErrors"></a>
- **Blocked certificate when trying to push/pull from Xcode**                   
There is a problem with certificates when using Xcode git controls on Eduroam. Not sure how to fix - but when off Eduroam git controls work just fine. Same issue with public internet connections.      

- **Importing the Models package**            
The Models package contains the declarations for the entities that are stored in the database. These will allow us to create objects that can be easily passed between Swift and Postgres. You may run into this issue when you try to build: "Missing package product". If this happens to you follow these steps. 
  1. Make sure you do not have the Models package open in a window in Xcode.
  2. Go to the nav bar under Product -> Clear All Issues and Product -> Clean Build Folder
  3. Quit Xcode.
  4. Try again. 
  
- **Migration error in vapor**

  Error:
  `warning: '--enable-test-discovery' option is deprecated; tests are automatically discovered on all platforms error: terminated(72): /usr/bin/xcrun --sdk macosx --find xctest output: xcrun: error: unable to find utility "xctest", not a developer tool or in PATH VaporToolbox/exec.swift:55: Fatal error: result 1 zsh: illegal hardware instruction vapor run migrate`

  To Fix: Xcode > Preferences and in the 'Locations' tab select Command Line tools


# Installations   <a name="installation"></a>

## Xcode    
Xcode is Apple's IDE. IT allows developpers to easily make iOS applications and add these applications to the app store. To ensure a uniform development experience we suggest you use Xcode to contribute. Ensure Xcode in installed before continuing.      
### Adding Github to Xcode   
1. Configure Github on your Mac       
`git config --global user.name "username"`     
`git config --global user.email "email@blahblah.com"`

2. Generate Personal Access Token on Github      
Go to Settings > Developer Settings > Personal access tokens.    
Click "Generate New Token".    
Name the token and **copy it to clip board**
<img width="1151" alt="Screen Shot 2022-10-13 at 11 35 09 AM" src="https://user-images.githubusercontent.com/80468156/195626754-4626a965-6db2-47ea-929c-d1cda9248b60.png">  

3. Add Github Account in Xcode 
In Xcode, go to Prefrences > Accounts (in top menu bar).   
Add a new Github account using the small '+' in the bottom left hand corner. 
<img width="833" alt="Screen Shot 2022-10-13 at 11 41 44 AM" src="https://user-images.githubusercontent.com/80468156/195628306-a3ee3e75-2155-4313-9454-a062eb9066ff.png">

<img width="556" alt="Screen Shot 2022-10-13 at 11 43 42 AM" src="https://user-images.githubusercontent.com/80468156/195628663-e1beee5d-3a9c-436d-b28a-be5097413d91.png">

Pick a name for your account and paste your personal access token in the alotted space. 

<img width="556" alt="Screen Shot 2022-10-13 at 11 43 50 AM" src="https://user-images.githubusercontent.com/80468156/195628909-4b8f6906-2f1b-4b97-88b5-b40699e95306.png">

You can now use Xcode controls to clone, pull and push to the remote repository. 


## Vapor   
Vapor is a web framework that allows you to write backen, APIs, http servers, ect. in Swift. In Wing, Vapor is used to write both the API and http server. 
### Installing Vapor 

1. Check version of Swift (must be > 5.2)      
`swift --version`
<img width="760" alt="Screen Shot 2022-10-13 at 11 46 13 AM" src="https://user-images.githubusercontent.com/80468156/195629395-d52be274-6ac7-4842-b69d-701656b7fe4f.png">

2. Check that homebrew is installed        
`brew --version`

<img width="756" alt="Screen Shot 2022-10-13 at 11 28 58 AM" src="https://user-images.githubusercontent.com/80468156/195624884-b0a1972d-6d6d-4fcc-9000-30006b96867e.png">


3. Install Vapor using Homebrew  
`brew install vapor`


## Postgres Database 


### Install Postgres
1. Download the latest version of postgres ([here](https://postgresapp.com/downloads.html))      
This download has everything you need, and comes with a GUI. Upon opening postgres you should see that the default database already exists. For now - we will use this datbase in our Xcode build.  


## Fluent       
Fluent is an Object-Relational Mapping (ORM) framework. Fluent works in conjunction with Vapor to provide an interface to work with databases in Swift. Fluent is included with the Vapor download.


## Insomnia     
Insomnia is an application that allows developers to easily test RESTapis. We will use this to test different API endpoints. Different software will also work (ex. Postman).   
### Installing Insomnia  
1. Install Insomnia using Homebrew  
`brew install --cask insomnia`  
