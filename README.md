# dotfiles

My `dotfiles` managed by `GNU Stow`.

## Getting Started

### Prerequisites

Required:

- `git`: For cloning and managing the repository.
- `stow`: For symlinking and managing dotfiles.

Optional (install for full setup):

- `zsh` + [Oh My Zsh](https://ohmyz.sh/): Shell and plugin framework.
- `vim`: Text editor.
- `tmux`: Terminal multiplexer.
- `delta`: Enhanced git diff pager.
- `fastfetch`: System information tool.
- `exiftool` + `qpdf`: Required by the `clean_pdf_metadata` script.

### Installation

1. Clone the repository:

   ```bash
   git clone git@github.com:nmx7/dotfiles.git ~/dotfiles
   ```

2. Enter the directory:

   ```bash
   cd ~/dotfiles
   ```

3. Run the installation script:

   ```bash
   ./install.sh
   ```

The script automatically stows all packages and handles platform differences between macOS and Linux.

#### Install script flags

```
--dry-run    Preview what would be stowed without making changes
--verbose    Show detailed output during installation
--help       Display usage information
```

## Usage

### Stowing specific packages

To apply only a subset of configurations:

```bash
stow zsh       # Applies ONLY the zsh configuration
stow vim       # Applies ONLY the vim configuration
stow git       # Applies ONLY the git configuration
stow tmux      # Applies ONLY the tmux configuration
stow ssh       # Applies ONLY the SSH configuration
stow fastfetch # Applies ONLY the fastfetch configuration
```

### Unstowing

To remove symlinks for a package:

```bash
stow -D zsh    # Remove zsh symlinks
stow -D vim    # Remove vim symlinks
```

### Overwriting existing files

By default, `stow` will not overwrite existing files. Use `--adopt` or `--override` to handle conflicts:

```bash
stow --override zsh   # Overwrite existing files with symlinks
stow --adopt zsh      # Pull existing files into the repo, then symlink
```

> **Note:** After using `--adopt`, run `git restore .` to revert any pulled-in files back to the repo versions.

### Customizing `.stow-local-ignore`

The `.stow-local-ignore` file specifies files or directories that `stow` should skip when symlinking.

## Scripts

Custom utility scripts installed to `bin/`:

| Script | Description |
|--------|-------------|
| `git_update` | Runs a gitleaks security scan, commits with a standard message, and pushes to GitHub. |
| `git_obliterate_commits` | **Destructive.** Rewrites repository history by creating a new orphan branch and force-pushing. Use with caution. |
| `clean_pdf_metadata` | Strips metadata from PDF files using `exiftool` and `qpdf`. Supports recursive directory processing. |
| `clean_image_metadata` | Strips metadata from image files. |

## Platform Notes

- **macOS:** `bin/` scripts are installed to `/usr/local/bin` (requires `sudo`).
- **Linux:** `bin/` scripts are installed to `~/bin`.

## References

- [Using GNU Stow to manage your dot files](https://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html): Comprehensive guide on using `stow` for dotfiles management.
- [Force GNU stow to overwrite existing configuration file](https://www.reddit.com/r/linux4noobs/comments/b5ig2h/is_there_any_way_to_force_gnu_stow_to_overwrite/): Handling conflicts with `stow`.
- [GNU Stow manual](https://www.gnu.org/software/stow/manual/stow.html): Official documentation.

