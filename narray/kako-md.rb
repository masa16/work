
s = open("numpy-ref.html","rt").read
list = {}

re = %r|<dt><a href="([^"]+)">(.*?)</a>\s*</dt>|m
s.scan(re) do |x,y|
  ref,name = x.split("#")
  if /\(([^()]+)\)/ =~ y
    (list[$1] ||= []) << "* [#{name}](https://docs.scipy.org/doc/numpy/#{x})\n"
  end
end

body = "# numpy docs"
list.keys.sort.each do |k|
  body << "\n## #{k}\n"
  list[k].each do |ref|
    body << ref
  end
end

open("numpy-ref-kako.md","wt"){|f| f.puts body}
