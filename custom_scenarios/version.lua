-- version.lua

local resourceName = GetCurrentResourceName()
local localVersionFile = LoadResourceFile(resourceName, "version.txt")
local localVersion = localVersionFile and localVersionFile:match("[^\r\n]+")

local githubRawURL = "https://raw.githubusercontent.com/YourGitHubUsername/your-repo/main/version.txt"

PerformHttpRequest(githubRawURL, function(statusCode, response, headers)
    if statusCode == 200 then
        local remoteVersion = response:match("[^\r\n]+")
        if remoteVersion ~= localVersion then
            print("^1[" .. resourceName .. "] UPDATE AVAILABLE!^7")
            print("^3Current Version:^7 " .. tostring(localVersion))
            print("^2Latest Version:^7 " .. tostring(remoteVersion))
            print("^3Update Here:^7 https://github.com/YourGitHubUsername/your-repo")
        else
            print("^2[" .. resourceName .. "] is up to date (v" .. localVersion .. ")^7")
        end
    else
        print("^1[" .. resourceName .. "] Failed to check version from GitHub (HTTP " .. statusCode .. ")^7")
    end
end, "GET", "", { ["Content-Type"] = "text/plain" })
