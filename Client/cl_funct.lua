local helmetEnabled = false

function EnableHelmet()
    Citizen.CreateThread(function()
        while helmetEnabled do
            Citizen.Wait(1000)
            local playerPed = PlayerPedId()
            if IsPedOnAnyBike(playerPed) and not IsPedWearingHelmet(playerPed) then
                TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MOBILE_FILM_SHOCKING", 0, true)
                Citizen.Wait(2000)
                ClearPedTasksImmediately(playerPed)
                GivePedHelmet(playerPed, true, 4096, 0)
            end
        end
    end)
end

function DisableHelmet()
    Citizen.CreateThread(function()
        while not helmetEnabled do
            Citizen.Wait(1000)
            local playerPed = PlayerPedId()
            if IsPedWearingHelmet(playerPed) then
                RemovePedHelmet(playerPed, true)
            end
        end
    end)
end

function DisableDogBarking(disable)
    local ped = PlayerPedId()
    local playerCoords = GetEntityCoords(ped)
    local radius = 50.0
    local dogs = GetNearbyPeds(playerCoords.x, playerCoords.y, playerCoords.z, radius)
    
    for _, dog in ipairs(dogs) do
        if IsPedModel(dog, GetHashKey("a_c_rottweiler")) or IsPedModel(dog, GetHashKey("a_c_shepherd")) or IsPedModel(dog, GetHashKey("a_c_husky")) then
            if disable then
                StopPedSpeaking(dog, true)
            else
                StopPedSpeaking(dog, false)
            end
        end
    end
end

function GetNearbyPeds(x, y, z, radius)
    local peds = {}
    local handle, ped = FindFirstPed()
    local success
    repeat
        local pedPos = GetEntityCoords(ped)
        local distance = #(vector3(x, y, z) - pedPos)
        if distance <= radius then
            table.insert(peds, ped)
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return peds
end

