local dataScanner = require "plugin.dataScanner"
local widget = require("widget")
local json = require("json")
local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
bg:setFillColor( 1,.5,0 )

local title = display.newText( {text = "Data Scanner", fontSize = 30} )
title.x, title.y =display.contentCenterX, 50
local scannerShow
scannerShow = widget.newButton( {
        x = display.contentCenterX,
        y = display.contentCenterY,
        id = "showScanner",
        labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
        label = "Show Scanner\n(Tap Text/Barcodes to scan)",
        onEvent = function ( e )
                if (e.phase == "ended") then
                        dataScanner.show{
                            listener=function(e)
                                print(json.encode(e))
                            end,
                            highFrameRateTrackingEnabled = true,
                            highlightingEnabled = true,
                            recognizesMultipleItems = true,
                            barCodeSupport = true,
                            textSupport = true,
                        }
                        dataScanner.startScaning()
                        timer.performWithDelay(10000, function()
                            dataScanner.hide()
                            --dataScanner.stopScaning()
                        end)
                end
        end
} )
