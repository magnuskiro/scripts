from sets import Set
import re

"""
The filename and opening the aliases file. 
The aliases file is the file that maps usernames to external email addresses that we redirect email to.
"""
filename = "/etc/aliases"
f = open(filename, 'r')

"""
The list of addresses that is to be found in the aliases list.
Formating of a list is important. list = ['element', 'element', 'element']
"""
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

"""
The result list. All the found emails are put into this list. 
"""
res = []

"""
regex expression for text formatting of the emails in res.
"""
rx = re.compile('[ \t\r\n]*')
count = len(mlist) 

# for all the lines in the aliases file
for l in f.readlines():
	# for all email to be found
	for m in mlist:
		# if the address already is an @underdusken.no address we put it in res.
		if "@underdusken.no" in m:
			m2 = m.replace("@underdusken.no", "");
			if m2 in l:
				res.append(m)
				mlist.remove(m)
		# if the external email is found on the line in aliases 
		# -we format the string 
		# -add @underdusken.no after the username
		# - add it to res 
		elif m in l: 
			l = l.replace(m, "")
			l = l + "@underdusken.no"
			l = rx.sub('', l).strip()
			#res.append(m+"\n"+l)
			res.append(l)
			mlist.remove(m)

# print the found email addresses
for a in res:
	print a 

# print the number of found addresses and the number of addresses to be found.
# this informs the user if all emails have been found. 
print "found:", len(res), " of:", count

# print the external emails that was not found in the list.
for m in mlist:
	print m
