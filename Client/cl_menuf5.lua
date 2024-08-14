ESX = exports['base']:getSharedObject()

local isDead = false
local bdv_f5 = {
    quitterjob = 1,
    Indexdoor = 1,
    minimapveh = 1,
    casqueautomatique = 1,
    menuadroite = 1,
    disableaboiementchien = 1,
    disablesongambiant = 1,
    DoorState = {
        FrontLeft = false,
        FrontRight = false,
        BackLeft = false,
        BackRight = false,
        Hood = false,
        Trunk = false
    },
}


function BedaveF5()
    local playerPed = PlayerPedId()
    local playerName = GetPlayerName(PlayerId())
    local Pagination = GetResourceKvpInt('MENU_LENGTH') or 1
    local menuf5 = CoraUI.CreateMenu(playerName, 'Menu Personnel')
    local submenu1 = CoraUI.CreateSubMenu(menuf5, playerName, 'Informations')
    local submenu2 = CoraUI.CreateSubMenu(menuf5, playerName, 'Documents')
    local submenu3 = CoraUI.CreateSubMenu(menuf5, playerName, 'Vehicules')
    local submenu4 = CoraUI.CreateSubMenu(menuf5, playerName, 'Préférences')
    local submenu5 = CoraUI.CreateSubMenu(menuf5, playername, 'Touches')
    local submenu6 = CoraUI.CreateSubMenu(menuf5, playername, 'Commandes')
    local submenu7 = CoraUI.CreateSubMenu(submenu4, playername, 'Signalements')
    CoraUI.Visible(menuf5, not CoraUI.Visible(menuf5))
    while menuf5 do
    Citizen.Wait(0)
    CoraUI.IsVisible(menuf5, function()
        CoraUI.Button('Informations', nil, {RightLabel = ">>>"}, true, {}, submenu1)
        CoraUI.Button('Documents Officiels', nil, {RightLabel = ">>>"}, true, {}, submenu2)
        if IsPedSittingInAnyVehicle(PlayerPedId()) then 
        CoraUI.Button('Véhicule', nil, {RightLabel = ">>>"}, true, {
            onSelected = function()
            end
        }, submenu3)
    else
        CoraUI.Button('Véhicule', "Vous devez etre dans un véhicule", {RightLabel = ">>>"}, false, {
            onSelected = function()
            end
        })
    end
    CoraUI.Button('Préférences', nil, {RightLabel = ">>>"}, true, {
        onSelected = function()
        end
    }, submenu4)
    CoraUI.Button('Touche du serveur', nil, {RightLabel = ">>>"}, true, {
        onSelected = function()
        end
    }, submenu5)
    CoraUI.Button('Commandes du serveur', nil, {RightLabel = ">>>"}, true, {
        onSelected = function()
        end
    }, submenu6)
    -- CoraUI.Button('Caméra photo', nil, {RightLabel = ">>>"}, true, {
    --     onSelected = function()
    --         ESX.ShowNotification("Pas terminé")
    --     end
    -- })
    end)
    CoraUI.IsVisible(submenu1, function()
        CoraUI.Button('Métier: ~b~'..ESX.PlayerData.job.label..'~s~', nil, {}, true, {})
        CoraUI.Button('Métier secondaire: ~b~'..ESX.PlayerData.job2.label..'~s~', nil, {}, true, {})

        
        for i = 1, #ESX.PlayerData.accounts, 1 do
          if ESX.PlayerData.accounts[i].name == 'bank' then
            CoraUI.Button('Espéce: ~g~'.. ESX.PlayerData.accounts[i].money..'$~s~', nil, {}, true, {})
          elseif ESX.PlayerData.accounts[i].name == 'money' then
            CoraUI.Button('Banque: ~g~'.. ESX.PlayerData.accounts[i].money..'$~s~', nil, {}, true, {})
          elseif ESX.PlayerData.accounts[i].name == 'black_money' then
            CoraUI.Button('Argent Sale: ~r~'.. ESX.PlayerData.accounts[i].money..'$~s~', nil, {}, true, {})
          end
        end
      end)
      CoraUI.IsVisible(submenu2, function()
        CoraUI.Button('Regarder ma ~b~carte d\'identité~s~', nil, {RightLabel = ">>"}, true, {
            onSelected = function()
                TriggerServerEvent("jsfour-idcard:open", GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
            end
        })
        CoraUI.Button('Montrer ma ~r~carte d\'identité~s~', nil, {RightLabel = ">>"}, true, {
            onSelected = function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestDistance ~= -1 and closestDistance <= 3.0 then
                    TriggerServerEvent("jsfour-idcard:open", GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
                else
                    ESX.ShowNotification("Aucun joueurs aux alentours")
                end
            end
        })

        CoraUI.Button('Regarder mon ~b~permis voiture~s~', nil, {RightLabel = ">>"}, true, {
            onSelected = function()
                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                if closestDistance ~= -1 and closestDistance <= 3.0 then
                    TriggerServerEvent("jsfour-idcard:open", GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), "driver")
                else
                    ESX.ShowNotification("Aucun joueurs aux alentours")
                end
            end
        })
        CoraUI.Button('Montrer mon ~r~permis voiture~s~', nil, {RightLabel = ">>"}, true, {
            onSelected = function()
                TriggerServerEvent("jsfour-idcard:open", GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), "driver")
            end
        })
    end)
    CoraUI.IsVisible(submenu3, function()
        local taputedemere = GetVehiclePedIsUsing(PlayerPedId())    
        local sahdumppas = GetEntityModel(taputedemere)
        local platevehhhhhhhh = GetVehicleNumberPlateText(GetVehiclePedIsIn(PlayerPedId()), false)
        local modelevehhhhhhh = GetDisplayNameFromVehicleModel(sahdumppas)

        CoraUI.List("Ouvrir / Fermer porte", {"Avant gauche", "Avant Droite", "Arrière Gauche", "Arrière Droite", "Capot", "Coffre"}, bdv_f5.Indexdoor, nil, {}, true, {
            onListChange = function(index)
                bdv_f5.Indexdoor = index 
            end,
            onSelected = function(index)
                
                if index == 1 then
                    if not bdv_f5.DoorState.FrontLeft then
                        bdv_f5.DoorState.FrontLeft = true
                        SetVehicleDoorOpen(taputedemere, 0, false, false)
                    elseif bdv_f5.DoorState.FrontLeft then
                        bdv_f5.DoorState.FrontLeft = false
                        SetVehicleDoorShut(taputedemere, 0, false, false)
                    end
                elseif index == 2 then
                    if not bdv_f5.DoorState.FrontRight then
                        bdv_f5.DoorState.FrontRight = true
                        SetVehicleDoorOpen(taputedemere, 1, false, false)
                    elseif bdv_f5.DoorState.FrontRight then
                        bdv_f5.DoorState.FrontRight = false
                        SetVehicleDoorShut(taputedemere, 1, false, false)
                    end
                elseif index == 3 then
                    if not bdv_f5.DoorState.BackLeft then
                        bdv_f5.DoorState.BackLeft = true
                        SetVehicleDoorOpen(taputedemere, 2, false, false)
                    elseif bdv_f5.DoorState.BackLeft then
                        bdv_f5.DoorState.BackLeft = false
                        SetVehicleDoorShut(taputedemere, 2, false, false)
                    end
                elseif index == 4 then
                    if not bdv_f5.DoorState.BackRight then
                        bdv_f5.DoorState.BackRight = true
                        SetVehicleDoorOpen(taputedemere, 3, false, false)
                    elseif bdv_f5.DoorState.BackRight then
                        bdv_f5.DoorState.BackRight = false
                        SetVehicleDoorShut(taputedemere, 3, false, false)
                    end
                elseif index == 5 then 
                    if not bdv_f5.DoorState.Hood then
                        bdv_f5.DoorState.Hood = true
                        SetVehicleDoorOpen(taputedemere, 4, false, false)
                    elseif bdv_f5.DoorState.Hood then
                        bdv_f5.DoorState.Hood = false
                        SetVehicleDoorShut(taputedemere, 4, false, false)
                    end
                elseif index == 6 then 
                    if not bdv_f5.DoorState.Trunk then
                        bdv_f5.DoorState.Trunk = true
                        SetVehicleDoorOpen(taputedemere, 5, false, false)
                    elseif bdv_f5.DoorState.Trunk then
                        bdv_f5.DoorState.Trunk = false
                        SetVehicleDoorShut(taputedemere, 5, false, false)
                    end
                end
            end
        })

        CoraUI.Button("Fermer toutes les portes", nil, {RightLabel =  ">>>"}, true, {
            onSelected = function ()
                for door = 0, 7 do
                    SetVehicleDoorShut(taputedemere, door, false)
                end
            end
        })

        CoraUI.Button('Allumer/arrêter le moteur', nil, {RightLabel = ">>>"}, true, {
            onSelected = function()
                if GetIsVehicleEngineRunning(taputedemere) then
                    SetVehicleEngineOn(taputedemere, false, false, true)
                    SetVehicleUndriveable(taputedemere, true)
                    ESX.ShowNotification("Moteur arrêter")
                elseif not GetIsVehicleEngineRunning(taputedemere) then
                    SetVehicleEngineOn(taputedemere, true, false, true)
                    SetVehicleUndriveable(taputedemere, false)
                    ESX.ShowNotification("Moteur allumer")
                end
            end
        })

        CoraUI.Button('Information du véhicule', nil, {RightLabel = ">>>"}, true, {
            onActive = function()
                CoraUI.Info('Véhicules Information ',
                {"Modéles:", "Plaque:",},
                {modelevehhhhhhh, platevehhhhhhhh})
            end,
            onSelected = function()
            end
        })

    end)
    CoraUI.IsVisible(submenu4, function()
        CoraUI.Button('Signalement rapide', nil, {RightLabel = ">>>"}, true, {
            onSelected = function()
                ESX.ShowNotification("Pas terminé")
            end
        }, submenu7)
        CoraUI.List('Longueur du menu', {"15", "20"}, Pagination, nil, {}, true, {
            onListChange = function(index)
                Pagination = index
                SetResourceKvpInt('MENU_LENGTH', index)
            end
        })

        CoraUI.Checkbox("Menu à droite", nil, menuadroite, {}, {
            onChecked = function()
                menuadroite = true
                SetResourceKvpInt('MENU_ALIGNMENT', 1)
            end,
            onUnChecked = function()
                menuadroite = false
                SetResourceKvpInt('MENU_ALIGNMENT', 2)
            end
        })

        CoraUI.Checkbox("Casque Automatique", nil, casqueautomatique, {}, {
            onChecked = function()
                casqueautomatique = true
                ESX.ShowNotification("Casque automatique activé")
                EnableHelmet()
            end,
            onUnChecked = function()
                casqueautomatique = false
                ESX.ShowNotification("Casque automatique désactivé")
                DisableHelmet()
            end
        })

        CoraUI.Checkbox("Afficher Minimap hors véhicule", nil, minimapveh, {}, {
            onChecked = function()
                minimapveh = true
                ESX.ShowNotification("Afficher minimap")
                SetRadarAsExteriorThisFrame()
                DisplayRadar(true)
            end,
            onUnChecked = function()
                minimapveh = false
                ESX.ShowNotification("Masquer minimap")
                DisplayRadar(false)
            end
        })

        CoraUI.Checkbox("Désactiver aboiements des chiens", nil, disableaboiementchien, {}, {
            onChecked = function()
                disableaboiementchien = true
                ESX.ShowNotification("Aboiements désactiver")
                DisableDogBarking(true)
            end,
            onUnChecked = function()
                disableaboiementchien = false
                ESX.ShowNotification("Aboiements activer")
                DisableDogBarking(false)
            end
        })

        CoraUI.Checkbox("Désactiver les sons ambiants", nil, disablesongambiant, {}, {
            onChecked = function()
                disablesongambiant = true
                SetResourceKvpInt('AMBIANT_SOUND_DISABLED', 2)
            end,
            onUnChecked = function()
                disablesongambiant = false
                SetResourceKvpInt('AMBIANT_SOUND_DISABLED', 1)
            end
        })
    end)
    CoraUI.IsVisible(submenu5, function()
        for i = 1, #ConfigF5.Touche do 
            local v = ConfigF5.Touche[i]
            CoraUI.Button(v[1], v[3], {RightLabel = v[2]}, true, {})
        end
    end)
    CoraUI.IsVisible(submenu6, function()
        for i = 1, #ConfigF5.Commandes do 
            local v = ConfigF5.Commandes[i]
            CoraUI.Button(v[1], v[3], {RightLabel = v[2]}, true, {})
        end
    end)
    CoraUI.IsVisible(submenu7, function()
        CoraUI.Button("Signalé un FreeKill", nil, {RightLabel = ""}, true, {
            onSelected = function()
                ExecuteCommand("report J'ai besoin d'aide par apport à une FreeKill")
            end
        })
        CoraUI.Button("Signalé un FreePunch", nil, {RightLabel = ""}, true, {
            onSelected = function()
                ExecuteCommand("report J'ai besoin d'aide par apport à une FreePunch")
            end
        })
        CoraUI.Button("Signalé un FreeTaze", nil, {RightLabel = ""}, true, {
            onSelected = function()
                ExecuteCommand("report J'ai besoin d'aide par apport à une FreeTaze")
            end
        })
        CoraUI.Button("Signalé un MassRP", nil, {RightLabel = ""}, true, {
            onSelected = function()
                ExecuteCommand("report J'ai besoin d'aide par apport à un MassRP")
            end
        })
        CoraUI.Button("Signalé un PowerGaming", nil, {RightLabel = ""}, true, {
            onSelected = function()
                ExecuteCommand("report J'ai besoin d'aide par apport à un PowerGaming")
            end
        })
        CoraUI.Button("Signalé un MetaGaming", nil, {RightLabel = ""}, true, {
            onSelected = function()
                ExecuteCommand("report J'ai besoin d'aide par apport à un MetaGaming")
            end
        })
        CoraUI.Button("Signalé un FreeLoot", nil, {RightLabel = ""}, true, {
            onSelected = function()
                ExecuteCommand("report J'ai besoin d'aide par apport à un FreeLoot")
            end
        })
    end)
        if not CoraUI.Visible(menuf5) and not CoraUI.Visible(submenu1) and not CoraUI.Visible(submenu2) and not CoraUI.Visible(submenu3) and not CoraUI.Visible(submenu4) and not CoraUI.Visible(submenu5) and not CoraUI.Visible(submenu6) and not CoraUI.Visible(submenu7) then
          break
      end
    end
end

RegisterCommand('tuconnaisondevpasaveclespiednous', function()
    if not isDead then
	    BedaveF5()
    else
        ESX.ShowNotification("Impossible d'ouvrir un menu en etant mort")
    end
end, false)

RegisterKeyMapping('tuconnaisondevpasaveclespiednous', "Menu F5", 'keyboard', 'F5')


AddEventHandler('esx:onPlayerDeath', function() isDead = true end)
AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)