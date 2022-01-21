
dofile(LockOn_Options.script_path.."Systems/circuitBreakerHandles.lua")

function post_initialize()
    local birth = LockOn_Options.init_conditions.birth_place
    
    if birth=="GROUND_HOT" or birth=="AIR_HOT" then
        lowAlt = 90
        hiAlt = 500
        updateAPN209()
    elseif birth=="GROUND_COLD" then
        
    end
end

function updateAPN209()
    -- TODO DO PROPERLY
    get_param_handle("RDR_ALT_BRIGHTNESS"):set(1)

    isOn = lowAlt > 0 and paramCB_RdrAltm:get() > 0

    paramLoBug:set(lowAlt)
    paramHiBug:set(hiAlt)

    if isOn then
        paramFlag:set(1)

        radarAltitude = clamp((sensor_data:getRadarAltitude() * meters_to_feet) - 8, 0, 1500) -- accounts for suspension height

        local digit1 = getDigit(radarAltitude, 4)
        local digit2 = getDigit(radarAltitude, 3)
        local digit3 = getDigit(radarAltitude, 2)
        local digit4 = getDigit(radarAltitude, 1)

        if radarAltitude < 10 then
            digit3 = 10
        end
        if radarAltitude < 100 then
            digit2 = 10
        end
        if radarAltitude < 1000 then
            digit1 = 10
        end

        if radarAltitude > 1500 then
            paramDigit1:set(1)
            paramDigit2:set(1)
            paramDigit3:set(1)
            paramDigit4:set(1)
        end
        --print_message_to_user("alt: "..radarAltitude.." 1: "..digit1.." 2: "..digit2.." 3: "..digit3.." 4: "..digit4)

        paramDigit1:set(digit1)
        paramDigit2:set(digit2)
        paramDigit3:set(digit3)
        paramDigit4:set(digit4)
        paramNeedle:set(radarAltitude)

        if radarAltitude < lowAlt then
            paramLoLight:set(1)
        else
            paramLoLight:set(0)
        end

        if radarAltitude > hiAlt then
            paramHiLight:set(1)
        else
            paramHiLight:set(0)
        end
    else
        paramDigit1:set(10)
        paramDigit2:set(10)
        paramDigit3:set(10)
        paramDigit4:set(10)
        paramLoLight:set(0)
        paramHiLight:set(0)
        paramFlag:set(0)
    end
end
