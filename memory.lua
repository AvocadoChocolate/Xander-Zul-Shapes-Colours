---------------------------------------------------------------------------------
--
-- scene.lua
--
---------------------------------------------------------------------------------

local sceneName = ...

local speech = {"Siyakuhalalisela.", "Manje.", "Siyakuhalalisela."}
local dialog = {}
local speechtext = {}

local composer = require( "composer" )

local images = {"driehoek.png","hart.png","reghoek.png","sirkel.png","ster.png","vierkant.png"}

local dome = {"driehoek.png","hart.png","reghoek.png","sirkel.png","ster.png","vierkant.png"}

local imglist = {}
local cantap = true

local sceneGroup

local thing
local matchescount = 0

local places = {}
local done = false

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

_W = display.contentWidth; -- Returns Screen Width
_H = display.contentHeight; -- Returns Screen Height
 
local totalButtons = 0 --Track total on screen buttons
 
local secondSelect = 0 -- Track if first or second button select
local checkForMatch = false --Let the app know when to check for matches
 
x = display.contentWidth/2 --Set starting point for button grid

local button = {}
local buttonCover = {}

local chooser = {"1.png","2.png","3.png","4.png","5.png","6.png","7.png","8.png","9.png","10.png","11.png","12.png"}

local buttonImages = {}

for i=1,4 do
chose = math.random(#chooser)
buttonImages[2*i] = chooser[chose];
buttonImages[2*i-1] = chooser[chose];
table.remove(chooser,chose)
end

--local buttonImages = {1,1, 2,2, 3,3, 4,4}
 
--Declare and prime a last button selected variable
--local lastButton = display.newImage("1.png");   
--lastButton.myName = 1;

---------------------------------------------------------------------------------
function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

local function shuffleTable( t )
    local rand = math.random 
    assert( t, "shuffleTable() expected a table, got nil" )
    local iterations = #t
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        t[i], t[j] = t[j], t[i]
    end
end

function game(object, event)
    if cantap == false then
        return
    end
    if(event.phase == "began") then             
        if(checkForMatch == false and secondSelect == 0) then
            --Flip over first button
            --buttonCover[object.number].isVisible = false;
            transition.to(buttonCover[object.number],{xScale=object.xScale*0.7,yScale=object.yScale*0.7,time=200})
            transition.to(buttonCover[object.number],{delay=200,time=200,xScale=0,onComplete=(function(e) buttonCover[object.number].isVisible = false end)})
            object.xScale = 0.0001
            object.yScale = object.yScale*0.7
            --transition.to(object,{xScale=object.xScale*0.7,yScale=object.yScale*0.7})
            transition.to(object,{delay=400,xScale=object.yScale})
            transition.to(object,{delay=800,time=200,xScale=0.45,yScale=0.45})
            lastButton = object
            checkForMatch = true            
        elseif(checkForMatch == true) then
            if(secondSelect == 0) then
                cantap = false
                --Flip over second button
                transition.to(buttonCover[object.number],{xScale=object.xScale*0.7,yScale=object.yScale*0.7,time=200})
            transition.to(buttonCover[object.number],{delay=200,time=200,xScale=0,onComplete=(function(e) buttonCover[object.number].isVisible = false end)})
            object.xScale = 0.0001
            object.yScale = object.yScale*0.7
            --transition.to(object,{xScale=object.xScale*0.7,yScale=object.yScale*0.7})
            transition.to(object,{delay=400,xScale=object.yScale})
            transition.to(object,{delay=800,time=200,xScale=0.45,yScale=0.45})
                secondSelect = 1;
                --If buttons do not match, flip buttons back over
                if(lastButton.myName ~= object.myName) then
                    --matchText.text = "Match Not Found!";
                    timer.performWithDelay(1250, function()                     
                        --matchText.text = " ";
                        checkForMatch = false;
                        secondSelect = 0;
                        transition.to(buttonCover[lastButton.number],{delay=200,xScale=buttonCover[lastButton.number].yScale})
                        transition.to(buttonCover[lastButton.number],{delay=800,time=200,xScale=0.45,yScale=0.45})
                        transition.to(buttonCover[object.number],{delay=200,xScale=buttonCover[lastButton.number].yScale})
                        transition.to(buttonCover[object.number],{delay=800,time=200,xScale=0.45,yScale=0.45, onComplete=(function(e) 
                            object.xScale = 0.45
                            object.yScale = 0.45
                            lastButton.xScale = 0.45
                            lastButton.yScale = 0.45
                            cantap = true
                            end)})
                        transition.to(object,{delay=200,xScale=0.001})
                        transition.to(object,{delay=0,time=200,xScale=object.xScale*0.7,yScale=object.yScale*0.7})
                        transition.to(lastButton,{delay=200,xScale=0.001})
                        transition.to(lastButton,{delay=0,time=200,xScale=object.xScale*0.7,yScale=object.yScale*0.7})
                        buttonCover[lastButton.number].isVisible = true;
                        buttonCover[object.number].isVisible = true;
                    end, 1)                 
                --If buttons DO match, remove buttons
                elseif(lastButton.myName == object.myName) then
                    --matchText.text = "Match Found!";
                    cantap = true
                    timer.performWithDelay(1250, function()                     
                        --matchText.text = " ";

                        matchescount = matchescount+1
                        if matchescount == 4 then
                            composer.gotoScene( "menu" , "fade", 500)
                        end

                        checkForMatch = false;
                        secondSelect = 0;
                        lastButton:removeSelf();
                        object:removeSelf();
                        buttonCover[lastButton.number]:removeSelf();
                        buttonCover[object.number]:removeSelf();
                    end, 1) 
                end             
            end         
        end
    end
end



function scene:show( event )
    sceneGroup = self.view
    local phase = event.phase
    
     back = display.newImage("bg.jpg")
    back:scale((display.actualContentWidth-10)/back.width,(display.actualContentHeight-1)/back.height)
    back.x = display.contentWidth/2
    back.y = display.contentHeight/2
    sceneGroup:insert(back)

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
    elseif phase == "did" then
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc

        local r = display.newRect( display.contentWidth/2, display.contentHeight/2, display.actualContentWidth, display.actualContentHeight )
    r:setFillColor( 0 )
    r.alpha = 0.5

    local z = display.newImage( "zander.png" )
    z:scale(0.4,0.4)
    z.y = display.contentHeight/2
    z.x = display.contentWidth/2+z.contentWidth

    local speech = display.newImage("speech.png")
    speech:scale(0.2,0.4)
    speech.y = display.contentHeight/2 - speech.contentHeight/2
    speech.x = z.x - speech.contentWidth/2-z.contentWidth

    local speechtext = display.newText( "Bheka amakhadi amabili \nahambisanayo.", speech.x, speech.y,speech.contentWidth/1.3,0,teachersPetFont,20 )
    speechtext:setFillColor( 0 )

    timer.performWithDelay( 2000, (function(e)
            r.alpha = 0
            z.alpha = 0
            speech.alpha = 0
            speechtext.alpha = 0
        
        home = display.newImage("home.png")
        home:scale(0.4,0.4)
        home.x = -((display.actualContentWidth-display.contentWidth)/2-home.contentWidth/2)
        home.y = home.y + home.contentHeight/2
        sceneGroup:insert(home)
            home:addEventListener( "tap", (function (e) composer.gotoScene( "menu", "fade", 500 ) end)) 

        clear = display.newImage("refresh.png")
        clear:scale(0.4,0.4)
        clear.x = (display.actualContentWidth-clear.contentWidth*1.2)
        clear.y = home.y
        sceneGroup:insert(clear)
        clear:addEventListener( "tap", (function (e) composer.removeScene( "memory") composer.gotoScene( "memory" ) end)) 
        
		
		--Place buttons on screen
for count = 1,4 do
    x = display.contentWidth/2 + display.contentWidth/5*(count-3)
     
    for insideCount = 1,2 do
        y = display.contentHeight/2
         
        --Assign each image a random location on grid
        temp = math.random(1,#buttonImages)
        button[count] = display.newImage(buttonImages[temp]); 
        sceneGroup:insert(button[count])
        button[count]:scale(0.45,0.45)            
        --Position the button
        button[count].x = x+button[count].contentWidth/2*1.2;
        
        if insideCount == 1 then
        button[count].y = y + button[count].contentHeight/2*1.2;  
        else
        button[count].y = y - button[count].contentHeight/2*1.2;  
        end      
         
        --Give each a button a name
        button[count].myName = buttonImages[temp]
        button[count].number = totalButtons
         
        --Remove button from buttonImages table
        table.remove(buttonImages, temp)
         
--Set a cover to hide the button image      
        buttonCover[totalButtons] = display.newImage("card.png");
        sceneGroup:insert(buttonCover[totalButtons])
         buttonCover[totalButtons]:scale(0.45,0.45)
        buttonCover[totalButtons].x = button[count].x--x+buttonCover[totalButtons].contentWidth/2;
         
        if insideCount == 1 then
        buttonCover[totalButtons].y = button[count].y -- display.contentHeight/4 --+ buttonCover[totalButtons].contentHeight/2;  
        else
        buttonCover[totalButtons].y = button[count].y --y + display.contentHeight/4 - buttonCover[totalButtons].contentHeight/2;  
        end 

        totalButtons = totalButtons + 1
         
        --Attach listener event to each button
        button[count].touch = game      
        button[count]:addEventListener( "touch", button[count] )


    end

end end))
        
    end 
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        -- Called when the scene is on screen and is about to move off screen
        --
        -- INSERT code here to pause the scene
        -- e.g. stop timers, stop animation, unload sounds, etc.)
    elseif phase == "did" then
        -- Called when the scene is now off screen
		if nextSceneButton then
			nextSceneButton:removeEventListener( "touch", nextSceneButton )
		end
    end 
end

function scene:destroy( event )
    local sceneGroup = self.view

    -- Called prior to the removal of scene's "view" (sceneGroup)
    -- 
    -- INSERT code here to cleanup the scene
    -- e.g. remove display objects, remove touch listeners, save state, etc
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
---------------------------------------------------------------------------------

return scene
