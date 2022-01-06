--[[
    Coordmaster - undetected way of teleporting.
    Bypasses most of games' anti-teleport.
    
    Soon I will add new feature to this script: Coordfly.
]]

local coordmaster = {};
local debounce = false;

function coordmaster:Teleport(position, step_length, step_delay, callback)
    if step_length == nil then return warn("[Coordmaster] Step length is nil/undefined."); end if step_delay == nil then return warn("[Coordmaster] Delay is nil/undefined."); end

    if not debounce then
        if typeof(position) == "CFrame" or typeof(position) == "Vector3" then
            if game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart") ~= nil then
                debounce = true;

                local current_position = game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position;
                local steps = math.floor(math.sqrt((position.X - current_position.X) ^ 2 + (position.Y - current_position.Y) ^ 2 + (position.Z - current_position.Z) ^ 2 ) / step_length);
                local path = {};

                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = true;

                for i=1, steps do
                    path[#path+1] = {
                        x = current_position.X + ((position.X - current_position.X) / steps) * i,
                        y = current_position.Y + ((position.Y - current_position.Y) / steps) * i,
                        z = current_position.Z + ((position.Z - current_position.Z) / steps) * i,
                    }
                end
                path[#path+1] = {x = position.X, y = position.Y, z = position.Z};

                for i=1, steps do
                    wait(step_delay);
                    game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame = CFrame.new(path[i].x, path[i].y, path[i].z);
                end

                game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Anchored = false;
                wait(2);
                callback();

                debounce = false;
                wait(2.5);
            end
        end
    else
        return;
    end
end

return coordmaster;
