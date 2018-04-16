package 'ntp'
package 'apache2'

hostname = 'replace_with_ohai_lookup'

file '/var/www/html/index.html' do
  content "#{hostname}\n"
end
