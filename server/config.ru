# Graciously stolen from https://github.com/mattt/GroundControl/blob/master/Example/Server/config.ru
require 'bundler'
require 'sinatra'
require 'plist'

get '/defaults.plist' do 
  content_type 'application/x-plist'

  {
    'soapbox_announcement_id' => '1',
    'soapbox_announcement_url' => '/announcement',
    'soapbox_accept_url' => '/accept',
    'soapbox_show_accept_button' => true,
    'soapbox_accept_color' => '#FFB300',
    'soapbox_dismiss_color' => '#7222F2'
  }.to_plist
end

get '/announcement' do
  send_file 'public/announcement.html'
end

get '/accept' do
  send_file 'public/accept.html'
end

# run Sinatra::Application.run!
