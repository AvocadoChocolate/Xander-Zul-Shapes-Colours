local sceneName = ...

local composer = require( "composer" )
local Gesture = require("lib_gesture")

-- Load scene with same root filename as this file
local scene = composer.newScene( sceneName )
local images = {}
local texts = {}
local current = 1
local descs = {}

local home = {}
local sound = {}
local voice = {}
local r = {}

local rect = {}
local recttext = {}
local soundb = {}

local sceneGroup

local play = true
local shouldadd = true

local startx = 0 
local starty = 0

local imagesl = {"vierkant.png","driehoek.png","hart.png","sirkel.png","reghoek.png","ster.png"}
local imglist = {}
local bottomimg = {}

local lyfSound = audio.loadStream( "vorms.mp3" )

local function playPart(start,dd)
    audio.stop( )
audio.seek( start, lyfSound )
audio.play( lyfSound, { duration=dd } )
end

local function play(part)
    audio.stop()
    print(part)
    if part == "isikwele" then
        local lyfSound = audio.loadStream( "square.mp3" )
        audio.play( lyfSound )
    elseif part == "unxantathu" then
        local lyfSound = audio.loadStream( "triangle.mp3" )
        audio.play( lyfSound )
    elseif part == "inhliziyo" then
        local lyfSound = audio.loadStream( "heart.mp3" )
        audio.play( lyfSound )
    elseif part == "indingilizi" then
        local lyfSound = audio.loadStream( "circle.mp3" )
        audio.play( lyfSound )
    elseif part == "unxande" then
        local lyfSound = audio.loadStream( "rectangle.mp3" )
        audio.play( lyfSound )
    elseif part == "inkanyezi" then
        local lyfSound = audio.loadStream( "star.mp3" )
        audio.play( lyfSound )
    end
end

--[[ var kleurklanke = new Howl({
  urls: ['sounds/kleure.mp3', 'sounds/kleure.ogg'],
  sprite: {
    rooi: [0, 700],
    blou: [1000, 400],
    groen: [1500, 500],
    geel: [2300, 700],
    pers: [3100, 600],
    oranje: [3850, 700]
  }
});

var vormklanke = new Howl({
  urls: ['sounds/vorms.mp3', 'sounds/vorms.ogg'],
  sprite: {
    sirkel: [0, 700],
    vierkant: [860, 800],
    reghoek: [1700, 900],
    driehoek: [2800, 800],
    ster: [3800, 700],
    hart: [4600, 700]
  }
}); --]]

local savex = {}
local setme = true

Groep = {image = "", text = "", sound = "", speech=""}

function Groep:new (text, image, sound, speech)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  self.text = text or ""
  self.image = image or ""
  self.sound = sound or "";
  self.speech = speech or ""
  return o
end

local t1 = {text="isikwele",image="vierkant.png",sound="vwortel.mp3"}
local t2 = {text="unxantathu",image="driehoek.png",sound="vboontjie.mp3"}
local t3 = {text="inhliziyo",image="hart.png",sound="vkomkommer.mp3"}
local t4 = {text="indingilizi",image="sirkel.png",sound="vuie.mp3"}
local t6 = {text="inkanyezi",image="ster.png",sound="vsoetrisse.mp3"}
local t5 = {text="unxande",image="reghoek.png",sound="vspinasie.mp3"}


local animals = {t6,t5,t4,t3,t2,t1}

math.randomseed( os.time() )

local function SoundHere()
audio.stop()
local s = audio.loadStream( animals[current].speech)
audio.play(s)
play=true
play(texts[current].text)

r.alpha = 1
descs[current].alpha = 1
texts[current].alpha = 1
--play(texts[current].text)
end

local enterAnimal = function(obj)
for i=1, #images do 
	texts[i].alpha = 0
	--descs[i].alpha = 0
	
	if (bottomimg[i]) then
	bottomimg[i].alpha = 0.5
	end
end
r.alpha = 0
r:removeSelf()
r = display.newRoundedRect( texts[current].x, texts[current].y, texts[current].contentWidth*1.2, texts[current].contentHeight*1.2, 10 )
        
        if setme == true then
        savex = texts[current].x
        elseif current == #animals then
        r.x = savex
        end
        
        r:setFillColor(0.9,0.9,0.9)
        sceneGroup:insert(r)
       if ( bottomimg[current]) then
bottomimg[#bottomimg-current+1].alpha = 1
end
texts[current]:toFront()

play(texts[current].text)

	--if play then
	
	print(s)
	transition.to(descs[current], {delay = 500, time = 500, alpha = 1})
	transition.to(texts[current], {delay = 500, time = 500, alpha = 1}) --, onComplete=SoundHere})
	
	transition.to(r, {time=200, alpha = 1})
	transition.to(rect, {time=200, alpha = 1})
	transition.to(recttext, {time=200, alpha = 1})
	transition.to(soundb, {time=200, alpha = 1})
	
	--play = false
	--end
end

local nextSceneButton

function scene:create( event )
    local sceneGroup = self.view

    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
end

local function soundplay(event)
if ( event.phase == "began" ) then

        elseif ( event.phase == "moved" ) then
            print( "moved phase" )

        elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
        --audio.stop()
--local s = audio.loadStream( animals[current].sound)
--audio.play(s)
--play(texts[current].text)
       -- media.stopSound()
        --    media.playSound(animals[current].sound)
        end

    --return true

end

local function RemoveStuffies()
        home:removeSelf()
        home = nil
        --voice:removeSelf()
        --voice = nil
        --sound:removeSelf()
        --sound = nil
        
        media.stopSound()
        
        local count = #animals
        
        for i=1, count do 
        if images[i] then
        	--sceneGroup:remove(images[i])
        	--images[i].alpha = 0
        	images[i]:removeEventListener( "touch", soundplay)
        --	images[i].alpha = 0
        	images[i]:removeSelf()
        	images[i] = nil
        	
        	--sceneGroup:remove(text[i])
        --	texts[i].alpha = 0
        	texts[i]:removeSelf() 
        	texts[i] = nil
        	end
        	end
end

local function tohome(event)
if ( event.phase == "began" ) then

        elseif ( event.phase == "moved" ) then
            print( "moved phase" )

        elseif ( event.phase == "ended" or event.phase == "cancelled" ) then
        RemoveStuffies()
            composer.gotoScene( "menu", { effect = "fade", time = 300 } )
            
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
        current = #animals
        for i=1, #animals do 
        	images[i] = display.newImage(animals[i].image)
        	images[i].x = display.contentWidth/4 + display.contentWidth*1.2*(current-i)
        	images[i].y = display.contentHeight/2.4
        	images[i]:addEventListener( "touch", soundplay )
        	--if string.sub(system.getInfo("model"),1,2) == "iP" then
        	--images[i]:scale(0.5,0.5)
        	--else
        	local s = display.contentWidth/2/(images[i].contentWidth+120)
        	local s2 = display.contentHeight/(images[i].contentHeight+120)
        	
        	if (s > s2) then
        	images[i]:scale(s2,s2)
        	else
        	images[i]:scale(s,s)
        	end
        	--end
        	sceneGroup:insert(images[i])
        	
        	        local options = 
{
    --parent = textGroup,
    text = animals[i].text,     
    x = display.contentWidth*0.6,
    y = display.contentHeight*0.3,
    --width = 328,     --required for multi-line and alignment
    font = teachersPetFont,   
    fontSize = 30,
    align = "center"  --new alignment parameter
}	
        	texts[i] = display.newText(options)
        	texts[i].alpha = 0
        	
        	if i == 1 then
        	local z = display.newImage("zander.png")
    z:scale(0.4,0.4)
    z.x = texts[i].x + texts[i].contentWidth/2 + z.contentWidth
    z.y = display.contentHeight/2 - 10
    sceneGroup:insert(z)
        	end
        	
        	if animals[i].text == "isikwele" then
        	texts[i]:setFillColor(41/255,171/255,226/255)
        	elseif animals[i].text == "unxantathu" then
        	texts[i]:setFillColor(247/255,147/255,30/255)
        	elseif animals[i].text == "inhliziyo" then
        	texts[i]:setFillColor(255/255,31/255,31/255)
        	elseif animals[i].text == "indingilizi" then
        	texts[i]:setFillColor(255/255,221/255,63/255)
        	elseif animals[i].text == "inkanyezi" then
        	texts[i]:setFillColor(0/255,222/255,0/255)
        	elseif animals[i].text == "unxande" then
        	texts[i]:setFillColor(144/255,37/255,207/255)
        	else       	
        	texts[i]:setFillColor(0,0,0)
        	end
  	
        	sceneGroup:insert(texts[i])
        	print(texts[i].text)
        	
        	        	        local options = 
					{
   					 --parent = textGroup,
   					 text = animals[i].desc,     
   					 x = display.contentWidth-display.contentWidth/4,
  					  y = display.contentHeight*0.5,
  					  width = display.contentWidth/2-50,     --required for multi-line and alignment
  					  font = "TeachersPet",   
  					  fontSize = 20,
  					  align = "center"  --new alignment parameter
					}
	
        end
        rectr = display.newRoundedRect(display.contentWidth/2,display.contentHeight*0.85,display.actualContentWidth*0.9,60,10)
        rectr:setFillColor( 0.5 )
        rectr.alpha = 0
        sceneGroup:insert(rectr)
        rectr.strokeWidth = 2
		rectr:setStrokeColor( 0.5 )
		
		for i=1,#images do
			local img = display.newImage(imagesl[i])
			local s = 60*0.8/img.contentHeight
			img:scale(s,s)
			img.y = rectr.y
			img.x = display.contentWidth*i/7
			img.tag = imagesl[i]
			imglist[#imglist+1] = img
			img.alpha = 0.5
			bottomimg[#bottomimg+1] = img
			img:addEventListener( "tap", (function() 
                current=#images-i+2 
                local s = {}
                if current > #images then 
                    current = #images+1
                    s = audio.loadStream( animals[current-1].sound)
                else
                    s= audio.loadStream( animals[current].sound)
                    end 
                    
                    audio.play(s) 
                    SwipeLeft() 
                    end))
			sceneGroup:insert(img)
		end
        texts[1].alpha = 1
        --descs[1].alpha = 1
        
        r = display.newRoundedRect( texts[1].x, texts[1].y, texts[1].contentWidth*1.2, texts[1].contentHeight*1.2, 10 )
        
        r:setFillColor(0.9,0.9,0.9)
        sceneGroup:insert(r)
        
        home = display.newImage("home.png")
        home:scale(0.4,0.4)
        home.x = -((display.actualContentWidth-display.contentWidth)/2-home.contentWidth/2)
        home.y = home.y + home.contentHeight/2
		home:addEventListener( "touch", tohome )
		
		enterAnimal()
		setme = false
    end 
end

function distance ( x1, y1, x2, y2 )
  local dx = x1 - x2
  local dy = y1 - y2
  return math.sqrt ( dx * dx + dy * dy )
end

local function Update(event)		
	if "began" == event.phase then
startx = event.x
		starty = event.y
	
	elseif "moved" == event.phase then

	
	elseif "ended" == event.phase or "cancelled" == event.phase then
	
	if distance(startx,starty,event.x,event.y) > 20 then
			if Gesture.GestureResult() == "SwipeR" then
			print("right")
			SwipeRight()
			elseif Gesture.GestureResult() == "SwipeL" then
			print("left")
			SwipeLeft()
			end
			else
			--speechplay(event)
		end
	end
end

function SwipeRight()
audio.stop()

if current == #images then
return
end

current = current + 1

for i=1, #images do 
	texts[i].alpha = 0
	bottomimg[i].alpha = 0.5
end

for i=1, #images do 
	--transition.to( images[i], { time=500, x=images[i].x+display.contentWidth} )
	transition.to( images[i], { time=500, x=display.contentWidth/4 + display.contentWidth*1.2*(current-i), onComplete=enterAnimal} )
	transition.to( texts[i], { time=500,  x = display.contentWidth*0.6 + display.contentWidth*(current-i)} )
	
	transition.to(r, {time=200, alpha = 0})
	transition.to(rect, {time=200, alpha = 0})
	transition.to(recttext, {time=200, alpha = 0})
	transition.to(soundb, {time=200, alpha = 0})
        end
end

function SwipeLeft()
audio.stop()

if current == 1 then
--return
RemoveStuffies()
            composer.gotoScene( "menu", { effect = "fade", time = 300 } )
            
end

current = current - 1

for i=1, #images do 
	texts[i].alpha = 0
	bottomimg[i].alpha = 0.5
end

for i=1, #images do 
	transition.to( images[i], { time=500, x=display.contentWidth/4 + display.contentWidth*1.2*(current-i), onComplete=enterAnimal} )
	transition.to( texts[i], { time=500,  x = display.contentWidth*0.6 + display.contentWidth*(current-i)} )
	
	transition.to(r, {time=200, alpha = 0})
	transition.to(rect, {time=200, alpha = 0})
	transition.to(recttext, {time=200, alpha = 0})
	transition.to(soundb, {time=200, alpha = 0})
        end
end

function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase

    if event.phase == "will" then
        Runtime:removeEventListener( "touch", Update )
        
    elseif phase == "did" then
        -- Called when the scene is now off screen
		if nextSceneButton then
			nextSceneButton:removeEventListener( "touch", nextSceneButton )
		end
		
	end 
end


function scene:destroy( event )
    local sceneGroup = self.view
end

Runtime:addEventListener( "touch", Update )

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
