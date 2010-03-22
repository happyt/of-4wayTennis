git setup on mac

downloaded gitx
created command line option
go into command line
create dir. for source
git pull ??


created my directories
add source files
make sure one text file in a dir.
move to dir
git init
git add .
git commit -m "a version message"


create github site happytuesdays ian.ht/s
http://github.com/happyt/happytuesdays
git config --global user.name "happyt"
git config --global user.email ian.happytuesdays@gmail.com

check if anything in ~/.ssh
 ssh-keygen -t rsa -C ian.happytuesdays@gmail.com (using s catchphrase)
this creates the 2 files in ~/.ssh id_rsa and is_rsa.pub
 
The key fingerprint is:
01:c7:c3:b6:12:c8:5c:32:d9:c6:4b:4c:65:e3:5f:3f ian.happytuesdays@gmail.com

The key's randomart image is:
+--[ RSA 2048]----+
|   ooO++=        |
|    =oB==.       |
|     o +oo  .    |
|      o .o . .   |
|       .S .   E  |
|               . |
|                 |
|                 |
|                 |
+-----------------+

Added the public key, in account settings. Used a blank name so it uses the email
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA0+m09BPfGFQzCZ0UGm6She8EhOB2yBSXps+6ktNnHhnWXHiRc+SmH+b8bOKPqPMFUTxkC9/cxl/b0AyJzeBxJFmJI9PpVJ/t1U8I7Qk9a/Q0MxPLQTaJyLKpHwbx64vt8bOPZk+u/Uqi9FW3VAQyuS+uRM3pTqftvI+3wegO8zFE+ysCorwpg2Op/7ZcpmBCawAK/7RCGj98x1AU3hw5wiryJKrztrQN46yHxV9JsQQSsS9auadMxhiyWJVR1n+sXcH7JN65eWhXQukkavqDjC36wCQBD8moyCX5oF0lPKIIqg9BJ0vZLiIk4OjNo88svnUQhu1oCpnrjixNNybKaQ== ian.happytuesdays@gmail.com

cd to happytuesdays directory
then   git remote add origin git@github.com:happyt/happytuesdays.git
then   git push origin master
  this prompts for the secret phrase - s
  then wrote all the objects


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
artem's app for creating new iPhone fox app 
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









