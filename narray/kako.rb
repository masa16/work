
body = <<EOL
<!DOCTYPE html>

<html>
  <head>
  </head>
  <body>
EOL

s = open("numpy-ref.html","rt").read
list = {}

#re = %r|\s*<dt><a href="[^"]+">(?:\S+ )?\(([^)]+)\)</a>\s*</dt>|m
#s.gsub!(re){|x| ($1=="in module numpy") ? x : ""}

#re = %r|\s*<dt><a href="[^"]+">.*?</a>\s*</dt>|m
#s.gsub!(re){|x| /\(in module numpy\)/ =~ x ? x : ""}

re = %r|<dt><a href="([^"]+)">(.*?)</a>\s*</dt>|m
s.scan(re) do |x,y|
  ref,name = x.split("#")
  if /\(([^()]+)\)/ =~ y
    (list[$1] ||= []) << "<dt><a href=\"https://docs.scipy.org/doc/numpy/#{x}\">#{name}</a></dt>\n"
  end
end

list.keys.sort.each do |k|
  body << "<h2>#{k}</h2>\n<dl>"
  list[k].each do |ref|
    body << ref
  end
  body << "</dl>\n\n"
end

body << <<EOL
  </body>
</html>
EOL

#open("kind","wt"){|f| f.puts kinds.sort.uniq}

open("numpy-ref-kako.html","wt"){|f| f.puts body}
