# bashweb
examples for making bash web GUI's

THis is just a bunch of junk I collected to help make web GUI's with bash.  It uses netcat, bash, and some html.  Its mostly a hack of junk I've found online...  but I'm mostly a hack so its fititng.  For input it basically just grabs the attributes from html forms and passes them to a bash script.  For output it basically just autogenerates HTML in a bash script and displays it.  Super simple stuff.  I'm sure others have done it...  I just havent seen any tutorials online so when I brain-farted this together I figured I'd make a project out of it.

currently you start it by running webserver.bash.  You can connect to it with a web browser on port 3000.  Its a hack.  Don't expect much..  but it serves as a few examples of making webgui's with bash.

It doesnt work on mac...  something to do with regex?  and on some linux installations it won't do iframes

BE CAREFUL WITH THIS!  This is a hackers wet dream come true.  This basically gives access to run code on a remote host.

webserver.bash:  the thing that runs the gui

dynamic.bash: a bash script that autogenerates some html

frames.html: a simple html iframes example

plain.html: the hello world of html

guiproc.bash: simple bash script that takes web form attributes and does something with them

gui.html: a web form example

main.html: this is the web page that opens as the root document
