function abrirPainel(player, c)
	----
	local dados = {}
	local banList = getBans()
	--
	for banID, ban in ipairs ( banList ) do	
		--
		local nick = getBanNick(ban)
		if nick then
		table.insert(dados, {banID , nick} )
		end
		--
	end
	triggerClientEvent(player, 'W33D.onOpenPanel', player, dados)
	----
end
addCommandHandler("acpanel", abrirPainel)

function getBanID(id)
	local banList = getBans()
	for banID, ban in ipairs ( banList ) do
		if banID == id then
			local banned = (getBanNick(ban) or "erro")
			local banner = (getBanAdmin(ban) or "erro")
			local reason = (getBanReason(ban) or "erro")
			local user = (getBanSerial(ban) or "erro")
			local ip = (getBanIP(ban) or "erro")
			triggerClientEvent(source, 'W33D.onDrawInfos', source, {banned, user, banner, reason, ip})
		end --banid == id
	end --for
end
addEvent("W33D.onGetBanID", true)
addEventHandler("W33D.onGetBanID", root, getBanID)

function unBanID(id)
	local banList = getBans()
	for banID, ban in ipairs ( banList ) do
		if banID == id then
			removeBan(ban)
		end --banid == id
	end --for
end
addEvent("W33D.onunBanID", true)
addEventHandler("W33D.onunBanID", root, unBanID)


local banPanel = dbConnect('sqlite', 'acpanel.sqlite')
function inicializar()
--dbExec(banPanel, 'create table if not exists bans (id, staffname, banned, reason, serial, ip, bantime)')
dbExec(banPanel, 'create table if not exists unbans (staffname, banned, time)')
end
addEventHandler ( "onResourceStart", root, inicializar )

function getLogs()
	local dados = {}
	if banPanel then
		local data = dbPoll(dbQuery(banPanel, 'select * from unbans'), -1)
		for i,v in ipairs(data) do
			local staff = v["staffname"]
			local banido = v["banned"]
			local time = v["time"]
			table.insert(dados, {staff, banido, time})
		end
		triggerClientEvent(source, 'W33D.onDrawLogs', source, dados)
	else
		exports.vrp_info:addBox(source, "[AC] Algo deu errado!", "error")
	end
end
addEvent("W33D.onGetLogs", true)
addEventHandler("W33D.onGetLogs", root, getLogs)

function addLog(staff, punido)
	if banPanel then
		dbExec(banPanel, 'insert into unbans values (?, ?, ?)', staff, punido, os.date("%Y-%m-%d %H:%M:%S"))
	else
		exports.vrp_info:addBox(source, "[AC] Algo deu errado!", "error")
	end
end
addEvent("W33D.onAddLogs", true)
addEventHandler("W33D.onAddLogs", root, addLog)
--[[
function updateBans()
	if banPanel then
		dbExec(banPanel, 'delete from bans')
		-----
		local banList = getBans()
		for banID, ban in ipairs ( banList ) do
			local banned = (getBanNick(ban) or "erro")
			local banner = (getBanAdmin(ban) or "erro")
			local reason = (getBanReason(ban) or "erro")
			local user = (getBanUsername(ban) or "erro")
			local ip = (getBanIP(ban) or "erro")
			local serial = (getBanSerial(ban) or "erro")
			local bantime = getBanTime(ban)
			dbExec(banPanel, 'insert into bans values (?, ?, ?, ?, ?, ?, ?)', banID, banner, banned, reason, serial, ip, bantime)
		end --for
		exports.vrp_info:addBox(source, "[AC] Dados atualizados!", "success")
		-----
	else
		exports.vrp_info:addBox(source, "[AC] Algo deu errado!", "error")
	end
end
addEvent("W33D.onUpdateBans", true)
addEventHandler("W33D.onUpdateBans", root, updateBans)]]