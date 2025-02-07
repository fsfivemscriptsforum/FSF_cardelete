RegisterCommand("deletecar", function(source, args, rawCommand)
    local playerPed = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)
    
    if vehicle ~= 0 then
        NetworkRequestControlOfEntity(vehicle)
        local timeout = 2000
        while timeout > 0 and not NetworkHasControlOfEntity(vehicle) do
            Wait(100)
            timeout = timeout - 100
        end
        
        if NetworkHasControlOfEntity(vehicle) then
            SetEntityAsMissionEntity(vehicle, true, true)
            DeleteVehicle(vehicle)
            DeleteEntity(vehicle)
            lib.notify({
                title = "FSF Cardelete",
                description = "Jármű törölve!",
                type = "success"
            })
        else
            lib.notify({
                title = "FSF Cardelete",
                description = "Nem sikerült törölni a járművet!",
                type = "error"
            })
        end
    else
        lib.notify({
            title = "FSF Cardelete",
            description = "Nem ülsz járműben!",
            type = "error"
        })
    end
end, false)

RegisterKeyMapping("deletecar", "Jármű törlése", "keyboard", "H")
