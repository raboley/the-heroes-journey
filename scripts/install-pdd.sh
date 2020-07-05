gem install pdd
# Adding ruby gems to the path if it doesn't exist already
if ! echo "$PATH" | grep --quiet "/usr/local/lib/ruby/gems/2.7.0/bin"; then
    echo "No ruby in path"
    if ! grep --quiet "/usr/local/lib/ruby/gems/2.7.0/bin" ~/.bash_profile; then
        echo "Adding ruby gems to profile"
        echo export PATH='"/usr/local/lib/ruby/gems/2.7.0/bin:$PATH"' >> ~/.bash_profile
        echo 'pdd has been installed and added to your path. Either restart your terminal or enter the command `source ~/.bash_profile`'
        echo 'then you can use `pdd` to see what the output of pdd will be when pushed to the server'
    fi
fi