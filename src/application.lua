local net = require('net')
local dht = require('dht')
local wifi = require('wifi')
dofile("server.lua")

local config = require('config')

local module = {}
pin = 5
function readshit()
    status, temp, humi = dht.read(pin)
    if( status == dht.OK) then
      reads = temp .. "C " .. humi .. "%"
      print(reads)

    end
end


readshit()



function runServer()
    s = net.createServer(net.TCP)
  
  print("=================")
  print("server started")
  print("__________________")
  server(80, function(method, path, params, client_ip)
  if path == "/" then
    readshit()
    local html =reads
    return 200, html, "text/html"   
  end
  return 404
end)
      
    
end

readshit()
runServer()
return module

