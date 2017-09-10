
mqtt_broker_ip='192.168.1.115'
mqtt_port = 1883
qos = 0

macid = wifi.sta.getmac()
--wait for WiFi connection 
wifi_available=0
if wifi_available==0 then
	tmr.alarm(1,1000,1,function()
		if wifi.sta.getip()==nil then
			print("no wifi")
		else
		    print ('IP is '..wifi.sta.getip())
		    wifi_available=1
		    m = mqtt.Client(wifi.sta.getmac()) 
		    m:connect(mqtt_broker_ip,mqtt_port,0,function(conn) 
			print('mqtt connected')
			tmr.stop(1)
			tmr.unregister(1)
			end)
		end
	end)
end
tmr.alarm(0,30000,1,function()  --sleeps after being active for 30seconds
	print("sleep")
	wifi.sta.disconnect()
	node.dsleep(sleepTime)
end)



