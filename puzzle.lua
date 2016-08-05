local composer = require( "composer" )
local scene = composer.newScene( sceneName )


local w       = display.contentWidth		-- Design width, height, and center <x,y> positions.
local h       = display.contentHeight
local centerX = display.contentWidth/2 
local centerY = display.contentHeight/2
local xInset = display.contentWidth / 20
local yInset = display.contentHeight / 20							
local puzzleName = "driehoek"

local puzzlePieces = {}						-- Table used to store the puzzle pieces.
local gameStatusMsg							-- Empty variable that will be used to store the handle to a text object 
local puzzleArea							-- Empty variable that will be used to store the handle to a rectangle.
local piecesTray={}						-- Empty variable that will be used to store the handle to a rectangle.
local pieces = {}									-- This rectangle is the location where the puzzle pieces will be placed
local correct = 0
local images = {"driehoek.png","hart.png","reghoek.png","sirkel.png","ster.png","vierkant.png"}
local imglist = {}
local cur = 1
local back
local drawPuzzle
local puzzlegroup = display.newGroup()

function flip(obj)
        transition.to(obj,{xScale=obj.xScale*1,yScale=obj.yScale*1,onComplete=(function(e) transition.to( obj, {xScale=-obj.xScale,time=1000} ) end)})
        transition.to(obj,{delay = 1000,alpha = 1})
    end

    local lyfSound = audio.loadStream( "vorms.mp3" )

local function playPart(start,dd)
    audio.stop( )
audio.seek( start, lyfSound )
audio.play( lyfSound, { duration=dd } )
end
function clear()
correct = 0
print(#pieces)	
for j=1,#piecesTray do
	piecesTray[j]:removeSelf()
end
for i = 1, #puzzlePieces do
puzzlePieces[i]:removeSelf()
end
for i = 1, #imglist do

if puzzledone[i] == 1 then
imglist[i].alpha = 1
			else
			imglist[i].alpha = 0.5
			end
end
puzzlePieces = {}	
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
local function drag( event )
	if event.phase == "began" then
		markX = event.target.x    -- store x location of object
		markY = event.target.y    -- store y location of object
		display.getCurrentStage():setFocus( event.target )
		began = true
	elseif event.phase == "moved" then
	
		if(began)then
		local x = (event.x - event.xStart) + markX
		local y = (event.y - event.yStart) + markY
		
		event.target.x, event.target.y = x, y    -- move object based on calculations above
		end
	elseif event.phase == "ended" or event.phase == "cancelled" then
		local hit = false
		for i=1,#puzzlePieces do
			if(hasCollided(puzzlePieces[i],event.target))then
				if(puzzlePieces[i].pos == event.target.pos)then
					puzzlePieces[i].alpha = 1
					event.target.alpha = 0
					correct = correct + 1
					hit = true
				end
			end
		end
		if(hit==false)then
			transition.to(event.target,{time = 500,x=markX,y=markY})
		end
		if correct == 4 then
				--flip(back)
				correct = 0
				for i = 1, #puzzlePieces do
				puzzlePieces[i].alpha = 0
				end
				local back = display.newImage(puzzleName .. ".png")
				
				if(puzzleName =="reghoek")then
					back:scale((xInset * 8)/back.contentWidth,(xInset * 4)/back.contentHeight)
				else
					back:scale((xInset * 8)/back.contentWidth,(xInset * 8)/back.contentHeight)
				end
				
				back.x = xInset * 4
				back.y = yInset * 8
				flip(back)
				--back.alpha = 0

				for i = 1, #imglist do

				if puzzledone[i] == 1 then
				imglist[i].alpha = 1
							else
							imglist[i].alpha = 0.5
							end
				end
				puzzlePieces = {}	
				timer.performWithDelay( 2500, (function(e)
					back:removeSelf() 
					for i = 1, #images do
						if puzzleName .. ".png" == images[i] then
							puzzledone[i] = 1
							local c = display.newImage("arrow.png")
						local s = 30*0.8/c.contentHeight
						c:scale(s,s)
						c.y = imglist[i].y
						c.x = imglist[i].x
						imglist[i]._functionListeners = nil
		  				imglist[i]._tableListeners = nil
						sceneGroup:insert(c)
						end
					end

					--Go to random puzzle
					local dome = {}
					for i = 1, #images do
						if puzzledone[i] == 0 then
							dome[#dome+1] = i
						end
					end

					if (#dome == 0) then --Done all of them, go home
						puzzledone = {0,0,0,0,0,0}
						clear() composer.gotoScene( "menu", "fade", 500 )
					else
						numb = dome[math.random( #dome )]
						puzzleName=string.gsub(images[numb],".png","") clear() 
						imglist[numb].alpha = 1 
						drawPuzzle(images[numb])
						play(images[numb])
					end

					--gameStatusMsg.isVisible = false
					end))
		
		end
		began = false
		display.getCurrentStage():setFocus(nil)
	end
	return true
end
function drawPuzzle(part)
	print(part)
    	puzzleName=string.gsub(part,".png","") 
        
		local nrPieces = 4
		for j=1,4 do
			   		local piece = display.newImage(puzzleName.."_"..j..".png")
					if(puzzleName =="reghoek")then
						piece:scale((xInset*4)/piece.contentWidth,(xInset*2)/piece.contentHeight)
					else
						piece:scale((xInset*4)/piece.contentWidth,(xInset*4)/piece.contentHeight)
					end
				
					puzzlegroup:insert(piece)
					piece.pos = j
					piece:addEventListener("touch",drag)
					pieces[j] = piece
					piecesTray[j] =piece
		end
       for i=1,4 do
	   		local temp = display.newImage(puzzleName.."_"..i..".png")
			  
				if(puzzleName =="reghoek")then
					temp:scale((xInset*4)/temp.contentWidth,(xInset*2)/temp.contentHeight)
				else
					temp:scale((xInset*4)/temp.contentWidth,(xInset*4)/temp.contentHeight)
				end
			   
			   temp.pos = i
				
				
			   puzzlePieces[i] =  temp
			   puzzlegroup:insert(temp)
			   temp:toBack()
			   
			   temp.alpha = 0.5
			if(i==1)then
				temp.x = xInset*2.5
				temp.y = yInset*4
				local r = math.random(nrPieces)
				local curPiece = pieces[r]
				curPiece.x = display.contentWidth - xInset*4
				curPiece.y = display.contentHeight - yInset*9
				table.remove(pieces,r)
				nrPieces = nrPieces - 1
			elseif(i==2)then
				temp.x = xInset*2.5+temp.contentWidth
				temp.y = yInset*4
				local r = math.random(nrPieces)
				local curPiece = pieces[r]
				curPiece.x = display.contentWidth - xInset*4 - curPiece.contentWidth - xInset/2
				curPiece.y = display.contentHeight - yInset*9
				table.remove(pieces,r)
				nrPieces = nrPieces - 1
			elseif(i==3)then
				temp.x = xInset*2.5
				temp.y = yInset*4+temp.contentHeight
				local r = math.random(nrPieces)
				local curPiece = pieces[r]
				curPiece.x = display.contentWidth - xInset*4
				curPiece.y = display.contentHeight - yInset*9 - curPiece.contentHeight - yInset/2
				table.remove(pieces,r)
				nrPieces = nrPieces - 1
			else
				temp.x = xInset*2.5+temp.contentWidth
				temp.y = yInset*4+temp.contentHeight
				local r = math.random(nrPieces)
				local curPiece = pieces[r]
				curPiece.x = display.contentWidth - xInset*4 - curPiece.contentWidth - xInset/2
				curPiece.y = display.contentHeight - yInset*9 - curPiece.contentHeight - yInset/2
				table.remove(pieces,r)
				nrPieces = nrPieces - 1
			end
	   end
	   back:toBack()
   
end

function scene:create( event )
	sceneGroup = self.view
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	back = display.newImage("whitebg.png")
    back:scale((display.actualContentWidth-10)/back.width,(display.actualContentHeight-1)/back.height)
    back.x = display.contentWidth/2
    back.y = display.contentHeight/2
    sceneGroup:insert(back)
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then

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

    local speechtext = display.newText( "Uyakwazi ukuhlanganisa \ni-puzzle?", speech.x, speech.y, speech.contentWidth/1.3,0,teachersPetFont,20 )
    speechtext:setFillColor( 0 )

		timer.performWithDelay( 2000, (function(e)
			r.alpha = 0
			z.alpha = 0
			speech.alpha = 0
			speechtext.alpha = 0
			drawPuzzle(images[1])
			sceneGroup:insert(puzzlegroup)
			home = display.newImage("home.png")
			        home:scale((xInset*2)/home.contentWidth,(xInset*2)/home.contentHeight)
			        home.x = -((display.actualContentWidth-display.contentWidth)/2-home.contentWidth/2)
			        home.y = home.y + home.contentHeight/2
			        sceneGroup:insert(home)
					    home:addEventListener( "tap", (function (e) clear() composer.gotoScene( "menu", "fade", 500 ) end)) 

			clearbtn = display.newImage("refresh.png")
			        clearbtn:scale((xInset*2)/clearbtn.contentWidth,(xInset*2)/clearbtn.contentHeight)
			        clearbtn.x = (display.actualContentWidth-clearbtn.contentWidth*1.2)
			        clearbtn.y = home.y
			        sceneGroup:insert(clearbtn)
			        clearbtn:addEventListener( "tap", (function (e) puzzledone = {0,0,0,0,0,0} clear()  composer.removeScene( "puzzle") composer.gotoScene( "puzzle" ) end)) 

			        play("driehoek.png")

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

			if puzzledone[i] == 1 then
				local c = display.newImage("arrow.png")
				local s = 60*0.8/c.contentHeight
				c:scale(s,s)
				c.y = img.y
				c.x = img.x
				sceneGroup:insert(c)
			else
			img.alpha = 0.5
			end
			img:addEventListener( "tap", (function(e) 
			puzzleName=string.gsub(images[i],".png","") 
			clear() 
			drawPuzzle(images[i])
			imglist[i].alpha = 1 
			
			end) )
			sceneGroup:insert(img)
		end
		
		imglist[1].alpha = 1
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
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene