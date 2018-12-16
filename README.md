# sysconfigs
Various config files for tools I use

vimrc_updated:
        an vimrc file updated with additional plugins, language-specific tab/space rules, and new coloring scheme.
        xoria code has been removed, but still exists in the old vimrc file
        May require installation of various linting tools for syntastic to work properly.
        For example: jslint requires nodejs/npm installation
        Depending on the terminal used, xoria code may make text easier to read. It has been reenabled and solarized code commented out

bashrc_redux
        an update of the bashrc file also located in this repo with the following changes
        1. No more errors in any shellcheck linting
        2. conn function has been rewritten to ignore the tld and use only the value of $1 passed to it
        3. kp function has been edited to work around shellcheck's quoting standards. Double-quotes inside double-quotes

        FUNCTIONS:
                conn is an SSH-wrapper that changes your window title if you are using tmux
                mcd creates a directory and cd's into it
                extract uncompresses a file based on it's extention. It requires the referenced compression utility to be installed
                comstat lists the user's 10 most-used commands
                sysinfo displays basic system info (duh)
                kp is a kill -9 wrapper. Kills all pids resulting from pidof $1
                charcount counts the number of characters in a given string
                installed checks to see if a package is installed (ubuntu/debian only)
                genpass creates a 20-character secure password. Requires pwgen to be installed
                genhash creates a hash of a password...but not a very strong hash. Better options exist. Requires makepasswd to work properly
                clip takes a string and puts it in your clipboard. Requires xclip
                crawl does a recursive grep on the current directory or a given directory
