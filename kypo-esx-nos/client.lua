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
----

----

local NosOn = false-- Define NOS

Citizen.CreateThread(function()
  while true do 
    Citizen.Wait(700)
      if not inCar and IsPedInAnyVehicle(PlayerPedId(), false) then
           inCar = true
      elseif inCar and not IsPedInAnyVehicle(PlayerPedId(), false) then
           inCar = false
      end
  end 
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local CoolDown = 5000
        local Speed = 180.0
        local playerPed = GetPlayerPed(-1)
        local vehicle2 = GetVehiclePedIsIn(playerPed, false)
        local playerPed = PlayerPedId()
        local vehicle = GetPlayersLastVehicle()

        if inCar and IsControlJustReleased(0, 38) and NosOn then
            SetVehicleBoostActive(vehicle, 1, 100)
            SetVehicleRocketBoostPercentage(vehicle, 11000)
            SetVehicleRocketBoostActive(vehicle, true)
            StartScreenEffect("RaceTurbo", 0, 0)
            SetVehicleOnGroundProperly(vehicle)
            SetEnableVehicleSlipstreaming(true)
            exports['progressBars']:startUI(CoolDown, "NOS")
            Citizen.Wait(CoolDown)
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
