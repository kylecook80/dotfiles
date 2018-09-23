#!/usr/bin/env ruby

require 'open-uri'
require 'droplet_kit'

apikey = ''
domain = ''
domain_record_id = ''
ip = open('http://whatismyip.akamai.com').read

puts "IP is " + ip

client = DropletKit::Client.new(access_token: apikey)
record = client.domain_records.find(for_domain: domain, id: domain_record_id)
if record.data == ip
  puts "IP is the same. Not updating..."
else
  puts "Updating IP..."
  record.data = ip
  client.domain_records.update(record, for_domain: domain, id: domain_record_id)
  puts "Done"
end
