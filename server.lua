local isAuth = false

if (Config.ApiToken == "" or Config.VerifyToken == "") then
    print("FiveDash: No Api or Verify token pleas")
else
    -- PerformHttpRequest("http://fivedash.nl/api/logs/fivem/auth", function (errorCode, resultData, resultHeaders, errorData)
    PerformHttpRequest("http://localhost:3000/api/fivem/logs/auth",
        function(errorCode, resultData, resultHeaders, errorData)
            if errorCode == 200 then
                isAuth = true
                print("isAuth")
            else
                print("Not authorized")
            end
        end, 'POST', json.encode({
            ApiToken = Config.ApiToken,
            VerifyToken = Config.VerifyToken
        }), {
            ['Content-Type'] = 'application/json'
        })
end

exports('addlog', function(category, loginfo)
    if isAuth then
        PerformHttpRequest("http://localhost:3000/api/fivem/logs/addlog",
        function(errorCode, resultData, resultHeaders, errorData)
            print(errorCode)
            if errorCode == 200 then
                print(resultData)
            end
        end, 'PUT', json.encode({
            ApiToken = Config.ApiToken,
            VerifyToken = Config.VerifyToken,
            category = category,
            loginfo = loginfo
        }), {
            ['Content-Type'] = 'application/json'
        })
    end
end)

