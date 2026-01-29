local M = {}

local seconds_left = 0
local is_running = false
local is_paused = false
local timer_handle = nil
local current_task = ""

local function parse_time(input)
	if not input then
		return nil
	end
	local count, unit = input:match("(%d+)([hm])")
	if not count then
		return nil
	end

	count = tonumber(count)
	if unit == "h" then
		return count * 3600
	end
	if unit == "m" then
		return count * 60
	end
	return nil
end

-- Internal function to start/resume the ticking logic
local function start_ticking()
	is_running = true
	is_paused = false
	timer_handle = vim.loop.new_timer()
	timer_handle:start(
		0,
		1000,
		vim.schedule_wrap(function()
			if seconds_left <= 0 then
				M.stop_timer()
				vim.notify("Time's up for: " .. current_task, vim.log.levels.WARN, { title = "🍅 Pomodoro" })
			else
				seconds_left = seconds_left - 1
			end
		end)
	)
end

function M.stop_timer()
	if timer_handle then
		timer_handle:stop()
		timer_handle:close()
		timer_handle = nil
	end
	is_running = false
	is_paused = false
	current_task = ""
	seconds_left = 0
end

function M.pause_resume()
	if not is_running and not is_paused then
		vim.notify("No timer active to pause.", vim.log.levels.WARN)
		return
	end

	if is_paused then
		-- Resume
		is_paused = false
		start_ticking()
		vim.notify("Timer Resumed: " .. current_task)
	else
		-- Pause
		if timer_handle then
			timer_handle:stop()
			timer_handle:close()
			timer_handle = nil
		end
		is_paused = true
		is_running = false
		vim.notify("Timer Paused: " .. current_task)
	end
end

function M.start_custom_timer()
	if is_running or is_paused then
		vim.notify("A timer is already active!", vim.log.levels.WARN)
		return
	end

	vim.ui.input({ prompt = "Task Name (Optional): " }, function(task)
		-- Allow empty task name
		current_task = (task == nil or task == "") and "Focus" or task

		vim.ui.input({ prompt = "Duration (e.g., 25m, 1h): " }, function(duration)
			local seconds = parse_time(duration)
			if not seconds then
				if duration ~= nil then -- Only warn if they didn't just hit Esc
					vim.notify("Invalid format! Use '25m' or '1h'.", vim.log.levels.ERROR)
				end
				return
			end
			seconds_left = seconds
			start_ticking()
		end)
	end)
end

function M.get_status()
	if not is_running and not is_paused then
		return ""
	end

	local h = math.floor(seconds_left / 3600)
	local m = math.floor((seconds_left % 3600) / 60)
	local s = seconds_left % 60
	local time_str = h > 0 and string.format("%dh %02dm", h, m) or string.format("%02d:%02d", m, s)

	local icon = is_paused and "⏸ " or "🍅"
	return string.format("%s [%s] %s", icon, current_task, time_str)
end

-- KEYMAPS
vim.keymap.set("n", "<leader>pt", M.start_custom_timer, { desc = "Start Custom Pomodoro" })
vim.keymap.set("n", "<leader>pp", M.pause_resume, { desc = "Pause/Resume Pomodoro" })
vim.keymap.set("n", "<leader>pq", M.stop_timer, { desc = "Stop/Clear Pomodoro" })

return M
