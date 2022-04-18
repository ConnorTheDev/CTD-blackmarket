QBCore = exports['qb-core']:GetCoreObject()
local PlayerGang = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
  PlayerGang = QBCore.Functions.GetPlayerData().gang
end)

RegisterNetEvent('QBCore:Client:OnGangUpdate')
AddEventHandler('QBCore:Client:OnGangUpdate', function(GangInfo)
  PlayerGang = GangInfo
end)

AddEventHandler('onResourceStart', function(resource)--test
   if resource == GetCurrentResourceName() then
      Wait(100)
      PlayerGang = QBCore.Functions.GetPlayerData().gang
   end
end)

Citizen.CreateThread(function()
  if Config.UsingTarget then
    exports['qb-target']:AddTargetModel("a_m_o_acult_02", {
      options = {
          {
              event = "CTD-blackmaket:Target",
              icon = "fab fa-drupal",
              label = "Blackmarket",
          },
      },
  distance = 1.0 
  })
else
  while true do
    Wait(0)
     local InRange = false
     local PlayerGang = PlayerGang.name
     local MarketItems = {}
     local pedCoords = GetEntityCoords(PlayerPedId())

      for shop, _ in pairs(Config.blackmarkets) do
      local position = Config.blackmarkets[shop]["coords"]
      for _, loc in pairs(position) do
      local distance = #(pedCoords - vector3(loc["x"], loc["y"], loc["z"]))
      if(distance < 2) then
        InRange = true
      DrawText3D(loc["x"], loc["y"], loc["z"]+1, "~r~E")
     if IsControlJustReleased(0, 51) then
      if PlayerGang == Config.blackmarkets[shop].gang then
         MarketItems.slots = 30
         MarketItems.label = Config.blackmarkets[shop]["label"]
         MarketItems.items = Config.blackmarkets[shop]["products"]
         TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'blackmarket', MarketItems)
         --TriggerServerEvent("CTD-blackmarket:Pay")
        else
            QBCore.Functions.Notify('Not right gang!!!', 'error')
          end
            if not InRange then
              Wait(4000)
            end
          end
        end
      end
    end
  end
end
end)

Citizen.CreateThread(function() --create ped
  for shop, _ in pairs(Config.blackmarkets) do
  local position = Config.blackmarkets[shop]["coords"]
  for _, loc in pairs(position) do
        if not DoesEntityExist(dealer) then
        RequestModel('a_m_o_acult_02')
        while not HasModelLoaded('a_m_o_acult_02') do
            Wait(10)
        end
        local dealer = CreatePed(26, 'a_m_o_acult_02', loc["x"], loc["y"], loc["z"], loc["w"], false, false)
        SetEntityHeading(dealer, loc["w"])
        SetBlockingOfNonTemporaryEvents(dealer, true)
        TaskStartScenarioInPlace(dealer, 'WORLD_HUMAN_AA_SMOKE', 0, false)
        FreezeEntityPosition(dealer, true)
        SetEntityInvincible(dealer, true)
      end
    end
  end
end)

function DrawText3D(x, y, z, text)
	SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

RegisterNetEvent('CTD-blackmaket:Target', function()
     local PlayerGang = PlayerGang.name
     local MarketItems = {}
     local pedCoords = GetEntityCoords(PlayerPedId())

      for shop, _ in pairs(Config.blackmarkets) do
      local position = Config.blackmarkets[shop]["coords"]
      for _, loc in pairs(position) do
      local distance = #(pedCoords - vector3(loc["x"], loc["y"], loc["z"]))
      if(distance < 2) then
      if PlayerGang == Config.blackmarkets[shop].gang then
         MarketItems.slots = 30
         MarketItems.label = Config.blackmarkets[shop]["label"]
         MarketItems.items = Config.blackmarkets[shop]["products"]
         TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'blackmarket', MarketItems)
        else
            QBCore.Functions.Notify('Not right gang!!!', 'error')
            end
          end
        end
      end
end)