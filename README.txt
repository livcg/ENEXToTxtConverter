
This script takes an XML document of Evernote notes and converts it to a flat text file.  As part of my GTD system, I capture thoughts into Evernote notes.  Instead of processing each note individually on the Evernote app, I export them into an ENEX file, run this script on it, and review the output text file with my favourite text editor using familiar quick keys rather than having to point and click on the Evernote app.

TO DO:
x. Push to Github
x. Add test data
x. Rename enote-converter.irb to enex-to-txt.irb ?
* Add tests
* Add input & output files as args
* Print count of # of notes in input & output files
* Use XML modules instead of regex (though regexes are fun)
* Or consolidate regex matching into 1 pass; figure out how to pass matched substrings into mgsub?
* Convert all character entities
* Handle non-text content - Images, audio, etc.
  Sample of processed note w/ audio:
    <en-media type="audio/amr" hash="b79f6cfe0d86279eb49839481f5fd96e"/>
* Incorporate this script into an Evernote app that automatically retrieves all the notes from a given notebook
* Preserve created date and convert to YYYY/MM/DD HH:MM format?  Or only do when@ds, @ts, @dts, etc. shortcuts are detected
* When there are <div>'s w/in content, add curly braces around entire content?
* Remove "TITLE: Untitled Note" lines?
