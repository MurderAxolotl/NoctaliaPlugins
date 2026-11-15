local useSudo = noctalia.getConfig('execUseSudo') or false
local setNoctaliaPowerState = noctalia.getConfig("setNoctaliaPowerState") or false

local function render()
	governor = string.gsub(noctalia.readFile("/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor") or "?", "\n", "")

	if governor == "powersave" then
		display = "PS"
		icon    = "wave-sine"
		colour  = "#47ed8f"

	elseif governor == "performance" then
		display = "PF"
		icon    = "wave-square"
		colour  = "#ed8447"

	elseif governor == "ondemand" then
		display = "OD"
		icon    = "wave-saw-tool"
		colour  = "#b9ed47"

	else
		display = governor
		icon    = "timeline"
		colour  = "#8742f5"
	end

	barWidget.setText(`{display}`)
	barWidget.setGlyph(icon)
	barWidget.setGlyphColor(colour)
	barWidget.setColor(colour)
end

function onClick()
	governor = string.gsub(noctalia.readFile("/sys/devices/system/cpu/cpu0/cpufreq/scaling_governor") or "?", "\n", "")

	if useSudo then
		if governor == "powersave" then
			noctalia.runAsync("sudo cpupower frequency-set -g performance")

		else
			noctalia.runAsync("sudo cpupower frequency-set -g powersave")
		end
	else
		if governor == "powersave" then
			noctalia.runInTerminal("pkexec cpupower frequency-set -g performance")

		else
			noctalia.runInTerminal("pkexec cpupower frequency-set -g powersave")
		end
	end

	if setNoctaliaPowerState then
		if governor == "powersave" then
			noctalia.runAsync("powerprofilesctl set performance")
		end

		if governor == "performance" then
			noctalia.runAsync("powerprofilesctl set powersave")
		end
	end

	render()
end

function update()
  noctalia.setUpdateInterval(2000)
  render()
end
