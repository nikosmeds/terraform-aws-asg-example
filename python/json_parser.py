#!/usr/bin/python

import json

json_obj = json.load(open('users2.json'))

# Output Terraform template for existing users.
for user in json_obj['users']:
  email = user['email']
  username = email[:email.rfind("@")]

  print "resource \"pagerduty_user\" \"" + username + "\" {"
  print "  name  = \"" + user['name'] + "\""
  print "  email = \"" + user['email'] + "\""
  print "  role  = \"" + user['role'] + "\""
  print "}"
  print ''

# Output `terraform import` commands.
for user in json_obj['users']:
  email = user['email']
  username = email[:email.rfind("@")]

  print "bin/tf accounts/prod/pagerduty import pagerduty_user." + username + " " + user['id']
