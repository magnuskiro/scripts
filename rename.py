import glob, os

dir = "/home/magnuskiro/kom/nye/"
filePattern = "*.jpg"

for existingName in glob.iglob(os.path.join(dir, filePattern)):
	file, ext = os.path.splitext(os.path.basename(existingName))
	file = file.rsplit("_")[:1]
	file = file[0]
	file = file + ext
#	print existingName
#	print file
	newName = os.path.join(dir, file)
#	print newName
	os.rename(existingName, newName)
