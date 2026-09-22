complete -c klit -f
complete -c klit -n "test (count (commandline -opc)) = 1" -a "merge grep inprod delete"
complete -c klit -n "test (count (commandline -opc)) = 2; and contains -- (commandline -opc)[1] merge inprod" -f -a "(git branch -a 2>/devrolet | grep -v 'HEAD ->')"
complete -c klit -n "test (count (commandline -opc)) -ge 2; and contains -- (commandline -opc)[1] delete" -f -a "(git branch -a 2>/dev/null | grep -v 'HEAD ->')" -k