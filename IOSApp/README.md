# On this Page 
1. [Frontend Structure Overview](#frontEndStructure)
2. [Running the frontend locally](#runLocally)
3. [Common Errors](#commonErrors)
4. [Basic How-To-Use](#howToUse)

## Frontend Structure Overview <a name="frontEndStructure"></a>

The frontend structure is divided into three parts (top level):
- Wing
- WingTests
- WingUITests

<img width="234" alt="Screen Shot 2022-11-24 at 1 07 22 PM" src="https://user-images.githubusercontent.com/75460797/203837269-d6ab09f1-2877-433f-80ed-34ee6c7c44a7.png">

If you open up the Wing folder structure, you will find the **_Assets File_**. This is your GO-TO file for all components related to the Figma (design). Logos, colours, and icons, are all stored there for you to easily reference. This also allows for consistency throughout the application (more on how to use this in the **"Basic How-to-Use" ** section.

All of the views in the app are stored in the **_views_** folder. You can pretty much assume that one view file is equivalent to one frame in the Figma folder (so if you see a file called "LoginView", it probably contains the view needed to represent the log in page in the Figma.

The views are separated into six different categories within the **_views_** folder. This includes the four separate segments of the application:
- Login/Create account flow
- Match flow (this is where you would swipe and see other user's profiles)
- Message flow (this is where you would see all of your messages)
- Wing flow (this is where you would see Wing profiles sent to you, and where you can add/edit friends)
- Block/Report (this is where we store anything related to blocking and reporting users)
- Settings

You will be able to see these six different categories clearly divided in the Figma as well.

## Running the FrontEnd Locally <a name="runLocally"></a>

1. First, make sure that your Github account is connected to XCode (http://irenebosque.com/how-to-xcode-and-github/)
2. Open XCode and click 'open a project or file'. Then navigate to your where you set up your Wing repo locally. You'll have to go into Wing/IOSApp and open the project from there to get to the frontend. 

<img width="806" alt="Screen Shot 2022-11-24 at 1 02 42 PM" src="https://user-images.githubusercontent.com/75460797/203836556-89ce615e-ac68-4b18-8fc9-9784094d0a3a.png">

To build your project, go to Product -> Build.

<img width="270" alt="Screen Shot 2022-11-24 at 1 15 42 PM" src="https://user-images.githubusercontent.com/75460797/203838471-7dd3b93b-4c87-4113-9ef5-992043faa67b.png">

To run your project and see the simulator (the siumulator is a simulation of an iPhone that you can run right on your laptop from XCode), click the play button on the top right corner of the left-side tab. You can also run it by going to Product -> Run.

<img width="240" alt="Screen Shot 2022-11-24 at 1 17 20 PM" src="https://user-images.githubusercontent.com/75460797/203838673-3e7800d4-6703-44fd-a4d5-9e7fe4e357eb.png">

<img width="263" alt="Screen Shot 2022-11-24 at 1 17 34 PM" src="https://user-images.githubusercontent.com/75460797/203838716-039c0fb8-3855-4fd6-a436-4ba0051cadb3.png">

## Common Errors <a name="commonErrors"></a>

###I can't see the preview

You need to make sure that you have PreviewProvider setup for the view that you're trying to preview. It would look something like this at the end of your file (replace with your own view file name):

<img width="396" alt="Screen Shot 2022-11-24 at 1 22 46 PM" src="https://user-images.githubusercontent.com/75460797/203839454-d6ef1b06-3f45-4cb7-9a09-e44adf79a27d.png">

###I'm getting Git conflicts for the project.pbxproj file

This is a common issue for XCode. Basically, we have not found a great work-around for this problem... (but if you have a solution, please feel free to edit this file and share with everyone!). You will have to manually go through the file and make sure that you're keeping both versions of the file (since most of the time, the issue is that it's trying to replace what's already in there with lines about your new file but you want to keep both). 

## Basic How-To-Use <a name="howToUse"></a>

###How to use assets

If you're looking to add a logo, use a colour, font, or icon, you will be sourcing these from the Assets file.

**Logos:**

You will need to use the Image() call. The basic syntax is:

'''
Image("GreenLogo")
'''

Replace the "GreenLogo" with whichever version of the logo that you are looking for (all of the names are in the Assets file so check there and use those names accordingly).

**Fonts:**

There's two main fonts that we use in the Wing application. These are:
- Noto Sans
- Kumbh Sans

These .ttf files are stored under the fonts folder (you don't need to know this, but if you want to take a look go ahead).

To use a font, you can use the FontManager that has been set up for easy access:

'''
Text("Wing")
  .font(.custom(FontManager.KumbhSans.bold, size: 64.0))
'''

As you can see, you can use the .font() call after your Text object. Then, as the first parameter, use .custom() to let the application know that you'll be using your own font. Then in the .custom() parameter, use FontManager, you can either call KumbhSans or NotoSans, and there's a variety of different styles you can use. This ranges from semi-bold, italics, bold, regular, and so-on. Take a look at the FontManager file to see the options.

**Icons:**

You can use these the same way that you would use the logo (see a couple sections up), using the Image() call and specifying the name of the icon from the Assets file.

**Colours:**

To use a colour from the Assets folder _(you should never use any colour that is NOT from the Assets file unless they are black and white)_, simply use the Color() call.

'''
Text("ReadMe example")
  .foregroundColor(Color("BrightRed"))
'''



