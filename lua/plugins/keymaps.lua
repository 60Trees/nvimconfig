return {
	{
		"LazyVim/LazyVim",
		opts = {},
		config = function()
			local map = vim.keymap.set

			-- VSCode-ish explorer
			map("n", "<leader>e", ":Neotree toggle<CR>")

			-- hover
			map("n", "<leader>hh", "K", { desc = "Lsp hover" })
			map("n", "<leader>he", vim.diagnostic.open_float, { desc = "Error hover" })

			-- debug hover
			map("n", "<leader>hd", function()
				require("dap.ui.widgets").hover()
			end, { desc = "Debug hover" })

			map("n", "<leader>db", function()
				require("dap").toggle_breakpoint()
			end, { desc = "Toggle breakpoint" })
			map("n", "<leader>dB", function()
				require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end, { desc = "Conditional breakpoint" })
			map("n", "<leader>dL", function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end, { desc = "Log point" })
			map("n", "<leader>du", function()
				require("dapui").toggle()
			end, { desc = "Toggle debug UI" })
			map("n", "<leader>de", function()
				require("dapui").eval()
			end, { desc = "Evaluate expression" })

			-- F12 definition
			map("n", "<F12>", vim.lsp.buf.definition, { desc = "Go to definition" })
			map("n", "<F2>", vim.lsp.buf.rename, { desc = "Rename" })
			map("n", "<leader>ld", vim.lsp.buf.definition, { desc = "Go to definition" })
			map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
			map("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format document" })
			map({ "n", "i", "t" }, "<A-d>", "<cmd>NoiceDismiss<CR>", { desc = "Dismiss" }) -- Careful of typo. Noice is the plugin. It is not notice dismiss, it's noice dismiss

			-- scrolling like VSCode
			map({ "n", "v" }, "<A-j>", "<C-d>")
			map({ "n", "v" }, "<A-k>", "<C-u>")

			-- window movement + terminal escape
			local function winmove(key, cmd, direction)
				local opts = { desc = "Moves window " .. direction }
				map("n", key, cmd, opts)
				map("t", key, "<C-\\><C-n>" .. cmd, opts)
			end

			winmove("<A-H>", "<C-w>h", "left")
			winmove("<A-J>", "<C-w>j", "down")
			winmove("<A-K>", "<C-w>k", "up")
			winmove("<A-L>", "<C-w>l", "right")

			-- clipboard system
			map({ "n", "v" }, "<leader>cy", '"+y')
			map("n", "<leader>cp", '"+p')

			-- theme picker dropdown (VSCode-like)
			map("n", "<leader>s", function()
				require("telescope.builtin").colorscheme({
					enable_preview = true,
				})
			end)

			-- CMake shortcuts (VSCode CMake Tools feel)
			map("n", "<leader>dcb", ":CMakeBuild<CR>", { desc = "CMake build" })
			map("n", "<leader>dcr", ":CMakeRun<CR>", { desc = "CMake run" })
			map("n", "<leader>dcd", ":CMakeDebug<CR>", { desc = "CMake debug" })
			map("n", "<leader>dcg", ":CMakeGenerate<CR>", { desc = "CMake generate" })
			map("n", "<leader>dcp", ":CMakeSelectBuildPreset<CR>", { desc = "CMake select build preset" })
			map("n", "<leader>dct", ":CMakeSelectLaunchTarget<CR>", { desc = "CMake select launch target" })

			map("n", "<leader>tl", "<S-l>", { desc = "Go to right tab" })
			map("n", "<leader>th", "<S-h>", { desc = "Go to left tab" })
			map("n", "<leader>tL", "<leader>br", { desc = "Delete buffers to the right" })
			map("n", "<leader>tH", "<leader>bl", { desc = "Delete buffers to the left" })
			map("n", "<leader>tj", "<leader>bj", { desc = "Pick buffer" })
			map("n", "<leader>tp", "<leader>bp", { desc = "Toggle pinned buffer" })
			map("n", "<leader>tP", "<leader>bP", { desc = "Close buffers that are not pinned" })
			map("n", "<leader>tk", "<cmd>bd<CR>", { desc = "Close tab" })
			map("n", "<leader>;w", "<cmd>w<CR>", { desc = "Write" })

			map("i", "<C-BS>", "<C-w>", { desc = "Backspace whole word", noremap = true })

			if not vim.g.neovide then
				return
			end

			-- Neovide only

			vim.g.neovide_scale_factor = 1

			local function ResizeGuiFont(delta)
				vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
			end

			local function ResetGuiFont()
				vim.g.neovide_scale_factor = 1
			end

			ResetGuiFont()

			local opts = { noremap = true, silent = true }
			local zoomIntensity = 1.1

			vim.keymap.set({ "n", "i", "c", "t" }, "<C-+>", function()
				ResizeGuiFont(zoomIntensity)
			end, opts)

			vim.keymap.set({ "n", "i", "c", "t" }, "<C-_>", function()
				ResizeGuiFont(1 / zoomIntensity)
			end, opts)

			vim.keymap.set({ "n", "i", "c", "t" }, "<C-S-BS>", function()
				ResetGuiFont()
			end, opts)

			vim.keymap.set("n", "<C-/>", "gcc", { desc = "Comment line" })
			vim.keymap.set("i", "<C-/>", "gcc", { desc = "Comment line" })
		end,
	},
}
