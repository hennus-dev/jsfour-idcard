QBCore = exports['qb-core']:GetCoreObject()
local open = false

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

QBCore.Functions.CreateClientCallback('jsfour-idcard:getclosestplayer', function(cb)
	local closestPlayer, dist = QBCore.Functions.GetClosestPlayer()
	if dist < 2 and closestPlayer ~= -1 then
		cb(GetPlayerServerId(closestPlayer))
	else
		cb(nil)
	end
end)

-- Key events

Citizen.CreateThread(function()
	while true do
		local wait = 500 
		if open then wait = 0 end
		if IsControlJustReleased(0, 322) and open or IsControlJustReleased(0, 177) and open then
			SendNUIMessage({
				action = "close"
			})
			open = false
		end
		Wait(wait)
	end
end)