from sets import Set
import re

f = open('aliases.tmp', 'r')

mlist = [
'katrine.e.pedersen@gmail.com',
'hanne.bronmo@gmail.com',
'monica.michelsen89@gmail.com',
'lars.godbolt@gmail.com',
'permriseng@gmail.com',
'hildeorbo@gmail.com',
'sveinhal@gmail.com',
'lleganger@underdusken.no',
'frida.alex04@gmail.com',
'atbjarnason@gmail.com',
'marit.albrigtsen@gmail.com',
'sara.kornberg@gmail.com',
'bluefoxofdeath@gmail.com'
]

res = []

rx = re.compile('[ \t\r\n]*')
count = len(mlist) 

for l in f.readlines():
	for m in mlist:
		if "@underdusken.no" in m:
			m2 = m.replace("@underdusken.no", "");
			if m2 in l:
				res.append(m)
				mlist.remove(m)
		elif m in l: 
			l = l.replace(m, "")
			l = l + "@underdusken.no"
			l = rx.sub('', l).strip()
			#res.append(m+"\n"+l)
			res.append(l)
			mlist.remove(m)

for a in res:
	print a 

print "found:", len(res), " of:", count

for m in mlist:
	print m
