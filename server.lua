local isAuth = false

if(Config.ApiToken == "" || Config.VerifyToken == "") then
    print("FiveDash: No Api or Verify token pleas")
else 
    PerformHttpRequest("http://fivedash.nl/api/logs/fivem/auth", function (errorCode, resultData, resultHeaders, errorData)
        print("Returned error code:" .. tostring(errorCode))
        print("Returned data:" .. tostring(resultData))
        print("Returned result Headers:" .. tostring(resultHeaders))
        print("Returned error data:" .. tostring(errorData))
    end, 'POST', json.encode({ ApiToken = Config.ApiToken, VerifyToken = Config.VerifyToken }))
end


exports('addlog', function(category, loginfo)
    print(category)
    print(json.encode(loginfo))
end)