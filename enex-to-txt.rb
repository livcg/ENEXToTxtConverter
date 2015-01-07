#!/usr/bin/env ruby

class String
  def mgsub(key_value_pairs = []) 
    regexp_fragments = key_value_pairs.collect { |k,v| k }
    gsub(Regexp.union(*regexp_fragments)) do |match|
      key_value_pairs.detect{ |k,v| k =~ match }[1]
    end
  end
end

open('enote.processed.txt', 'w') { |f| 
  open('enote.enex').each { |x| 

     # First pass - Preserve title & content
     match = Regexp.compile('<title>(.*)<\/title>.*<content><\!\[CDATA[^>]*><!DOCTYPE[^>]*><en\-note[^>]*><div>(.*)<\/div><\/en\-note>\]\]><\/content>').match(x)

     if match
       x = "\nTITLE: " + match[1] + "\n" + match[2] + "\n\n"

       # Second pass - Replace fixed strings
       f.puts(x.mgsub(
         [ 
	   [/\&apos\;/i, "\'"],
           [/&\#8217\;/i, "\'"],
	   [/\&amp\;/i, "&"],
           [/&quot\;/i, "\""],
           [/&lt\;/i, "<"],
           [/&gt\;/i, ">"],
           [/&\#8212\;/i, "--"],
           [/&\#8220\;/i, "\""],
           [/&\#8221\;/i, "\""],
           [/&\#8230\;/i, "..."],
#           [/&\#160\;/i, "\t"],
#           [/&\#163\;/i, "$"], # Actually GBP sign?
	   [/<br\/>/i, "\n"],
	   [/<div>/i, "\n"],
	   [/<\/div>/i, ""],

           # &#160; == &nbsp;
 	 ]))
     end
  }
}
