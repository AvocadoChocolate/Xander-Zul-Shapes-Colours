-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

-- include Corona's "widget" library
local widget = require "widget"

--------------------------------------------

-- forward declarations and other locals
local playBtn

local xInset = display.contentWidth/20
local yInset = display.contentHeight/20

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	composer.removeScene("kenshapes")
	composer.gotoScene( "kenshapes", "fade", 500 )
	
	return true	-- indicates successful touch
end

local function onTraceBtnRelease()
	
	-- go to level1.lua scene
	composer.removeScene("trace")
	composer.gotoScene( "trace", "fade", 500 )
	
	return true	-- indicates successful touch
end

local function onPuzzleBtnRelease()
	
	-- go to level1.lua scene
	composer.removeScene("puzzle")
	composer.gotoScene( "puzzle", "fade", 500 )
	
	return true	-- indicates successful touch
end

local function onKiesBtnRelease()
	
	-- go to level1.lua scene
	composer.removeScene("matchshape")
	composer.gotoScene( "matchshape", "fade", 500 )
	
	return true	-- indicates successful touch
end

local function onKleurBtnRelease()
	
	-- go to level1.lua scene
	composer.removeScene("kencolour")
	composer.gotoScene( "kencolour", "fade", 500 )
	
	return true	-- indicates successful touch
end

local function onMemBtnRelease()
	
	-- go to level1.lua scene
	composer.removeScene("memory")
	composer.gotoScene( "memory", "fade", 500 )
	
	return true	-- indicates successful touch
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

	-- display a background image
	local background = display.newImage( "bg.jpg")
	background.anchorX = 0
	background.anchorY = 0
	background.x, background.y = display.screenOriginX, display.screenOriginY
	
	sceneGroup:insert( background )
	-- create a widget button (which will loads level1.lua on release)

	----------
	local abcGroup = display.newGroup()
local imageabc = display.newImage(abcGroup,"vorms.png")
	imageabc.x = -xInset * 0.2
	imageabc.xScale = 0.8
	imageabc.yScale = 0.8
	local circleabc = display.newImage( abcGroup,"boxthing.png")
	abc = imageabc.parent
	abc:insert( imageabc )
	abc:insert( 1, circleabc)
	abc.x =display.contentCenterX - xInset * 6.5
	abc.y =display.contentCenterY - yInset * 6
	abc.xScale = 0.7
	abc.yScale = 0.7
	sceneGroup:insert(abc)
	abc:addEventListener( "tap", onPlayBtnRelease )

	local smallLetterGroup = display.newGroup()
	local imagesmallLetter = display.newImage(smallLetterGroup,"kleure.png")
	imagesmallLetter.xScale =0.8
	imagesmallLetter.yScale =0.8
	imagesmallLetter.x = -xInset*0.1
	imagesmallLetter.y = -yInset * 0.25

	local circlesmallLetter = display.newImage( smallLetterGroup,"boxthing.png")
	smallLetter = imagesmallLetter.parent
	smallLetter:insert( imagesmallLetter )
	smallLetter:insert( 1, circlesmallLetter)
	smallLetter.x =display.contentCenterX - xInset * 0.5
	smallLetter.y =display.contentCenterY - yInset * 6
	smallLetter.xScale = 0.7
	smallLetter.yScale = 0.7
	sceneGroup:insert(smallLetter)
	smallLetter:addEventListener( "tap", onKleurBtnRelease )

	local xander = display.newImage("x.png")
	xander:scale(0.2,0.2)
	xander.x = (smallLetter.x + abc.x)/2
	xander.y = display.contentHeight-xander.contentHeight/2+xander.contentHeight/4
	sceneGroup:insert(xander)

	local speech = display.newImage("speech.png")
	speech:scale(-0.18,0.25)
	speech.x = xander.x + speech.contentWidth/2 + xander.contentWidth/2
	speech.y = xander.y - xander.contentHeight/5
	sceneGroup:insert(speech)

	local textspeech = display.newText( "Sawubona, khetha \numdlalo", speech.x, speech.y, speech.contentWidth, speech.contentHeight,teachersPetFont,14 )
	textspeech.x = speech.x+textspeech.contentWidth/8
	textspeech.y = speech.y+textspeech.contentHeight/8
	textspeech:setFillColor( 0 )
	sceneGroup:insert(textspeech)

	local BigLetterGroup = display.newGroup()
	local imageBigLetter = display.newImage(BigLetterGroup,"teken.png")
	imageBigLetter.xScale =0.8
	imageBigLetter.yScale =0.8
	imageBigLetter.y = yInset * 0.25
	imageBigLetter.x = -xInset*0.1

	--legkaart
	local circleBigLetter = display.newImage( BigLetterGroup,"boxthing.png")
	BigLetter = imageBigLetter.parent
	BigLetter:insert( imageBigLetter)
	
	BigLetter:insert( 1, circleBigLetter)
	BigLetter.x =display.contentCenterX + xInset * 5.5
	BigLetter.y =display.contentCenterY - yInset * 6
	BigLetter.xScale = 0.7
	BigLetter.yScale = 0.7
	sceneGroup:insert(BigLetter)
	BigLetter:addEventListener( "tap", onTraceBtnRelease )
	
	local SpelGroup = display.newGroup() -- Die group
	local uil = display.newImage(SpelGroup,"legkaart.png")
	uil.xScale = 0.7
	uil.yScale = 0.7
	local circleSpel = display.newImage( SpelGroup,"boxthing.png") -- ek ook nie die position hier define nie en sit dit bo op die ander een
	Spel = circleSpel.parent --sit die image heelbo
	Spel:insert( uil) -- ek nie seker hoekom jy dit hier insert nie dink dit deel van hom bo sit
	Spel:insert( 1, circleSpel) -- soos ek verstaan sit dit die circleSpel heel agter
	Spel.x = display.contentCenterX - xInset*6.5
	Spel.y = display.contentCenterY + yInset*1.5
	Spel.xScale = 0.7
	Spel.yScale = 0.7
	sceneGroup:insert(Spel)
	Spel:addEventListener( "tap", onPuzzleBtnRelease )
	
	local LeesGroup = display.newGroup() -- Die group
	local imageLees = display.newImage(LeesGroup,"kaartspel.png")
	imageLees.xScale =0.75
	imageLees.yScale =0.75 --ek nie die position define nie so dit sit dit center in die group
	local circleLees = display.newImage( LeesGroup,"boxthing.png") -- ek ook nie die position hier define nie en sit dit bo op die ander een
	Lees = imageLees.parent --sit die image heelbo
	Lees:insert( imageLees) -- ek nie seker hoekom jy dit hier insert nie dink dit deel van hom bo sit
	Lees:insert( 1, circleLees) -- soos ek verstaan sit dit die circleBou heel agter
	Lees.x = display.contentCenterX - xInset * 0.5
	Lees.y = display.contentCenterY + yInset * 1.5
	Lees.xScale = 0.7
	Lees.yScale = 0.7
	sceneGroup:insert(Lees)
	Lees:addEventListener( "tap", onMemBtnRelease )
	
	local PasGroup = display.newGroup() -- Die group
	local k = display.newImage(LeesGroup,"vindwatpas.png")
	k:scale(0.8,0.8)
	 --ek nie die position define nie so dit sit dit center in die group
	local circlePas = display.newImage( PasGroup,"boxthing.png") -- ek ook nie die position hier define nie en sit dit bo op die ander een
	Pas = circlePas.parent --sit die image heelbo
	Pas:insert(k) -- ek nie seker hoekom jy dit hier insert nie dink dit deel van hom bo sit
	Pas:insert( 1, circlePas) -- soos ek verstaan sit dit die circleBou heel agter
	Pas.x = display.contentCenterX + xInset * 5.5
	Pas.y = display.contentCenterY + yInset * 1.5
	Pas.xScale = 0.7
	Pas.yScale = 0.7
	sceneGroup:insert(Pas)
	Pas:addEventListener( "tap", onKiesBtnRelease )
	----------

end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
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
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene