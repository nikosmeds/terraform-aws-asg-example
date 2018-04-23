import dns.resolver

sites = ["apple.com", "google.com", "microsoft.com"]

for site in sites:
  title = site[:site.rfind(".")].capitalize()
  answers = dns.resolver.query(site, 'NS')
  
  print (title, ": ", sep='', end='')
  
  for rdata in answers[:3]:
    print(rdata, " ", end='')
    
  print('')
