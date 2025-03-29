local scriptSource = [[
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end

    if getgenv().Index then
        script_key = getgenv().Index.Start.Options.License
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Flockaa0001/333/main/school.lua"))()
    end
]]

loadstring(scriptSource)()
