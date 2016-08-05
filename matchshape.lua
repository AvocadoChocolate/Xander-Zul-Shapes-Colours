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

local sceneGroup

local thing

local places = {}
local done = false

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )

function flip(obj)
        transition.to(obj,{xScale=obj.xScale*1.2,yScale=obj.yScale*1.2,onComplete=(function(e) transition.to( obj, {xScale=-obj.xScale,time=1000} ) end)})
        transition.to(obj,{delay = 1000,alpha = 1})
    end

    local lyfSound = audio.loadStream( "vorms.mp3" )

local function playPart(start,dd)
    audio.stop( )
audio.seek( start, lyfSound )
audio.play( lyfSound, { duration=dd } )
end

local function play(part)
    print(part)
    if part == "vierkant.png" then
        local lyfSound = audio.loadStream( "square.mp3" )
        audio.play( lyfSound )
    elseif part == "driehoek.png" then
        local lyfSound = audio.loadStream( "triangle.mp3" )
        audio.play( lyfSound )
    elseif part == "hart.png" then
        local lyfSound = audio.loadStream( "heart.mp3" )
        audio.play( lyfSound )
    elseif part == "sirkel.png" then
        local lyfSound = audio.loadStream( "circle.mp3" )
        audio.play( lyfSound )
    elseif part == "reghoek.png" then
        local lyfSound = audio.loadStream( "rectangle.mp3" )
        audio.play( lyfSound )
    elseif part == "ster.png" then
        local lyfSound = audio.loadStream( "star.mp3" )
        audio.play( lyfSound )
    end
end

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

local function hasCollided( obj1, obj2 )
    if ( obj1 == nil ) then  -- Make sure the first object exists
        return false
    end
    if ( obj2 == nil ) then  -- Make sure the other object exists
        return false
    end

    local left = obj1.contentBounds.xMin <= obj2.contentBounds.xMin and obj1.contentBounds.xMax >= obj2.contentBounds.xMin
    local right = obj1.contentBounds.xMin >= obj2.contentBounds.xMin and obj1.contentBounds.xMin <= obj2.contentBounds.xMax
    local up = obj1.contentBounds.yMin <= obj2.contentBounds.yMin and obj1.contentBounds.yMax >= obj2.contentBounds.yMin
    local down = obj1.contentBounds.yMin >= obj2.contentBounds.yMin and obj1.contentBounds.yMin <= obj2.contentBounds.yMax

    return (left or right) and (up or down)
end

local function move( event )
    if event.phase == "began" then
		
        event.target.markX = event.target.x    -- store x location of object
        event.target.markY = event.target.y
        
        display.getCurrentStage():setFocus( event.target, event.id )
		event.target.isFocus = true

	elseif event.target.isFocus then
	
    	if event.phase == "moved" then
	
        	local x = (event.x - event.xStart) + event.target.markX
        	local y = (event.y - event.yStart) + event.target.markY
        
        	event.target.x = x    -- move object based on calculations above
        	event.target.y = y
    	elseif event.phase == "ended" or event.phase == "cancelled"  then
    	
    	display.getCurrentStage():setFocus( nil )
                    event.target.isFocus = false
                    
               		if (thing.tag == event.target.tag) then
               			if (hasCollided(event.target,thing)) then
                      event.target.alpha = 0
                      flip(thing) 

                      timer.performWithDelay( 2500, (function(e) 
                        thing:removeSelf()
                      thing = nil
                      event.target:removeSelf()
                      event.target = nil
                      dome[#dome] = nil
                      
                      if (#dome == 0) then
                      composer.gotoScene("menu", "fade", 500)
                      else
                      thing = display.newImage(dome[#dome])
                      play(dome[#dome])
                      thing.x = display.contentWidth/2
                      thing.y = display.contentHeight/2.5
                      thing.alpha = 0.5
                      thing.tag = dome[#dome]
                      sceneGroup:insert(thing)
                      thing:scale(display.contentHeight/thing.contentHeight/1.8,display.contentHeight/thing.contentHeight/1.8)
                       end end)) 						
							--end
							else
               			event.target.x = event.target.markX
               			event.target.y = event.target.markY
               			end
               		else
               			event.target.x = event.target.markX
               			event.target.y = event.target.markY
               		end
               end
    end
    
    return true
end

function scene:show( event )
    sceneGroup = self.view
    local phase = event.phase
    
     back = display.newImage("whitebg.png")
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

    local speechtext = display.newText( "Ungakwazi ukuthola umumo\nongena khaxa?", speech.x, speech.y,speech.contentWidth/1.3,0,teachersPetFont,20 )
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
		    home:addEventListener( "tap", (function (e) composer.gotoScene( "menu" , "fade", 500) end)) 

        clear = display.newImage("refresh.png")
        clear:scale(0.4,0.4)
        clear.x = (display.actualContentWidth-clear.contentWidth*1.2)
        clear.y = home.y
        sceneGroup:insert(clear)
        clear:addEventListener( "tap", (function (e) composer.removeScene( "matchshape") composer.gotoScene( "matchshape", "fade", 500 ) end)) 
		
		shuffleTable(dome)
		
		thing = display.newImage(dome[#dome])
    play(dome[#dome])
		thing.x = display.contentWidth/2
		thing.y = display.contentHeight/2.5
		thing.alpha = 0.5
		thing.tag = dome[#dome]
		sceneGroup:insert(thing)
		thing:scale(display.contentHeight/thing.contentHeight/1.8,display.contentHeight/thing.contentHeight/1.8)

    --flip(thing)    
		
		rect = display.newRoundedRect(display.contentWidth/2,display.contentHeight*0.85,display.actualContentWidth*0.9,60,10)
        rect:setFillColor( 0.5 )
        rect.alpha = 0.05
        sceneGroup:insert(rect)
        rect.strokeWidth = 2
		rect:setStrokeColor( 0.5 )
		
		for i=1,#images do
			local img = display.newImage(images[i])
			local s = 60*0.8/img.contentHeight
			img:scale(s,s)
			img.y = rect.y
			img.x = display.contentWidth*i/7
			img.tag = images[i]
			imglist[#imglist+1] = img
			img:addEventListener( "touch", move )
			sceneGroup:insert(img)
		end
        end))
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
