 local function verify_message_from_filter(message)
  local allow_msg = true
  local filter = {
    --English
    "fuck",
    "bitch",
    "ass",
    "shit",
    "shitstorm",
    "shitstain",
    "dick",
    "cock",
    "cunt",
    "nigger",
    "faggot",
    "gay",
    "whore",
    "incel",
    "cuck",
    "fucker",
    "motherfucker",
    "retard",
    "penis",
    "vagina",
    "vag",
    "penile",
    "autistic",
    "autist",
    "pussy",
    "masturbate",
    "sex",
    "intercourse",
    "asshole",
    "asswhipe",
    "cocksucker",
    "bitchass",
    "titties",
    "tits",
    "boobs",
    "breast",
    "breasts",
    "degenerate",
    "bastard",

    --Russian
    "сука",
    "блять",
    "бля",
    "мля",
    "блин",
    "твою мать",
    "твою же мать",
    "дибил",
    "аут",
    "аутист",
    "манда",
    "ебать",
    "ебало закрой",
    "заебал",
    "отвали",
    "заткнись",
    "мудак",
    "хуй",
    "охуел?",
    "это пиздец",
    "пизда",
    "сволочь",
    "жопа",
    "гавно",
    "лох",
    "гандон",
    "ублюдок",
    "срать",
    "мне насрать",
    "мне похуй",
    "черт",
    "трахнуть",
    "трахнул",
    "дегенерат",
    "хрен",
    "хуй",
    "дерьмо",
    "пошел к чорту",
    "мне плевать",
    "херня",
    "хрень",
    "один хрен",
    "ни хрена",
    "ну его нахрен",
    "иди нахер",
    "нахрен",
    "пошёл",
    "нахер",
    "нахрен",

    --German
    "arschloch",
    "arsch",
    "schwanz",
    "wichser",
    "schlampe",
    "hurre",
    "fick dich",
    "mutterficker",
    "hurensohn",
    "mastubiren",
    "scheide",
    "geschlechtsverkehr",
    "fotze",
    "missgeburt",
    "missgeburt",
    "vollidiot",
    "brüste",
    "titten",
    "scheiße"
  }
  --Verify if message contains any of the following disallowed words
  for k,v in pairs(filter) do
    local disallowed_word = v
    local to_verify = string.lower(message)

    if string.match(to_verify, disallowed_word) then
      allow_msg = false
      break
    end

  end

  --return boolean
  return allow_msg
end




minetest.register_chatcommand("me", {
	func = function(name, param)
	local player = minetest.get_player_by_name(name)
	local message = param:match("^(%S+)%s(.+)$")
	if not player then
		return true
	elseif not message then
		return true, "Only works by putting a message inside"
	end
	
    local msg = "* "..name.." "..message

	local allow_message = verify_message_from_filter(message)

	if allow_message == true then
		--Add modified chat message
    minetest.chat_send_all(msg)

	elseif allow_message == false then

    minetest.chat_send_player(name, minetest.colorize("#000000" ,"**You had a curse word in the sentense it didn't get send sorry!"))
    return true
   end
   
   return true
   end
})


minetest.register_chatcommand("msg", {
	params = "<name> <message>",
	description = "Send a private message",
	privs = {shout=true},
	func = function(name, param)
		local sendto, message = param:match("^(%S+)%s(.+)$")
		
		if not sendto then
			return false, "Invalid usage, see /help msg."
		end

		if not minetest.get_player_by_name(sendto) then
			return false, "The player " .. sendto
					.. " is not online."
		end
		
		
		local allow_message = verify_message_from_filter(message)

		if allow_message == true then

		minetest.chat_send_player(sendto, "PM from " .. name .. ": "
				.. message)

		return true, "Message sent."
		
		elseif allow_message == false then

		minetest.chat_send_player(name, minetest.colorize("#000000" ,"**You had a curse word in the sentense it didn't get send sorry!"))
		return true
		end
		
	end,
})
 
 
 
 
 minetest.register_on_chat_message(function(name, message)

	local allow_message = verify_message_from_filter(message)
	
	if allow_message == true then
    minetest.chat_send_all("<"..name.."> "..message)
	
	elseif allow_message == false then

    minetest.chat_send_player(name, minetest.colorize("#000000" ,"**You had a bad word in the sentense it didn't get send sorry!"))
    return true
	end


    return true
end)

