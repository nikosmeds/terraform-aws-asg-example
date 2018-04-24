#! /usr/bin/python

import json
from pprint import pprint

json_file='/home/nsmeds/Documents/users.json'
json_data=open(json_file)
data=json.load(json_data)
#pprint(data)
json_data.close()

print(data['users'])
