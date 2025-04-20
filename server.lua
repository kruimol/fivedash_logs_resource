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
            VerifyToken = Config.VerifyToken,
            ServiceName = GetCurrentResourceName()
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

SetHttpHandler(function(request, response)
    if request.method == 'GET' and request.path == '/ping' then -- if a GET request was sent to the `/ping` path
        response.writeHead(200, { ['Content-Type'] = 'application/json' }) -- set the response status code to `200 OK` and the body content type to plain text
        response.send('{"succes": true, "message": "pong"}') -- respond to the request with `pong`
    else -- otherwise
        response.writeHead(404) -- set the response status code to `404 Not Found`
        response.send() -- respond to the request with no data
    end
end)

