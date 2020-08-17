ESX              = nil


local PlayerData = {}
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer   
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)


local NosOn = false-- Define NOS

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerVeh = GetVehiclePedIsIn(playerPed, false)
		local Speed = 80.0
        local playerPed = GetPlayerPed(-1)
        local playerPed = PlayerPedId()
        local vehicle = GetPlayersLastVehicle()
	
		if IsControlPressed(1, 38) and NosOn then
			SetVehicleBoostActive(vehicle, 1, 0)
            SetVehicleBoostActive(vehicle, 1, 0)
            SetVehicleRocketBoostActive(vehicle, true)
            SetVehicleRocketBoostPercentage(vehicle, 1000)
            StartScreenEffect("RaceTurbo", 0, 0)
            SetVehicleOnGroundProperly(vehicle)
            SetEnableVehicleSlipstreaming(true)
            Citizen.Wait(1000)
            SetVehicleRocketBoostActive(vehicle, true)
            SetVehicleRocketBoostPercentage(vehicle, 0)
            SetEnableVehicleSlipstreaming(false)
			NosOn = false
        end
    end
end)

RegisterNetEvent('kypo-esx-nos:onUse')
AddEventHandler('kypo-esx-nos:onUse', function()
        TriggerServerEvent('kypo-esx-nos:removeInventoryItem','nitro', 1)
        ActivateNOS()
end)

function ActivateNOS()
    NosOn = true
end
