# Tmux 1.9a1 Homebrew Tap

This tap has been created to specifically install Tmux 1.9a1, which is a patched version of Tmux 1.9a (stable). The modifications add support for parsing of nested format specifiers within command format specifiers. This let's you do things like include the following in a status bar segment:

```sh
#(runMyScriptForSession #session_name)
```

Parsing the `#session_name` format specifier within a command format specifier is not possible with an unpatched Tmux server. More info from the patch [CHANGES](https://github.com/markeissler/tmux/blob/me/statusline-shellcmd-var-substitution/CHANGES) file:

>
>* Add support for parsing of nested format specifiers within command format
>specifiers: `#(do_something.sh #{session_name})`. Both the single format
>specifiers (`#A -> #Z`) and long name specifiers (`#{foo}`) are supported. The
>attribute (#[attributes]) and nested commands (additional `#(foo)` instances)
>are not supported.
>

The git feature branch for this patch is available for review:

[Tmux 1.9a1 (on Github)](https://github.com/markeissler/tmux/tree/me/statusline-shellcmd-var-substitution)

## Installation

Run the following in your command-line:

```sh
>brew tap markeissler/tmux-19a1
```

## Usage

To list available configuration options run:

```sh
>brew options tmux-19a1
>brew info tmux-19a1
```

Once the tap is installed, you can proceed with `tmux-1.9a1` by running the following from your command-line:

```sh
>brew install tmux-19a1
```

## Why is this a tap vs a submitted improvement to tmux?

The goal is to submit a patch to the official tmux project. If the patch is accepted, then the added functionality will become available in the official binary distribution and installable via the normal _Homebrew/homebrew_ repo. However, there is no guarantee that this additional functionality aligns with the overall goals of the upstream `tmux` project:

[tmux - sourceforge.net, official website](http://tmux.sf.net/)

[tmux - Github clone of official project](https://github.com/ThomasAdam/tmux)

In the meantime, the tap is here for those that need it, want it.

## What about conflicts?

This version of `tmux` can be installed alongside the current stable install from _Homebrew/homebrew_, but there is one caveat: both versions cannot be linked at the same time! To switch between versions use `brew unlink` and `brew link` as follows:

```sh
>brew unlink tmux
>brew link tmux-19a1
```

## Bugs and such
Submit bugs by opening an issue on [this project's GitHub page](https://github.com/markeissler/homebrew-tmux-19a1).

## Credits

The `tmux-19a1` homebrew formula was based on the original formula available from [Homebrew on Github](https://github.com/Homebrew/homebrew/tree/master/Library/Formula/tmux.rb).

