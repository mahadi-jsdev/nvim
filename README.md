# 🚀 Neovim Configuration

A modern, modular Neovim setup optimized for web development with full LSP support, fast autocomplete, formatting, and more. Built with lazy.nvim for efficient plugin management.

## 📁 Project Structure

```
~/.config/nvim/
├── init.lua                    # Main entry point
├── lazy-lock.json             # Plugin lock file
├── .luarc.json               # Lua language server config
├── lua/
│   ├── config/               # Core configuration
│   │   ├── options.lua       # Neovim options
│   │   ├── keymaps.lua       # Key mappings
│   │   ├── autocmds.lua      # Auto commands
│   │   ├── lazy.lua          # Lazy.nvim setup
│   │   └── lsp.lua           # LSP configuration
│   └── plugins/              # Plugin configurations
│       ├── blink.lua         # Blink.cmp completion
│       ├── conform.lua       # Code formatting
│       ├── lualine.lua       # Status line
│       ├── mason.lua         # LSP/DAP installer
│       ├── nvim-lsp.lua      # LSP client
│       ├── snacks.lua        # Snacks.nvim utilities
│       ├── treesitter.lua    # Syntax highlighting
│       ├── yazi.lua          # File manager
│       └── ...               # Other plugins
├── snippets/                 # Code snippets
│   ├── all.json
│   ├── javascript.json
│   ├── typescript.json
│   └── typescriptreact.json
└── colors/                   # Custom color schemes
```

## 🎨 Features

### 🌈 UI & Experience

- **Lualine** - Beautiful status line with git integration
- **Nerd Fonts** - Icon support throughout the interface
- **Rounded Windows** - Modern UI with rounded borders
- **Relative Line Numbers** - Enhanced navigation
- **Code Folding** - Intelligent folding with nvim-ufo

### 🔍 Navigation & Search

- **Snacks.nvim** - Unified picker for files, buffers, grep, and more
- **Yazi** - Modern file manager with preview capabilities
- **Flash.nvim** - Enhanced search and navigation
- **Buffer Navigation** - Easy switching between buffers

### 🧠 Language Support

- **LSP** - Full language server support for:
  - JavaScript/TypeScript (ts_ls)
  - HTML/CSS (html, cssls)
  - Lua (lua_ls)
  - Tailwind CSS (tailwindcss)
  - ESLint (eslint)
- **Treesitter** - Enhanced syntax highlighting and parsing
- **Auto Tag** - Automatic HTML/XML tag closing
- **Template Strings** - JavaScript template string support

### ⚡ Development Tools

- **Blink.cmp** - Ultra-fast autocompletion engine
- **Conform** - Code formatting with Prettier/Stylua
- **Multicursor** - Multiple cursor editing with mouse support
- **LazyGit** - Git integration
- **Fidget** - LSP progress notifications
- **Todo Comments** - Highlight and manage TODO comments
- **Session Management** - Automatic session persistence

### 🛠️ Code Editing

- **Multiple Cursors** - Edit multiple lines simultaneously
- **Code Folding** - Intelligent code folding
- **Auto Formatting** - Format on save with fallback
- **Smart Indentation** - Context-aware indentation
- **Auto Pairs** - Automatic bracket/parenthesis completion
- **Neogen** - Generate documentation comments

## ⌨️ Key Mappings

### Basic Navigation

| Key          | Action                    |
| ------------ | ------------------------- |
| `Ctrl + s`   | Save file                 |
| `Ctrl + v`   | Vertical split            |
| `Ctrl + j/k` | Next/Previous buffer      |
| `Ctrl + x`   | Delete buffer             |
| `ESC`        | Clear search highlighting |
| `zz`         | Toggle fold               |

### Search & Find (Snacks.nvim)

| Key             | Action                                  |
| --------------- | --------------------------------------- |
| `Space + Space` | Find files                              |
| `Ctrl + f`      | Live grep (normal) / Grep word (visual) |
| `Ctrl + l`      | Search lines                            |
| `Space + fb`    | Find buffers                            |
| `Ctrl + g`      | Git status                              |
| `-`             | Open Yazi file manager                  |
| `Ctrl + e`      | Open folders only (Yazi)                |

### Code Actions (LSP)

| Key          | Action                   |
| ------------ | ------------------------ |
| `K`          | Hover documentation      |
| `gd`         | Go to definition         |
| `gr`         | Find references          |
| `gs`         | Find symbols             |
| `Space + lr` | Rename symbol            |
| `Space + la` | Code actions             |
| `Space + ld` | Line diagnostics         |
| `Space + ll` | Show all diagnostics     |
| `Space + ff` | Organize imports         |
| `[d` / `]d`  | Previous/Next diagnostic |

### QuickFix Navigation

| Key       | Action                 |
| --------- | ---------------------- |
| `Alt + o` | Open QuickFix          |
| `Alt + x` | Close QuickFix         |
| `Alt + j` | Next QuickFix item     |
| `Alt + k` | Previous QuickFix item |

### Line Manipulation

| Key                  | Action                 |
| -------------------- | ---------------------- |
| `Alt + u`            | Move line up           |
| `Alt + d`            | Move line down         |
| `Alt + u/d` (Visual) | Move selection up/down |
| `=`                  | Resize window wider    |

### Multiple Cursors

| Key                 | Action                   |
| ------------------- | ------------------------ |
| `Alt + Left Click`  | Add cursor at position   |
| `Ctrl + o` (Visual) | Add cursor for selection |
| `ESC`               | Toggle/clear cursors     |

### Git Integration

| Key          | Action       |
| ------------ | ------------ |
| `Space + gg` | Open LazyGit |

### Completion (Blink.cmp)

| Key            | Action               |
| -------------- | -------------------- |
| `Ctrl + Space` | Show/hide completion |
| `Ctrl + j/k`   | Navigate completion  |
| `Enter`        | Accept completion    |

## 📦 Plugins

### Core Plugins

- **[dracula/vim](https://github.com/dracula/vim)** - Beautiful dark theme
- **[nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)** - Better syntax highlighting
- **[nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)** - Fuzzy finder
- **[neovim/nvim-lspconfig](https://github.com/neovim/nvim-lspconfig)** - LSP configuration
- **[williamboman/mason.nvim](https://github.com/williamboman/mason.nvim)** - Package manager for LSP/DAP/etc

### Completion & Snippets

- **[saghen/blink.cmp](https://github.com/saghen/blink.cmp)** - Fast completion engine
- **[stevearc/conform.nvim](https://github.com/stevearc/conform.nvim)** - Formatting engine

### Utilities

- **[preservim/nerdtree](https://github.com/preservim/nerdtree)** - File explorer
- **[kdheepak/lazygit.nvim](https://github.com/kdheepak/lazygit.nvim)** - Git integration
- **[jake-stewart/multicursor.nvim](https://github.com/jake-stewart/multicursor.nvim)** - Multiple cursors
- **[nvim-mini/mini.diff](https://github.com/echasnovski/mini.diff)** - Git diff highlighting
- **[akinsho/toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)** - Terminal integration

## 🚀 Installation

1. **Backup your current config:**

   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this repository:**

   ```bash
   git clone https://github.com/yourusername/nvim-config ~/.config/nvim
   ```

3. **Install vim-plug (if not already installed):**

   ```bash
   curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   ```

4. **Open Neovim and install plugins:**

   ```bash
   nvim
   :PlugInstall
   ```

5. **Install language servers:**

   ```bash
   :MasonInstall lua-language-server typescript-language-server eslint prettier
   ```

6. **Install TreeSitter parsers:**
   ```bash
   :TSInstall javascript typescript html css lua
   ```

## 🎯 Requirements

- **Neovim 0.9+**
- **Nerd Fonts** - For icons
- **ripgrep** - For Telescope grep
- **Node.js** - For JavaScript/TypeScript LSP
- **Git** - For version control features

## 🛠️ Customization

To customize this configuration:

1. **Add new plugins:** Edit `lua/plugins/init.lua`
2. **Modify keymaps:** Edit `lua/core/keymaps.lua`
3. **Change settings:** Edit `lua/core/options.lua`
4. **Add new LSP servers:** Edit `lua/plugins/lsp.lua`

## 📝 Notes

- Configuration is modular and easy to extend
- All plugin configurations are isolated in their own files
- Key mappings are well-documented and organized
- Ready for modern web development workflows

## 🤝 Contributing

Feel free to fork this configuration and customize it to your needs. Pull requests for improvements are welcome!

## 📄 License

This configuration is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
