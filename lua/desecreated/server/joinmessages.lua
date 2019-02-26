hook.Add( "PlayerConnect", "msgPlayerConnected", function( Name, IP )
    
    IpData = string.Explode( ":", IP)
    
    print( "Checking IP address " .. IpData[1] )
    
    http.Fetch( "http://ip-api.com/json/" .. IpData[1], 
    
        -- If request succeeded
        function( Result )
        
            local GeoIPData = util.JSONToTable( Result )
            local PlayerLocale = GeoIPData["country"] or "a secret laboratory"
            
            if GeoIPData["city"] ~= nil and string.len( GeoIPData["city"] ) > 0 then
                
                PlayerLocale = GeoIPData["city"] .. ", " .. PlayerLocale
                
            end
            
            local PlayerProvider = "the NSA supercomputer"
            
            if GeoIPData["isp"] ~= nil and string.len( GeoIPData["isp"] ) > 0 then
                
                PlayerProvider = GeoIPData["isp"]
                
            elseif GeoIPData["org"] ~= nil and  string.len( GeoIPData["org"] ) > 0 then
                
                PlayerProvider = GeoIPData["org"]
                
            end 
            
            PrintTable( GeoIPData )
            chat.AddText( Color(   0, 180, 250 ), Name,
                          Color( 250, 250, 250 ), " is connecting from ", 
                          Color( 250, 180,   0 ), PlayerLocale,
                          Color( 250, 250, 250 ), " via ",
                          Color( 250, 100,  80 ), PlayerProvider )
        
        end, 
        
        -- If request failed
        function( Reason )
            
            print( "Request failed: " .. Reason )
            chat.AddText( Color( 0, 180, 250 ), Name, Color( 250, 250, 250 ), " is connecting" )
            
        end, nil )
    
end)

-- TODO: Player spawned
hook.Add( "PlayerInitialSpawn", "msgPlayerInitialSpawn", function( _Player )
    
    chat.AddText( Color( 0, 180, 250 ), _Player:GetName(), Color( 250, 180, 0 ), " " .. _Player:SteamID(), Color( 250, 250, 250 ), " has spawned " )
    
end )

-- TODO: Player disconnected
hook.Add( "PlayerDisconnected", "msgPlayerDisconnected", function( _Player )

    chat.AddText( Color( 0, 180, 250 ), _Player:GetName(), Color( 250, 250, 250 ), " has disconnected" )

end )