local net = require('net')
local dht = require('dht')
local wifi = require('wifi')
dofile("server.lua")

local config = require('config')

local module = {}
pin = 5
status, temp, humi = dht.read(pin)
function readshit()
    if( status == dht.OK) then
      reads = temp .. "C " .. humi .. "%"
      print(reads)

    end
end
homepage1 = [[

<!DOCTYPE HTML>
<html>
 <head>
   <meta content="text/html; charset = utf-8">
   <title> WEATHER STATION</title>
   <style type ="text/css">
     html, body {
       min-height: 100%;
     }
     body {
       font-family: monospace;
       text-align: center;
     }
   </style>
  <body>
    <h5>]]

homepage2 = [[</h5>
  </body>
</html>
]]

readshit()

homepage = homepage1 .. reads .. homepage2

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

