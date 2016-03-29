os.loadAPI('/src/lib/json')
monitor = peripheral.wrap('left')
local forecast_url = 'https://api.forecast.io/forecast/'
local lat = '44.475883'
local long = '-73.212074'

local api_key_file = fs.open('/etc/forecast', 'r')
local api_key = api_key_file.readLine()

local request_uri = forecast_url .. api_key .. '/' .. lat .. ',' .. long

while true do
    local response_json = http.get(request_uri).readAll()
    local response = json.decode(response_json)

    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.write('Burlington, VT')
    monitor.setCursorPos(1,2)
    monitor.write(response.currently.summary .. ", ")
    monitor.write(response.currently.temperature .. ' F')
    sleep(300)
end