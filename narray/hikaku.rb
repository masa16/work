
s = open("numpy-ref.html","rt").read
list = {}

re = %r|<dt><a href="([^"]+)">(.*?)</a>\s*</dt>|m
s.scan(re) do |x,y|
  ref,name = x.split("#")
  name.gsub!(/__/,'\_\_')
  if /\(([^()]+)\)/ =~ y
    (list[$1] ||= []) << "[#{name}](https://docs.scipy.org/doc/numpy/#{x})"
  end
end

body = "# numpy docs\n\n"
list.keys.sort.each do |k|
  next if /^(C |built-in)/ =~ k
  body << <<EOL
## #{k}

| numpy | numo-narray |
| ---------- | ---------- |
EOL
  list[k].each do |ref|
    body << "| #{ref} | [Numo::NArray]() |\n"
  end
  body << "\n"
end

open("hikaku.md","wt"){|f| f.puts body}
