import urllib2
import re

contents = urllib2.urlopen("https://cloud.tencent.com/document/product/266/14424").read()

m = re.findall('<span class="hljs-string">"(.*?)"</span>', contents)

if m :
	print('https:' + m[0] + '\nhttps:' + m[2] + '\nhttps:' + m[3] + '\nhttps:' + m[4])
