local sceneName = ...

local _transition_time = 500

local displayTouchPointCircles
local removeTouchPointCircles
local touchPointCircles = { }
local effects ={{0, 900},{970, 400}}

local lineStartX, lineStartY

local phonetic = { {0,300},{500,300},{900,450},{1400,400},{1900,400},{2340,560},{3000,600},{3700, 500},{4300, 400},{4700, 600},{5400, 400},{6100, 500},{6800, 800},{7800, 700},{8700, 400},{9200, 400},{9800, 400},{10400, 700},{11300, 800},{12300, 300},{12700, 400},{13300, 700},{14100, 800},{15100, 800},{16100, 600},{16800, 700}}
local isVir = {{0, 1600},{1800, 1800},{3800, 2000},{6200, 2000},{8400, 1800},{10400, 2200},{12700, 1900},{15000, 2000},{17200, 1800},{19400, 2000},{21600, 2400},{24200, 1800},{26200, 2400},{28800, 2300},{31400, 2200},{34000, 1600},{35800, 2000},{37800, 2200},{40000, 2200},{42400, 2000},{44600, 1800},{46800, 2200},{49200, 2400},{51600, 3200},{54800, 2200},{57200, 2200}}
--local p = audio.loadSound( "phoneticalphabet.mp3"  )
--local e = audio.loadSound( "effects.mp3"  )
--local isVirSound = audio.loadSound( "isvir.mp3"  )

local active = true

local imagesl = {"vierkant.png","driehoek.png","hart.png","sirkel.png","reghoek.png","ster.png"}
local imglist = {}
local images = {}
local bottomimg = {}

local lyfSound = audio.loadStream( "vorms.mp3" )

local function playPart(start,dd)
    audio.stop( )
audio.seek( start, lyfSound )
audio.play( lyfSound, { duration=dd } )
end

local function play(part)
    print(part)
    if part == "A" then
        local lyfSound = audio.loadStream( "square.mp3" )
        audio.play( lyfSound )
    elseif part == "B" then
        local lyfSound = audio.loadStream( "triangle.mp3" )
        audio.play( lyfSound )
    elseif part == "C" then
        local lyfSound = audio.loadStream( "heart.mp3" )
        audio.play( lyfSound )
    elseif part == "D" then
       local lyfSound = audio.loadStream( "circle.mp3" )
        audio.play( lyfSound )
    elseif part == "E" then
        local lyfSound = audio.loadStream( "rectangle.mp3" )
        audio.play( lyfSound )
    elseif part == "F" then
        local lyfSound = audio.loadStream( "star.mp3" )
        audio.play( lyfSound )
    end
end

local PlayP = function(letter)
print(letter)
	if letter == 1 then
		play("A")
	elseif letter == 2 then
		play("B")
	elseif letter == 3 then
		play("C")
	elseif letter == 4 then
		play("D")
	elseif letter == 5 then
		play("E")
	else
		play("F")
	end
--'	local playing = audio.play(p)
--	'audio.seek( phonetic[letter][1], playing ) 
--	'audio.stopWithDelay(phonetic[letter][2], { channel=playing })
end
local PlayEffect = function(oneORtwo)
	--local playing3 = audio.play(e)
--	audio.seek( effects[oneORtwo][1], playing3 ) 
--	audio.stopWithDelay(effects[oneORtwo][2], { channel=playing3 })
end

local function PlayIsVir(letter)
--	local playing2 = audio.play(isVirSound)
--	audio.seek( isVir[letter][1], playing2 ) 
--	audio.stopWithDelay(isVir[letter][2], { channel=playing2 })
end

local colors = {{102/255, 0, 1},{1,0,0},{0, 153/255, 1},{1,204/255,0},{1, 153/255, 0},{0,153/255,0}}
local coordsTable = { 	A = { { 160, 65 }, { 260, 65 }, { 350, 65 }, { 160, 255 }, { 260, 255 }, { 350, 255 }, { 160, 160 }, { 350, 160 } },
						B = { { 255, 65 }, { 200, 160 }, { 310, 160  }, { 150, 256 }, { 250, 256 }, { 360, 256 } },
						C = { { 255, 90 }, { 155, 90 }, { 205, 65 }, { 165, 180 }, { 205, 225 }, { 150, 140 }, { 255, 260 }, { 355, 90 }, { 305, 65 }, { 345, 180 }, { 305, 225 }, { 360, 140 } },
						D = { { 255, 65 }, { 180, 90 }, { 205, 75 }, { 160, 180 }, { 190, 225 }, { 160, 140 }, { 255, 255 }, { 325, 90 }, { 305, 75 }, { 345, 180 }, { 325, 225 }, { 350, 140 } },
						E = { { 258, 65 }, {225, 133}, {150, 133}, {210,182},{190, 258},{257, 218},{323, 258},{300, 185},{360, 134},{286, 134}},
						F = { { 130, 83 }, { 130, 164 }, { 130, 241 }, { 240, 237 }, { 375, 239 }, { 380, 165 }, { 380, 82 }, { 255, 81 } }
					}

local dubbelLetters={ "aA","bB","cC","dD","eE","fF","gG","hH","iI","jJ","kK","lL","mM","nN","oO","pP","qQ","rR","sS","tT","uU","vV","wW","xX","yY","zZ" } 
local isVir				
local success = false	
						
local cloneTable 					
local coordsScalingFactorX, coordsScalingFactorY
local strokeWidth = 12
local strokeColor = colors[3]
local checkHits
local composer = require( "composer" )

local scene = composer.newScene( sceneName )
local curCoords
local fingerPaint = require( "fingerPaint")

local drawingLine
local lineStarted = false		--

local strokes = nil
local strokesTable = { }
local curTrace
local writeFile, writeToFile, openFile, closeFile
---------------------------------------------------------------------------------
local clippingContainer, xanderSuccess, xanderGroup
local kiesLetterBtn, kiesLetterTeelsGroup, shadedBG, closeBtn, slideImg, changeStrokeColor
local curDierImage, curText, curMask
local whitebg
local xInset = display.contentWidth / 20
local yInset = display.contentHeight / 20
local cWidth = display.contentWidth
local cHeight = display.contentHeight
local curSlide
local diere ={"apie","beer","cheetah","donkie","eend","flamink","gorilla","haai","inkvis","jakkals","kameelperd","leeu","meerkat","nagapie","olifant","pou","quagga","renoster","skilpad","takbok","uil","volstruis","walvis","xander","ystervark","zebra"}
local letters={"A","B","C","D","F","E"}

local isDrawing
local stopDrawing
local drawOnText
local sceneGroup

changeToLetter = function (event)
	local t = event.target
	if event.phase == "ended" then
		if(curSlide < t.Pos) then
			nextSlide(t.Pos - 1)
			shadedBG:removeSelf()
			kiesLetterTeelsGroup:removeSelf()
			slideImg:removeSelf()
			closeBtn:removeSelf()
			
		elseif(curSlide > t.Pos) then
			prevSlide(t.Pos + 1)
			shadedBG:removeSelf()
			kiesLetterTeelsGroup:removeSelf()
			slideImg:removeSelf()
			closeBtn:removeSelf()
		end
	end
	return true
end

changeStrokeColor = function (event)
	local t = event.target
	if event.phase == "ended" then
		
		strokeColor = colors[t.pos]
		if strokes ~= nil then
		for i = #strokes, 1, -1 do
				strokes[ i ]:removeSelf()
		end
		end
		strokes = nil
		shadedBG:removeSelf()
		kiesLetterTeelsGroup:removeSelf()
			
	end
	
	return true
end

closeKeuse = function (event)
	local t = event.target
	if event.phase == "ended" then
		shadedBG:removeSelf()
		kiesLetterTeelsGroup:removeSelf()
		slideImg:removeSelf()
		t:removeSelf()
	end
end
slideListenerTeels = function ( event )
	local curSlide = kl.getCurLetterSet()
	if event.phase == "ended" then
		if draggedLeft( event.xStart, event.x ) then
			--print(curSlide.." left")
			if curSlide < 5 then
				
				transition.to(kiesLetterTeelsGroup, {time = _transition_time, x = kiesLetterTeelsGroupX - cWidth } )
				nextLetterGroup = display.newGroup()
				nextLetterGroup.x = display.contentCenterX - xInset*4 + cWidth
				nextLetterGroup.y = display.contentCenterY - yInset
				local letterTeelsTable = kl.nextSetLetters(curSlide)
				for i= 1,#letterTeelsTable do
					kiesTeel = unpack(letterTeelsTable,i)
					--print(kiesTeel.Pos)
					if i <= 3 then
						kiesTeel.y = - yInset * 4
						kiesTeel.x = 4 * xInset * (i-1)
					else
						kiesTeel.y = yInset * 4
						kiesTeel.x = 4 * xInset * (i-4)
					end
					kiesTeel:addEventListener("touch",changeToLetter)
					nextLetterGroup:insert(kiesTeel)
				end
				transition.to(nextLetterGroup, {time = _transition_time, x = nextLetterGroup.x - cWidth } )
				kiesLetterTeelsGroup = nil
				kiesLetterTeelsGroup = nextLetterGroup
			end
			
		elseif draggedRight( event.xStart, event.x ) then
			--print(curSlide.." right")
			if curSlide > 1 then
				transition.to(kiesLetterTeelsGroup, {time = _transition_time, x = kiesLetterTeelsGroupX + cWidth } )
				nextLetterGroup = display.newGroup()
				nextLetterGroup.x = display.contentCenterX - xInset*4 - cWidth
				nextLetterGroup.y = display.contentCenterY - yInset
				local letterTeelsTable = kl.prevSetLetters(curSlide)
				for i= 1,#letterTeelsTable do
					kiesTeel = unpack(letterTeelsTable,i)
					--print(kiesTeel.letter)
					if i <= 3 then
						kiesTeel.y = - yInset * 4
						kiesTeel.x = 4 * xInset * (i-1)
					else
						kiesTeel.y = yInset * 4
						kiesTeel.x = 4 * xInset * (i-4)
					end
					kiesTeel:addEventListener("touch",changeToLetter)
					nextLetterGroup:insert(kiesTeel)
				end
				transition.to(nextLetterGroup, {time = _transition_time, x = nextLetterGroup.x + cWidth } )
				kiesLetterTeelsGroup = nil
				kiesLetterTeelsGroup = nextLetterGroup
			end
		end
	end
	return true
end	

function scene:create( event )
     sceneGroup = self.view
    -- Called when the scene's view does not exist
    -- 
    -- INSERT code here to initialize the scene
    -- e.g. add display objects to 'sceneGroup', add touch listeners, etc
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

    local speechtext = display.newText( "Ithuba lakho lokudweba \numumo", speech.x, speech.y, speech.contentWidth/1.3,0,teachersPetFont,20 )
    speechtext:setFillColor( 0 )

		timer.performWithDelay( 2000, (function(e)
			r.alpha = 0
			z.alpha = 0
			speech.alpha = 0
			speechtext.alpha = 0

		whitebg = display.newImageRect("whitebg.png",display.actualContentWidth,display.actualContentHeight)
		whitebg.x = display.contentCenterX
		whitebg.y = display.contentCenterY
		--whitebg:addEventListener("touch", stopDrawing)
		sceneGroup:insert(whitebg)
		--whitebg:addEventListener( "touch", stopDrawing )
		--Image container
		clippingContainer = display.newContainer( display.contentWidth , whitebg.height - 1 / 3 * xInset -2.5 )
		clippingContainer:translate( whitebg.x, whitebg.y )
		
		local t_X = - clippingContainer.x + display.contentCenterX
		local t_Y = - clippingContainer.y + display.contentCenterY

		curSlide = 1
		PlayP(curSlide)

		curText = display.newImage("images/bigA.png", 0, 0)
		curText.alpha = 0.5
		curText:scale( 0.55/1.5, 0.55/1.5 )
		curMask = graphics.newMask( "images/bigA_mask.png") 
		curText:setFillColor(0.8,0.8,0.8)
		curText:setMask(curMask)
		curText.isHitTestMasked = true
		-- curText = display.newText("A", 0,0, teachersPetFont, 400)
		-- curText:setFillColor(0,1,0)
		clippingContainer:insert(curText)
		curText:addEventListener( "touch", drawOnText ) 

		curCoords = cloneTable( coordsTable[ "A" ] )
		
		--XX
		displayTouchPointCircles()
		
		sceneGroup:insert(clippingContainer)
		homeBtn = display.newImage("home.png")
		homeBtn.xScale =0.40
		homeBtn.yScale =0.40
		homeBtn.x = -((display.actualContentWidth-display.contentWidth)/2-homeBtn.contentWidth/2)
		homeBtn.y = homeBtn.y + homeBtn.contentHeight/2
		sceneGroup:insert(homeBtn)
		local placeHolderInStrokes = display.newCircle(200, 200, 10)
		placeHolderInStrokes.alpha = 0
		

		function homeBtn:touch( event )
			if event.phase == "began" then
				composer.gotoScene("menu", "fade", _transition_time);
				--transition image to shrink with a small delay then gotoScene
				--print("home")
				--transition.to( homeBtn, { time = _transition_time, x = homeBtn.x / 2, y = yInset * 1.5 / 2 , xScale = 0.35, yScale = 0.35 } )
				--timer.performWithDelay( _transition_time + 100, function() 
				--													composer.gotoScene("menu", "fade", _transition_time); 
				--												end)
				--timer.performWithDelay( _transition_time * 3, function()
				--													transition.to( homeBtn, 
				--																	{time = _transition_time, x = xInset * 0.8, y = ( yInset * 1.5 ) * 0.8, 
				--																	xScale = 0.40, yScale = 0.40 } ) end )
			end
			return true
		end
		
		homeBtn:addEventListener( "touch", homeBtn )

		rectr = display.newRoundedRect(display.contentWidth/2,display.contentHeight*0.85,display.actualContentWidth*0.9,60,10)
        rectr:setFillColor( 0.5 )
        rectr.alpha = 0
        sceneGroup:insert(rectr)
        rectr.strokeWidth = 2
		rectr:setStrokeColor( 0.5 )
		
		for i=1,#imagesl do
			local img = display.newImage(imagesl[i])
			local s = 50*0.8/img.contentHeight
			img:scale(s,s)
			img.y = rectr.y+20
			img.x = display.contentWidth*i/7
			img.tag = imagesl[i]
			imglist[#imglist+1] = img

			bottomimg[#bottomimg+1] = img
			img:addEventListener( "tap", (function() 
			if active == true then
                active = false
                current=i-1--#images-i+2 
                nextSlide(current)
                end
                    end))

			sceneGroup:insert(img)

			if drawdone[i] == 1 then
				local c = display.newImage("arrow.png")
				local s = 60*0.8/c.contentHeight
				c:scale(s,s)
				c.y = img.y
				c.x = img.x
				sceneGroup:insert(c)
			else
			img.alpha = 0.5
			end
		end
        end))
end

function scene:show( event )
    local sceneGroup = self.view
    local phase = event.phase

    if phase == "will" then
        -- Called when the scene is still off screen and is about to move on screen
    --p = audio.loadSound( "phoneticalphabet.mp3"  )
   -- e = audio.loadSound( "effects.mp3"  )
   -- isVirSound = audio.loadSound( "isvir.mp3"  )   
    elseif phase == "did" then
    	--play("A")
        -- Called when the scene is now on screen
        -- 
        -- INSERT code here to make the scene come alive
        -- e.g. start timers, begin animation, play audio, etc
		
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
	--	audio.dispose( p )
	--	audio.dispose( e )
	--	audio.dispose( isVirSound )
    elseif phase == "did" then
        -- Called when the scene is now off screen
		
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

nextSlide = function(slideNr)
	local _transition_time = 500
	local dierFile = "diereABC/"..diere[slideNr+1]..".png"
	curSlide = slideNr + 1

	if curSlide == 7 then
		composer.gotoScene( "menu" , "fade",500 )
		return
	end

	curText:setMask(nil)
	curText:removeEventListener( "touch", drawOnText )
	curMask = nil
	
	if strokes ~= nil then
		for i = #strokes, 1, -1 do
				strokes[ i ].isVisible = false
		end
	end
	strokes = nil
	
	curCoords  = nil
	curCoords = cloneTable( coordsTable[ letters[ curSlide ] ] )
		
	local nextText = display.newImage("images/big" .. letters[ curSlide ] .. ".png", 0, 0)
	--nextText.alpha = 0.5
	nextText:scale( 0.55/1.5, 0.55/1.5 )

	if (letters[curSlide] == "A") then
		strokeColor = colors[3]
	elseif (letters[curSlide] == "B") then
		strokeColor = colors[5]
	elseif (letters[curSlide] == "C") then
		strokeColor = colors[2]
	elseif (letters[curSlide] == "D") then
		strokeColor = colors[4]
	elseif (letters[curSlide] == "E") then
		strokeColor = colors[6]
	elseif (letters[curSlide] == "F") then
		strokeColor = colors[1]
	end

	local mask = graphics.newMask( "images/big" .. letters[ curSlide ] .. "_mask.png") 
	nextText:setMask(mask)
	nextText.isHitTestMasked = true
	nextText:addEventListener( "touch", drawOnText )
	clippingContainer:insert(nextText)
	
	nextText.alpha = 0
	curMask = mask
	local nextDierImage
	
	-- transitions
	nextText.alpha = 0.5

	if success then 
		nextText:setFillColor( strokeColor[ 1 ], strokeColor[ 2 ], strokeColor[ 3 ] )
		success = false

		transition.to(curText, {time = _transition_time, alpha = 0} )
		timer.performWithDelay( _transition_time, function() 
				transition.to( nextText, { time = _transition_time, alpha = 0.5 } )
				end )
		secondFade = true
		PlayEffect(1)
	else
		
		if secondFade == true then
			
			secondFade = false
			transition.to(curText, {time = _transition_time, alpha = 0 } )
			timer.performWithDelay( 1000, function()
						transition.to( nextText, { time = _transition_time, alpha = 0.5 } )
						play(letters[curSlide])
					end )	
		else

			transition.to(curText, {time = _transition_time, alpha = 0, onComplete = function() transition.to( nextText, { time = _transition_time, alpha = 1 } ) active = true end } )
		PlayP(curSlide)
		end
		nextText:setFillColor(0.8,0.8,0.8)	
		
		
	end
	
	curText = nil
	curText = nextText
end

prevSlide = function(slideNr)
	local dierFile = "diereABC/"..diere[slideNr-1]..".png"
	curSlide = slideNr - 1
	PlayP(curSlide)
	local nextTextOptions = {
		text = letters[slideNr - 1],
		font = teachersPetFont,
		fontSize = 400,
		align = "left"
	}
	curText:setMask(nil)
	curText:removeEventListener( "touch", drawOnText )
	curMask = nil
	
	if strokes ~= nil then
		for i = #strokes, 1, -1 do
				strokes[ i ].isVisible = false
		end
	end
	strokes = nil
	curCoords  = nil
	curCoords = cloneTable( coordsTable[ letters[ curSlide ] ] )
	
	local nextText = display.newImage("images/big" .. letters[ curSlide ] .. ".png", 0, 0)
	nextText:scale( 0.55/1.5, 0.55/1.5 )
	nextText:setFillColor(0.8,0.8,0.8)	

	if (letters[curSlide] == "A") then
		strokeColor = colors[3]
	elseif (letters[curSlide] == "B") then
		strokeColor = colors[5]
	elseif (letters[curSlide] == "C") then
		strokeColor = colors[2]
	elseif (letters[curSlide] == "D") then
		strokeColor = colors[4]
	elseif (letters[curSlide] == "E") then
		strokeColor = colors[6]
	elseif (letters[curSlide] == "F") then
		strokeColor = colors[1]
	end
	
	local mask = graphics.newMask( "images/big" .. letters[ curSlide ] .. "_mask.png") 
	nextText:setMask(mask)
	nextText.isHitTestMasked = true
	nextText:addEventListener( "touch", drawOnText )
	clippingContainer:insert(nextText)
	
	curMask = mask
	
	nextText.alpha = 0
	transition.to(curText, {time = _transition_time, alpha = 0, onComplete = function() transition.to( nextText, { time = _transition_time, alpha = 1 } ) end } )

	curText = nil
	curText = nextText

end

-------------------------------------------------------------------------------------------------------------------------------
drawOnText = function ( event )
		
	local phase = event.phase
	local target = event.target
	display.getCurrentStage():setFocus( curMask )
	
	local x = event.x
	local y = event.y
	local xStart = event.xStart
	local yStart = event.yStart
	
	local function getDistance(x1,y1,x2,y2)
		return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
	end
	
	if target.lastX == nil then
		target.lastX, target.lastY = x, y
	end
	hitsLeft = #curCoords
	
	
	local endFunction = function()
					if hitsLeft == 0 then
						if curSlide < 26 then
							success = true	
							
							drawdone[curSlide] = 1

							for i=1,#drawdone do
								if drawdone[i] == 1 then
								local c = display.newImage("arrow.png")
								local s = 60*0.8/c.contentHeight
								c:scale(s,s)
								c.y = bottomimg[i].y
								c.x = bottomimg[i].x
								bottomimg[i].alpha = 1
								sceneGroup:insert(c)
								else
								bottomimg[i].alpha = 0.5
								end
							end

							nextSlide( curSlide - 1 )
							
							timer.performWithDelay( 2500, function() 
							
							nextSlide( curSlide );
							end )
						else
							success = true
							
							nextSlide( curSlide - 1 )
							timer.performWithDelay( 2500, function() 
							
							nextSlide( 0 );
							end )
						end
					end
					--print("ended")
					isDrawing = 0
					lineStarted = false
					--print("drawOnText: isDrawing =" .. isDrawing .. "  ,  lineStarted = false")
					display.getCurrentStage():setFocus( nil )
					--curMask.isFocus = nil
					target.lastX, target.lastY = nil, nil
					
					if checkHits(event.x, event.y) == 0 then  --checkHits returns # coords to draw on that's left for current letter
						if(curSlide < 26) then
							nextSlide(curSlide)
						end
					end
	end
		
	
	if event.phase == "began" then
		isDrawing = 1
		--print("drawOnText: isDrawing = " .. isDrawing .. "  ,  phase = began")
		if strokes == nil then 
			strokes = { } 
		end
		
		event.target.markX = event.target.x
		event.target.markY = event.target.y
		
		local c = display.newCircle(event.x, event.y, strokeWidth / 2)
		c:setFillColor( strokeColor[1], strokeColor[2], strokeColor[3] )
		table.insert( strokes, c )
		sceneGroup:insert ( c )
		
		--print("drawOnText: isDrawing = " .. isDrawing .. "  ,  phase = moved")
		drawingLine = display.newLine( xStart, yStart, x, y )
		drawingLine.strokeWidth = strokeWidth
		drawingLine:setStrokeColor( strokeColor[1], strokeColor[2], strokeColor[3] ) 
		table.insert( strokes, drawingLine )
		sceneGroup:insert ( drawingLine )
			
	elseif event.phase == "moved" then 
		if isDrawing == 1 then
				lineStarted = true
				drawingLine:append(event.x, event.y)
				
				local c = display.newCircle( event.x, event.y, strokeWidth / 2 )
				c:setFillColor( strokeColor[1], strokeColor[2], strokeColor[3]) 
				table.insert( strokes, c )
				sceneGroup:insert ( c )
				
				hitsLeft = checkHits(event.x, event.y) 
		end
	elseif event.phase == "ended" or event.phase == "cancelled" then 
	print(event.x.. " " .. event.y)
		endFunction()
		--print("phase = ended")
	elseif isDrawing == 0 then
		endFunction()
	end
	
	
	return true
	

end
-------------------------------------------------------------------------------------------------------------------------------
stopDrawing = function( e )
	
	if e.phase == "began" or e.phase == "moved" then
		-- bring vir Zander in
		isDrawing = 0
		--print("STOPDRAW: isDrawing = 0")
		if  xanderGroup == nil then
			
			curText:removeEventListener("touch",drawOnText)
			
			PlayEffect(2)
			xanderGroup = display.newGroup()
			local xanderSpeech = display.newImage("icons/blouSpeech.png")
			xanderSpeech.x = xInset * 3
			xanderSpeech:scale(0.2,0.2)
			xanderSpeech.alpha = 0.9
			xanderGroup:insert(xanderSpeech)
			local xander = display.newImage("zanders/2.png")
			xander:scale(0.3,0.3)
			
			xanderGroup:insert(xander)
			xanderGroup.x = -xInset * 5
			xanderGroup.y = cHeight / 2
			xanderGroup.anchorY = 1
			sceneGroup:insert(xanderGroup)
			
			transition.to(xanderGroup,{time = 1000 ,x = xInset*2,onComplete = function()
				curText:addEventListener("touch",drawOnText)
				timer.performWithDelay(2000,function()
					transition.to(xanderGroup,{time = 1000 ,x = - xInset * 5,onComplete = function()
						
						xanderGroup:removeSelf()
						xanderGroup = nil
					end})
				end)
			end})
			
		end
		
	elseif e.phase == "ended" or e.phase == "cancelled" then
		lineStarted = false
		--print("ended on white")
	end
	return true
end
-------------------------------------------------------------------------------------------------------------------------------
draggedLeft = function ( x1, x2 )
	
	if ( xInset< x1 - x2 ) then
		return true
	else 
		return false
	end
	
end

draggedRight = function ( x1, x2 )
	
	if ( x2 - x1 > xInset ) then
		return true
	else 
		return false
	end
	
end

slideListener = function ( event )

	if event.phase == "ended" then
		if draggedLeft( event.xStart, event.x ) then
			if curSlide < 26 then
				nextSlide(curSlide)
			end
			
		elseif draggedRight( event.xStart, event.x ) then
			if curSlide > 1 then
				prevSlide(curSlide)
			end
		end
	end
end		

cloneTable = function( t )
	local clone = { }
	local temp = { }
	for i = 1, #t do
		local tempx = t[ i ][ 1 ] - 512 / 2 + display.contentWidth / 2
		local tempy = t[ i ][ 2 ] - 320 / 2 + display.contentHeight / 2
		clone[ i ] = { tempx, tempy }
	end
	return clone
end

displayTouchPointCircles = function()
	for i = 1, #curCoords do
		local C = display.newCircle(curCoords[i][1], curCoords[i][2], 3)
		C:setFillColor(1,0,0)
		C.alpha = 0
		table.insert(touchPointCircles, C)
		touchPointCircles[ #touchPointCircles + 1 ] = C
	end
end

removeTouchPointCircles = function()
	for i = #touchPointCircles, 1, -1 do
		--print(i)
		local C = touchPointCircles[i]:removeSelf()
	end
	touchPointCircles = { }
end

checkHits = function(curX, curY)
	local function getDistance(x1,y1,x2,y2)
		return math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2)
	end
	
	for i = 1, #curCoords do
		if getDistance(curX, curY, curCoords[i][1], curCoords[i][2]) < 20 then
			table.remove( curCoords, i )
			--print("hit")
			return #curCoords
		end
	end
	return #curCoords
end

return scene
