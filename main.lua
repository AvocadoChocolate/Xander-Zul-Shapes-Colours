-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

-- include the Corona "composer" module
local composer = require "composer"

puzzledone = {0,0,0,0,0,0}
drawdone = {0,0,0,0,0,0}

if system.getInfo( "platformName" ) == "Win" then
	teachersPetFont = "TeachersPet"
else
	teachersPetFont = "Tptr"
end

-- load menu screen
composer.gotoScene( "menu" )