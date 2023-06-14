QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, targetID, tp)
	local Player= QBCore.Functions.GetPlayer(tonumber(ID))
	local data = {
		sex = Player.PlayerData.charinfo.gender,
		firstname = Player.PlayerData.charinfo.firstname,
		lastname = Player.PlayerData.charinfo.lastname,
		dateofbirth = Player.PlayerData.charinfo.birthdate

	}
	local license = {}
	for k,v in pairs (Player.PlayerData.metadata.licences) do 
		if v then
			table.insert(license, {type = tostring(k)})
		end
	end
	if targetID then
		TriggerClientEvent('jsfour-idcard:open', targetID, {user = data, licenses = license}, tp)

	else
		TriggerClientEvent('jsfour-idcard:open', ID, {user = data, licenses = license}, tp)
	end
end)

---@param licenses 'driver', 'weapon', nil
RegisterCommand('openid', function(source) 
	TriggerEvent('jsfour-idcard:open', source, false, nil)
end)


QBCore.Functions.CreateUseableItem('id_card', function(source, item)
	QBCore.Functions.TriggerClientCallback('jsfour-idcard:getclosestplayer', source, function(player)
		if player and player ~= -1 then 
			TriggerEvent('jsfour-idcard:open', source , tonumber(player), nil)	
		else
			TriggerEvent('jsfour-idcard:open', source, false, nil)
		end
	end)
end)

QBCore.Functions.CreateUseableItem('driver_license', function(source, item)
	QBCore.Functions.TriggerClientCallback('jsfour-idcard:getclosestplayer', source, function(player)
		if player and player ~= -1 then 
			TriggerEvent('jsfour-idcard:open', source , tonumber(player), 'driver')	
		else
			TriggerEvent('jsfour-idcard:open', source, false, 'driver')
		end
	end)
end)