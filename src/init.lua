wifi = require('wifi')
tmr = require('tmr')

app = require('application')
config = require('config')

local module = {}

local function waitForIP()
  if wifi.sta.getip() == nil then
    print("ip unavailable waiting")
  else
    tmr.stop(1)
    print("=================")
    print("ESP8266 on " .. wifi.getmode())
    print("MAC is " .. wifi.ap.getmac())
    print("IP is " .. wifi.sta.getip())
    print("=================")

    app.start()
  end
end

local function connect()
  if aps then
    for key, _ in pairs(aps) do
      wifi.setmode(wifi.STATION);
      wifi.sta.config(key, config.SSID[key])
      wifi.sta.connect()
      print("connecting to " .. key .. "...")

      tmr.alarm(1, 2500, 1, waitForIP)
    end
  else
    print("error getting AP list")
  end

  function module.start()
    print("configuring wifi..")
    wifi.setmode(wifi.STATION);
    wifi.sta.getap(connect)
  end
  return module
end
