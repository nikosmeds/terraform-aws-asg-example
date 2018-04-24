#!/usr/bin/python3.5

import dns.resolver

sites = ["apple.com", "google.com", "microsoft.com"]

for site in sites:
  title = site[:site.rfind(".")].capitalize()
  response = dns.resolver.query(site, 'NS')
  
  print (title, ": ", sep='', end='')
  
  for rdata in response[:3]:
    print(rdata, " ", end='')
    
  print('')
