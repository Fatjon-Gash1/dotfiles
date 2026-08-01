function rml --description 'Refreshes current pacman mirrorlist'
    sudo reflector --save \
        /etc/pacman.d/mirrorlist \
        -c France,Germany \
        -p https \
        -l 10 \
        --sort score \
        -f 5
end
