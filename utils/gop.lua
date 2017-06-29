local D = {}

function D.get(url, prop)
	url = url or msg.url()
	local mod_url = msg.url(url)
	mod_url.fragment = 'script'
	return go.get(mod_url, prop)
end

return D