
# Running the Backend Locally
start database from postgres app.      

migrate database to set it up with all the data. (will take awhile or tell you your local db is up to date )  
`vapor run migrate` (in project directory) 
answer 'y' to "Would you like to continue?"   


Open project in xcode and press play button (build takes some time)

Check endpoints via browser OR Send insomnia requests    



## Common Errors    
There is some problem with certificates when using xcode git controls to push/pull. When off of eduroam it works fine (I THINK eduroam has some kind of proxy/and or cache set up that blocks the certificates). Also will not work on public internet connections. 


# Installations   

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
1. Download postgres software 
`brew install postgresql`

2. Install Postgres App




## Fluent       
Fluent is an Object-Relational Mapping (ORM) framework. Fluent works in conjunction with Vapor to provide an interface to work with databases in Swift. Fluent is included with the Vapor download.


## Insomnia     
Insomnia is an application that allows developers to easily test RESTapis. We will use this to test different API endpoints. Different software will also work (ex. Postman).   
### Installing Insomnia  
1. Install Insomnia using Homebrew  
`brew install --cask insomnia`  
 

