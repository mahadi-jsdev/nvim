# 🚀 Neovim Configuration

A modern, modular Neovim setup optimized for web development with full LSP support, autocomplete, formatting, and more.

## 📁 Project Structure

```
~/.config/nvim/
├── init.lua                
├── snippets/
│   ├── all.json
│   ├── javascript.json
│   ├── typescript.json
│   ├── typescriptreact.json 
```

## 🎨 Features

### 🌈 UI & Themes
- **Dracula** - Dark theme with vibrant colors
- **Nerd Fonts** - Icon support
- **Indent Guides** - Visual indentation
- **Mini.diff** - Git diff in sign column

### 🔍 Navigation & Search
- **Telescope** - Fuzzy finder for files, buffers, grep
- **NERDTree** - File explorer with syntax highlighting
- **Buffer Navigation** - Switch between buffers easily

### 🧠 Language Support
- **LSP** - Full language server support for:
  - JavaScript/TypeScript
  - HTML/CSS
  - Lua
  - Bash
  - Tailwind CSS
- **Treesitter** - Enhanced syntax highlighting
- **Auto Tag** - Automatic HTML/XML tag closing
- **Template Strings** - JavaScript template string support

### ⚡ Development Tools
- **Blink CMP** - Fast autocompletion engine
- **Conform** - Code formatting with Prettier/Stylua
- **Multicursor** - Multiple cursor editing
- **LazyGit** - Git integration
- **Fidget** - LSP progress notifications

### 🛠️ Code Editing
- **Multiple Cursors** - Edit multiple lines simultaneously
- **Code Folding** - Intelligent code folding
- **Auto Formatting** - Format on save
- **Smart Indentation** - Context-aware indentation

## ⌨️ Key Mappings

### Basic Navigation
| Key | Action |
|-----|--------|
| `Ctrl + s` | Save file |
| `Ctrl + v` | Vertical split |
| `Ctrl + \` | Toggle terminal |
| `Ctrl + a` | Toggle NERDTree |
| `Ctrl + →/←` | Next/Previous buffer |
| `Ctrl + x` | Close buffer |

### Search & Find
| Key | Action |
|-----|--------|
| `Space + Space` | Find files |
| `Ctrl + /` | Live grep |
| `Ctrl + b` | Find buffers |
| `Ctrl + g` | Git status |

### Code Actions
| Key | Action |
|-----|--------|
| `K` | Hover documentation |
| `gd` | Go to definition |
| `gr` | Find references |
| `Space + lr` | Rename symbol |
| `Space + la` | Code actions |
| `Space + ld` | Line diagnostics |

### QuickFix Navigation
| Key | Action |
|-----|--------|
| `Alt + o` | Open QuickFix |
| `Alt + x` | Close QuickFix |
| `Alt + j` | Next QuickFix item |
| `Alt + k` | Previous QuickFix item |

### Line Manipulation
| Key | Action |
|-----|--------|
| `Alt + ↑/↓` | Move line up/down |
| `Alt + ↑/↓` (Visual) | Move selection up/down |

### Git Integration
| Key | Action |
|-----|--------|
| `Space + gg` | Open LazyGit |

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
