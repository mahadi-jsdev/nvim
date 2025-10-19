return {
	"mfussenegger/nvim-dap",
	event = "BufReadPre", -- load DAP before opening a file
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"jay-babu/mason-nvim-dap.nvim",
		"williamboman/mason.nvim",
		"nvim-neotest/nvim-nio",
		{
			"theHamsta/nvim-dap-virtual-text",
			config = function()
				require("nvim-dap-virtual-text").setup({
					enabled = true,
					enabled_commands = true,
					highlight_changed_variables = true,
					highlight_new_as_changed = true,
					show_stop_reason = true,
					commented = false,
					only_first_definition = true,
				})
			end,
		},
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")
		local map = vim.keymap.set

		----------------------------------------------------------------------
		-- Mason + DAP Adapter Installation
		----------------------------------------------------------------------
		require("mason").setup()
		require("mason-nvim-dap").setup({
			ensure_installed = { "js-debug-adapter" },
			automatic_installation = true,
		})

		----------------------------------------------------------------------
		-- DAP UI setup
		----------------------------------------------------------------------
		dapui.setup()
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end

		----------------------------------------------------------------------
		-- Signs (breakpoints & stopped)
		----------------------------------------------------------------------
		vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError" })
		vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticInfo" })
		vim.api.nvim_set_hl(0, "DiagnosticError", { fg = "#ff5555" })

		----------------------------------------------------------------------
		-- Keymaps
		----------------------------------------------------------------------
		local keymaps = {
			{ "n", "<leader>dc", dap.continue, "DAP Continue/Start" },
			{ "n", "<leader>db", dap.toggle_breakpoint, "Toggle Breakpoint" },
			{ "n", "<leader>dt", dapui.toggle, "Toggle DAP UI" },
			{ "n", "<leader>so", dap.step_over, "Step Over" },
			{ "n", "<leader>si", dap.step_into, "Step Into" },
			{ "n", "<leader>sO", dap.step_out, "Step Out" },
			-- Watches
			{
				"n",
				"<leader>dw",
				function()
					local expr = vim.fn.input("Watch: ")
					if expr ~= "" then
						dapui.eval(expr, { context = "watch" })
					end
				end,
				"Add watch expression",
			},
		}

		for _, km in ipairs(keymaps) do
			map(km[1], km[2], km[3], { desc = km[4] })
		end

		----------------------------------------------------------------------
		-- Adapters
		----------------------------------------------------------------------
		local mason_path = os.getenv("HOME") .. "/.local/share/nvim/mason/packages/"
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = { mason_path .. "js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
			},
		}

		dap.adapters["pwa-chrome"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				args = { mason_path .. "chrome-debug-adapter/out/src/chromeDebug.js", "${port}" },
			},
		}

		----------------------------------------------------------------------
		-- Next.js / JavaScript / TypeScript Configurations
		----------------------------------------------------------------------
		local nextjs_configs = {
			{
				name = "Next.js: debug server-side",
				type = "pwa-node",
				request = "launch",
				runtimeExecutable = "npm",
				runtimeArgs = { "run", "dev" },
				console = "integratedTerminal",
				cwd = "${workspaceFolder}",
				skipFiles = { "<node_internals>/**", "**/node_modules/**" },
				sourceMaps = true,
				outFiles = { "${workspaceFolder}/.next/**/*.js" },
				resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
			},
			{
				name = "Next.js: debug client-side",
				type = "pwa-node",
				request = "launch",
				url = "http://localhost:3000",
				webRoot = "${workspaceFolder}",
				sourceMaps = true,
			},
			{
				name = "Next.js: debug full stack",
				type = "pwa-node",
				request = "launch",
				program = "${workspaceFolder}/node_modules/next/dist/bin/next",
				runtimeArgs = { "--inspect" },
				skipFiles = { "<node_internals>/**", "**/node_modules/**" },
				cwd = "${workspaceFolder}",
				sourceMaps = true,
				outFiles = { "${workspaceFolder}/.next/**/*.js" },
				resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
			},
		}

		for _, lang in ipairs({ "typescript", "typescriptreact", "javascript", "javascriptreact" }) do
			dap.configurations[lang] = nextjs_configs
		end
	end,
}
