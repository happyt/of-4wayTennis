git setup on mac


Sun 21 Mar

download latest 3.2 beta5 iPhone sdk - not installed yet as not approved for app store
downloaded an app to build new OF iPhone projects

created new dir memo for latest memo git
git clone git://github.com/memo/openFrameworks.git
it has a full OF setup for all machines, mac, CB, VS, iPhone
ran emptyExample for Mac, xcode project, set for Mac 10.6 option, ran OK
compiled iPhone/empty example
   set Simulator 3.1.3 Debug, gave 1 error,  pbxcp:images:no such file or directory

---------
found this,
artem's app for creating new iPhone ofx app 
http://artem.posterous.com/xcode-template-for-iphone-apps-using-openfram

place the `openFrameworks Application` folder in the:

/Developer/Platforms/iPhoneOS.platform/Developer/Library/Xcode/Project Templates/Application

folder and restart XCode( if it's running ). Then you can just create a new project and under
the iPhone section, you should see an icon for `openFrameworks Application`. Select that, 
name it and you're good to go from there.


NOTE: The place where you save your newly created project should follow the classic oF 
hierarchy.

EG: /iPhone_OF/apps/my apps/<YOUR APP HERE>/app.xcodeproj

---------
so, just needed an "images" folder in the EmptyExample/bin/dev/ folder.


runs OK in simulator - all other examples run OK, one needed this folder
now how to do iPad version

---------

Then Theo gave a link to a fuller set of examples. Downloaded that zip and worked with those examples. They all seem to work fine. Fantastic.

of_preRelease_v0061_iPhone_FAT.zip

============

Mon 22 Mar

Use ofGetHeight, Width to get sizes - they swap if tilt

added an iphone directory to the happytuesdays folder
need to add the readme.txt
git add iphone
git status - shows the current staged and deleted items
git commit -m "add iphone directory"
make sure add the -m else will get taken into the vim editor

still hadn't added the dir. on the web site ??
so, git push origin master

eventually had to go back to the emptyExample
needed to take out mouse clicks and add touch event handler


get tennis app going
git add iphone
git commit -m "add tennis app"
git push origin master


Sat 27 Mar

Worked out how to get the provisioning sorted on the iPhone
did the tennis24 app
all working in sdk 3.1 to iPhone, so will commit and then upgrade
need to work out what to do to apply for app store

cd ~/git/happytuesdays
git add iphone
git commit -m "update tennis24"
git push origin master
    it then counted and compressed various files














