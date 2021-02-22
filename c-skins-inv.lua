local LocalPlayer = game:GetService("Players").LocalPlayer
local Client = getsenv(game.Players.LocalPlayer.PlayerGui.Client)
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local allSkins = {
   {'P2000_Silence'},
   {'USP_Unseen'},
   {'Glock_Wetland'},
   {'DualBerettas_Hexline'},
   {'P250_Frosted'},
   {'FiveSeven_Stigma'},
   {'Tec9_Ironline'},
   {'CZ_Lightning'},
   {'DesertEagle_Glittery'},
   {'R8_Spades'},
   {'MP9_Blueroyal'},
   {'MAC10_Wetland'},
   {'MP7-SD_Stock'},
   {'MP7_Silent Ops'},
   {'UMP_Gum Drop'},
   {'P90_Elegant'},
   {'Bizon_Shattered'},
   {'Nova_Tiger'},
   {'XM_Spectrum'},
   {'MAG7_Outbreak'},
   {'SawedOff_Opal'},
   {'M249_P2020'},
   {'Negev_Wetland'},
   {'Famas_Goliath'},
   {'Galil_Worn'},
   {'M4A4_Desert Camo'},
   {'M4A1_Tecnician'},
   {'AK47_Code Orange'},
   {'Scout_Railgun'},
   {'AUG_Chilly Night'},
   {'AUG_NightHawk'},
   {'SG_Kitty Cat'},
   {'AWP_Desert Camo'},
   {'G3SG1_Foliage'},
   {'Fingerless Glove_Digital'},
   {'Strapped Glove_Wisk'},
   {'Sports Glove_Majesty'},
   {'Handwraps_Wraps'},
   {'Karambit_Splattered'},
   {'Butterfly Knife_Stock'},
   {'Butterfly Knife_Splattered'},
   {'Falchion Knife_Splattered'},
   {'Bayonet_Splattered'},
   {'Huntsman Knife_Splattered'},
   {'Gut Knife_Splattered'},
   {'CTKnife_Stock'},
   {'TKnife_Stock'},
   {'Bearded Axe_Splattered'},
   {'Sickle_Stock'},
   {'Sickle_Splattered'},
   {'Sickle_Mummy'},
   {'Cleaver_Splattered'},
   {'Flip Knfie_Stock'},
   {'Banana_Stock'}
}

local isUnlocked

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall
setreadonly(mt, false)

local isUnlocked

mt.__namecall = newcclosure(function(self, ...)
   local args = {...}
   if getnamecallmethod() == "InvokeServer" and tostring(self) == "Hugh" then
    return
   end
   if getnamecallmethod() == "FireServer" then
    if args[1] == LocalPlayer.UserId then
        return
    end
    if string.len(tostring(self)) == 38 then
        if not isUnlocked then
         isUnlocked = true
         for i,v in pairs(allSkins) do
          local doSkip
          for i2,v2 in pairs(args[1]) do
              if v[1] == v2[1] then
               doSkip = true
              end
          end
          if not doSkip then
              table.insert(args[1], v)
          end
         end
        end
        return
    end
    if tostring(self) == "DataEvent" and args[1][4] then
        local currentSkin = string.split(args[1][4][1], "_")[2]
        if args[1][2] == "Both" then
         LocalPlayer["SkinFolder"]["CTFolder"][args[1][3]].Value = currentSkin
         LocalPlayer["SkinFolder"]["TFolder"][args[1][3]].Value = currentSkin
        else
         LocalPlayer["SkinFolder"][args[1][2] .. "Folder"][args[1][3]].Value = currentSkin --NineR
        end
    end
   end
   return oldNamecall(self, ...)
end)
   
setreadonly(mt, true)

Client.CurrentInventory = allSkins

local TClone, CTClone = LocalPlayer.SkinFolder.TFolder:Clone(), game.Players.LocalPlayer.SkinFolder.CTFolder:Clone()
LocalPlayer.SkinFolder.TFolder:Destroy()
LocalPlayer.SkinFolder.CTFolder:Destroy()
TClone.Parent = LocalPlayer.SkinFolder
CTClone.Parent = LocalPlayer.SkinFolder
