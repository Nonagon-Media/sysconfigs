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
