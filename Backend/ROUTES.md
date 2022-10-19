# Wing API 


CRUD 
By username or by user ID ?

# USER Endpoints 

## PUT Account by username (Create Account) 

## PUT User by username  (Create Account Prefrences) 

## GET user by phone/email & password   
To login into the app 
      
## PATCH User by username (updating filters/prefrences).    

## PATCH Account by username (updating password)

## GET user by username    
To lookup a friend to send friend request 
To Look up a friend to send match 

## DELETE user by username (Delete Account) 

# MATCH Endpoints 

## PUT match by <username1, username2>.  
when match is first created 

## PUT match by <username1, username2, wingman>     
when wingman sends match to username1  

## PATCH match by <username1, username2>        
when match is mutually accepted 

## PATCH match by <username1, username2, wingman>      

## DELETE match by <username1, username2, wingman>   

## DELETE match by <username1, username2>.    
if match is never mutual 

# MESSAGES 
## GET conversation by <username1, username2>.  
