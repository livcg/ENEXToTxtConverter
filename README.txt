
This script takes an XML document of Evernote notes and converts it to a flat text file.  As part of my GTD system, I capture thoughts into Evernote notes.  Instead of processing each note individually on the Evernote app, I export them into an ENEX file, run this script on it, and review the output text file with my favourite text editor using familiar quick keys rather than having to point and click on the Evernote app.

TO DO:
* Upload to Github
* Add test data
* Add tests
* Add input & output files as args
* Use XML modules instead of regex (though regex is fun)
* Or consolidate regex matching into 1 pass; figure out how to pass matched substrings into mgsub?
* Incorporate this script into an Evernote app that automatically retrieves all the notes from a given notebook
