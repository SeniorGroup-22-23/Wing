# Wing API 


CRUD 
By username or ID execpt for login 

# USER Endpoints 

## PUT Account by username (Create Account).    
Body is all account details

## PUT User by username  (Create Account Prefrences)    
Body is all preferences 

## GET user by phone/email & password   
To login into the app 

## Get user by ID.   

## Get matches by ID.   
To return all possible profiles that match filter criteria created by user @ ID.   
      
## PATCH User by ID (updating filters/prefrences).    

## PATCH Account by ID (updating password)

## GET user by username    
To lookup a friend to send friend request 
To Look up a friend to send match 

## DELETE user by ID (Delete Account) 

# MATCH Endpoints 

## PUT match by <ID1, ID2>.  
when match is first created 

## PUT match by <ID1, ID2, ID wingman>     
when wingman sends match to username1  

## PATCH match by <ID1, ID2>        
when match is mutually accepted 

## PATCH match by <ID1, ID2, ID wingman>      

## DELETE match by <ID1, ID2, ID wingman>   

## DELETE match by <ID1, ID2>.    
if match is never mutual 

# MESSAGES 
## GET conversation by <ID1, ID2>.  
