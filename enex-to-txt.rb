#!/usr/bin/env ruby

require 'nokogiri'

class String
  def mgsub(key_value_pairs = []) 
    regexp_fragments = key_value_pairs.collect { |k,v| k }
    gsub(Regexp.union(*regexp_fragments)) do |match|
      key_value_pairs.detect{ |k,v| k =~ match }[1]
    end
  end
end

def main 

  if (ARGV.length == 1)
    input_file = ARGV.first
    puts "Input file: " + input_file
    output_file = input_file.gsub(/\.enex$/i, ".processed.txt")
    puts "Output file: " + output_file
  else
    puts "Usage: " + $0 + " <input_file>" 
    exit 1
  end

  open(output_file, 'w') { |out_f| 

    File.open(input_file) do |input|
      doc = Nokogiri::XML(input)
      doc.root.search('//note').each do |note|
        out_f.puts("TITLE: " + note.css('title').inner_html)
        content = note.xpath('content').first.children.first
        c = Nokogiri::XML(content)
        divs = c.css('div')
        
        divs.each { |div|
          # Replace character entities, etc.
          out_f.puts(div.inner_html.mgsub([ [/\&apos\;/i, "\'"], 
                                            [/&\#8217\;/i, "\'"],
                                            [/\&amp\;/i, "&"],
                                            [/&quot\;/i, "\""],
                                            [/&lt\;/i, "<"],
                                            [/&gt\;/i, ">"],
                                            [/&\#8212\;/i, "--"],
                                            [/&\#8220\;/i, "\""],
                                            [/&\#8221\;/i, "\""],
                                            [/&\#8230\;/i, "..."],
                                            # [/&\#160\;/i, "\t"],
                                            # [/&\#163\;/i, "$"], # Actually GBP sign?
                                            [/<br>/i, "\n"],
                                            [/<br\/>/i, "\n"],
                                            [/<div>/i, "\n"],
                                            [/<\/div>/i, ""],
                                            [/<div>\s*<br\/><\/div>/i, "\n\n"],
                                          ]) + "\n\n") }
      end
    end
  }
  exit 0
end

main
