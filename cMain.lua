local screenW, screenH = guiGetScreenSize()
local resW, resH = 1920,1080
local x,y = (screenW/resW), (screenH/resH)

local svgTable = {
	paineltipo = svgCreate(x*201, y*209, [[
		<svg width="201" height="209" viewBox="0 0 201 209" fill="none" xmlns="http://www.w3.org/2000/svg">
		<rect width="201" height="209" rx="20" fill="#3A3A3A"/>
		</svg>
		]]),
	barrat = svgCreate(x*171, y*72, [[
		<svg width="171" height="72" viewBox="0 0 171 72" fill="none" xmlns="http://www.w3.org/2000/svg">
		<rect width="171" height="72" rx="20" fill="#D9D9D9"/>
		</svg>
		]]),
	painelprincipal = svgCreate(x*665, y*816, [[
		<svg width="665" height="816" viewBox="0 0 665 816" fill="none" xmlns="http://www.w3.org/2000/svg">
		<rect width="665" height="816" rx="20" fill="#3A3A3A"/>
		</svg>
		]]),
	painelinfos = svgCreate(x*416, y*568, [[
		<svg width="416" height="568" viewBox="0 0 416 568" fill="none" xmlns="http://www.w3.org/2000/svg">
		<rect width="416" height="568" rx="20" fill="#3A3A3A"/>
		</svg>
		]]),
	barrap = svgCreate(x*618, y*154, [[
		<svg width="618" height="154" viewBox="0 0 618 154" fill="none" xmlns="http://www.w3.org/2000/svg">
		<rect width="618" height="154" rx="20" fill="#D9D9D9"/>
		</svg>
		]]),
	barrai = svgCreate(x*378, y*70, [[
		<svg width="378" height="70" viewBox="0 0 378 70" fill="none" xmlns="http://www.w3.org/2000/svg">
		<rect width="378" height="70" rx="20" fill="#D9D9D9"/>
		</svg>
		]]),
	painelupdate = svgCreate(x*201, y*112, [[
		<svg width="201" height="112" viewBox="0 0 201 112" fill="none" xmlns="http://www.w3.org/2000/svg">
<rect width="201" height="112" rx="20" fill="#3A3A3A"/>
</svg>
]]),
}

local fonts = {
	[1] = dxCreateFont("Files/K2D.ttf", 30),
	[2] = dxCreateFont("Files/K2D.ttf", 20)
}

local pos = {
	{651, 163 + (1-1)*84, 618, 84},
	{651, 163 + (2-1)*(84+25), 618, 84},
	{651, 163 + (3-1)*(84+25), 618, 84},
	{651, 163 + (4-1)*(84+25), 618, 84},
	{651, 163 + (5-1)*(84+25), 618, 84},
	{651, 163 + (6-1)*(84+25), 618, 84},
	{651, 163 + (7-1)*(84+25), 618, 84},
}

local data = {}
local infos = {"", "", "", "", ""}
local logs = {}

local maxLinhas = #pos
local proximaPagina = 0
local indexSelect = 0
local page = nil
tick = getTickCount()

-- Painel

function drawPainel()
	local alpha = interpolateBetween(0, 0, 0, 255, 0, 0, ((getTickCount() - tick) / 800), 'Linear')
	dxDrawImage(x*381, y*132, x*201, y*209, svgTable.paineltipo,0, 0, 0, tocolor(255, 255, 255, alpha), false)
	--[[dxDrawImage(x*381, y*361, x*201, y*112, svgTable.painelupdate,0, 0, 0, tocolor(255, 255, 255, alpha), false)
	if isMouseInPosition(x*396, y*381, x*171, y*72) then
		dxDrawImage(x*396, y*381, x*171, y*72, svgTable.barrat,0, 0, 0, tocolor(198, 58, 58, alpha), false)
	else
		dxDrawImage(x*396, y*381, x*171, y*72, svgTable.barrat,0, 0, 0, tocolor(255, 255, 255, alpha), false)
	end]]
	if isMouseInPosition(x*396, y*152, x*171, y*72) then -- Ban
	dxDrawImage(x*396, y*152, x*171, y*72, svgTable.barrat,0, 0, 0, tocolor(198, 58, 58, alpha), false)
else
	dxDrawImage(x*396, y*152, x*171, y*72, svgTable.barrat,0, 0, 0, tocolor(255, 255, 255, alpha), false)
	end -- Ban
	if isMouseInPosition(x*396, y*249, x*171, y*72) then -- Log
	dxDrawImage(x*396, y*249, x*171, y*72, svgTable.barrat,0, 0, 0, tocolor(198, 58, 58, alpha), false)
else
	dxDrawImage(x*396, y*249, x*171, y*72, svgTable.barrat,0, 0, 0, tocolor(255, 255, 255, alpha), false)
	end -- Log
	dxDrawImage(x*381+ 24, y*132 + 27 , x*50, y*50, 'Files/Fraud.png',0, 0, 0, tocolor(255, 255, 255, alpha), false)
	dxDrawImage(x*381+ 24, y*132 + 113 , x*50, y*50, 'Files/Evidence.png',0, 0, 0, tocolor(255, 255, 255, alpha), false)
	--dxDrawImage(x*381+ 24, y*392 , x*50, y*50, 'Files/Updates.png',0, 0, 0, tocolor(255, 255, 255, alpha), false)
	dxDrawText("Bans", x*381+ 70, y*132 + 34, 0, 0, tocolor(0, 0, 0, 255), 0.80,fonts[2])
	dxDrawText("Logs", x*381+ 70, y*115 + 136, 0, 0, tocolor(0, 0, 0, 255), 0.80,fonts[2])
	--dxDrawText("Updates", x*381+ 70, y*392+10, 0, 0, tocolor(0, 0, 0, 255), 0.80,fonts[2])
	--dxDrawImage(x*1339, y*132, x*416, y*568, svgTable.painelprincipal,0, 0, 0, tocolor(255, 255, 255, alpha), false)
	showCursor(true)
	linha = 0
	if page == "Bans" then
		dxDrawImage(x*628, y*132, x*665, y*816, svgTable.painelprincipal,0, 0, 0, tocolor(255, 255, 255, alpha), false)
		for i,v in ipairs(data) do
			if i > proximaPagina and linha < maxLinhas then
				linha = linha + 1
				dxDrawImage(x * pos[linha][1], y * pos[linha][2], x * pos[linha][3], y * pos[linha][4], svgTable.barrap, 0, 0, 0, (indexSelect == i and tocolor(113, 113, 113, alpha) or tocolor(255, 255, 255, alpha)), false)
				dxDrawText(removeHex(v[2]), x * pos[linha][1] + 80, y * pos[linha][2] + 12, 0, 0, tocolor(0, 0, 0, alpha), 1.00,fonts[1])
				dxDrawImage(x * pos[linha][1] +10 , y * pos[linha][2] + 8 , x*80, y*70, 'Files/avatar.png',0, 0, 0, tocolor(255, 255, 255, alpha), false)
			end
		end
	elseif page == "Logs" then
		dxDrawImage(x*628, y*132, x*665, y*816, svgTable.painelprincipal,0, 0, 0, tocolor(255, 255, 255, alpha), false)
		--
		linha = 0
		for i,v in ipairs(logs) do
			if i > proximaPagina and linha < maxLinhas then
				linha = linha + 1
				dxDrawImage(x * pos[linha][1], y * pos[linha][2], x * pos[linha][3], y * pos[linha][4], svgTable.barrap, 0, 0, 0, (indexSelect == i and tocolor(113, 113, 113, alpha) or tocolor(255, 255, 255, alpha)), false)
				dxDrawText("O staff "..removeHex(v[1]).." desbaniu o jogador "..removeHex(v[2]), x * pos[linha][1] + 80, y * pos[linha][2] + 12, 0, 0, tocolor(0, 0, 0, alpha), 0.80,fonts[2])
				dxDrawText(v[3], x * pos[linha][1] + 80, y * pos[linha][2] + 30, 0, 0, tocolor(0, 0, 0, alpha), 1.00,fonts[2])
				dxDrawImage(x * pos[linha][1] +10 , y * pos[linha][2] + 8 , x*80, y*70, 'Files/avatar.png',0, 0, 0, tocolor(255, 255, 255, alpha), false)
			end
		end
		--
	else
	end
	if indexSelect ~= 0 then
		dxDrawImage(x*1339, y*132, x*416, y*568, svgTable.painelinfos,0, 0, 0, tocolor(255, 255, 255, alpha), false)
		dxDrawImage(x*1358, y*163, x*378, y*70, svgTable.barrai,0, 0, 0, tocolor(255, 255, 255, alpha), false)
		dxDrawText(removeHex(infos[1]), x*1358 + 770, y*167 + 140, 378, 70, tocolor(0, 0, 0, alpha), 1.00, fonts[2], "center", "center")
		--dxDrawImage(x*1358, y*253, x*378, y*70, svgTable.barrai,0, 0, 0, tocolor(255, 255, 255, alpha), false)
		if isMouseInPosition(x*1358, y*253, x*378, y*70) then
			dxDrawImage(x*1358, y*253, x*378, y*70, svgTable.barrai,0, 0, 0, tocolor(113, 113, 113, alpha), false)
		else
			dxDrawImage(x*1358, y*253, x*378, y*70, svgTable.barrai,0, 0, 0, tocolor(255, 255, 255, alpha), false)
		end
		dxDrawText(infos[2], x*1358 + 774, y*253 + 20, 378, 70, tocolor(0, 0, 0, alpha), 0.70, fonts[2], "center")
		dxDrawImage(x*1358, y*343, x*378, y*70, svgTable.barrai,0, 0, 0, tocolor(255, 255, 255, alpha), false)
		dxDrawText(removeHex(infos[3]), x*1358 + 770, y*343 + 12, 378, 70, tocolor(0, 0, 0, alpha), 1.00, fonts[2], "center")
		dxDrawImage(x*1358, y*433, x*378, y*70, svgTable.barrai,0, 0, 0, tocolor(255, 255, 255, alpha), false)
		dxDrawText(infos[4], x*1358 + 770, y*433 + 12, 378, 70, tocolor(0, 0, 0, alpha), 1.00, fonts[2], "center")
		dxDrawImage(x*1358, y*523, x*378, y*70, svgTable.barrai,0, 0, 0, tocolor(255, 255, 255, alpha), false)
		dxDrawText(infos[5], x*1358 + 770, y*523 + 12, 378, 70, tocolor(0, 0, 0, alpha), 1.00, fonts[2], "center")
		if isMouseInPosition(x*1358, y*611, x*378, y*70) then
			dxDrawImage(x*1358, y*611, x*378, y*70, svgTable.barrai,0, 0, 0, tocolor(0, 255, 135, alpha), false)
		else
			dxDrawImage(x*1358, y*611, x*378, y*70, svgTable.barrai,0, 0, 0, tocolor(113, 113, 113, alpha), false)
		end
		dxDrawText("Desbanir", x*1358 + 770, y*611 + 12, 378, 70, tocolor(0, 0, 0, alpha), 1.00, fonts[2], "center")
	end
end
--addEventHandler("onClientRender", root, drawPainel)

-- Teclas

addEventHandler('onClientClick', root,
	function (button, state)
		if (button == 'left') and (state == 'down') then
			if isEventHandlerAdded('onClientRender', root, drawPainel) then
				if page == "Bans" then
					linha = 0
					for i, v in ipairs(data) do
						if (i > proximaPagina and linha < maxLinhas) then
							linha = linha + 1
							if isMouseInPosition(x * pos[linha][1], y * pos[linha][2], x * pos[linha][3], y * pos[linha][4]) then
								indexSelect = i
								triggerServerEvent("W33D.onGetBanID", localPlayer, i)
							end
						end
				end --for
			end
				if isMouseInPosition(x*1358, y*253, x*378, y*70) then -- serial
					setClipboard(infos[2])
					exports.vrp_info:addBox("Serial copiado com sucesso!", "success")
			end
				if isMouseInPosition(x*396, y*152, x*171, y*72) then -- Ban
				page = "Bans"
				indexSelect = 0
			end
				if isMouseInPosition(x*396, y*249, x*171, y*72) then -- Log
				page = "Logs"
				indexSelect = 0
				triggerServerEvent("W33D.onGetLogs", localPlayer)
			end
				--[[if isMouseInPosition(x*396, y*381, x*171, y*72) then --update
				triggerServerEvent("W33D.onUpdateBans", localPlayer)
				page = nil
				indexSelect = 0
				infos = {"", "", "", "", ""}
			end]]
			if page == "Bans" then
				if infos ~= nil then
						if isMouseInPosition(x*1358, y*611, x*378, y*70) then -- Desbanir
						triggerServerEvent("W33D.onunBanID", localPlayer, indexSelect)
						exports.vrp_info:addBox("O jogador "..removeHex(infos[1]).." foi desbanido!", "success")
						triggerServerEvent("W33D.onAddLogs", localPlayer,  removeHex(getPlayerName(localPlayer)), removeHex(infos[1]))
						page = nil
						infos = {"", "", "", "", ""}
						indexSelect = 0
						removeEventHandler('onClientRender', root, drawPainel)
						showCursor(false)
					end
				end
			end
		end
	end
end
)

-- Binds

bindKey("mouse_wheel_up", "down", function()
	if isEventHandlerAdded('onClientRender', root, drawPainel) then
		if(proximaPagina > 0) then
			proximaPagina = proximaPagina - 1
		end
	end
end)

bindKey("mouse_wheel_down", "down", function()
	if isEventHandlerAdded('onClientRender', root, drawPainel) then
		proximaPagina = proximaPagina + 1
		if (proximaPagina > #data-maxLinhas) then
			proximaPagina = #data-maxLinhas
		end
	end 
end)

bindKey('backspace', 'down',
	function ()
		if isEventHandlerAdded('onClientRender', root, drawPainel) then
			removeEventHandler('onClientRender', root, drawPainel)
			showCursor(false)
			playSoundFrontEnd(1)
			linha = 0 
			data = nil
			infos = {"", "", "", "", ""}
		end
	end
	)

-- Trigger

addEvent('W33D.onOpenPanel', true)
addEventHandler('W33D.onOpenPanel', root,
	function (dados)
		if not isEventHandlerAdded('onClientRender', root, drawPainel) then
			addEventHandler('onClientRender', root, drawPainel)
			tick = getTickCount()
			showCursor(true)
			playSoundFrontEnd(1)
			data = dados
		else
			removeEventHandler('onClientRender', root, drawPainel)
			showCursor(false)
			playSoundFrontEnd(1)
			linha = 0
			data = nil
			infos = {"", "", "", "", ""}
		end
	end
	)

addEvent('W33D.onDrawInfos', true)
addEventHandler('W33D.onDrawInfos', root,
	function (dados)
		if isEventHandlerAdded('onClientRender', root, drawPainel) then
			infos = dados
		end
	end
	)

addEvent('W33D.onDrawLogs', true)
addEventHandler('W33D.onDrawLogs', root,
	function (dados)
		logs = dados
	end
	)

-- utils

function isMouseInPosition ( x, y, width, height )
	if ( not isCursorShowing( ) ) then
		return false
	end
	local sx, sy = guiGetScreenSize ( )
	local cx, cy = getCursorPosition ( )
	local cx, cy = ( cx * sx ), ( cy * sy )
	
	return ( ( cx >= x and cx <= x + width ) and ( cy >= y and cy <= y + height ) )
end

function isEventHandlerAdded( sEventName, pElementAttachedTo, func )
	if type( sEventName ) == 'string' and isElement( pElementAttachedTo ) and type( func ) == 'function' then
		local aAttachedFunctions = getEventHandlers( sEventName, pElementAttachedTo )
		if type( aAttachedFunctions ) == 'table' and #aAttachedFunctions > 0 then
			for i, v in ipairs( aAttachedFunctions ) do
				if v == func then
					return true
				end
			end
		end
	end
	return false
end

function removeHex (s)
	if type (s) == "string" then
		while (s ~= s:gsub ("#%x%x%x%x%x%x", "")) do
			s = s:gsub ("#%x%x%x%x%x%x", "")
		end
	end
	return s or false
end

--[[
for i,v in ipairs(testban) do
		if i > proximaPagina and elementos < maxelementos then
			elementos = elementos + 1
			dxDrawImage(x*651, y*163 + (elementos-1)*154, x*618, y*154, svgTable.barrap)
			dxDrawText(v[1], x*798, y*219 + (elementos-1)*154, x*447, y*42)
		end
	end
	]]