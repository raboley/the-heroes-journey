---
title: The Magical World

language_tabs: # must be one of https://git.io/vQNgJ
  - shell

toc_footers:
  - <a href='#'>Sign Up for a Developer Key</a>
  - <a href='https://github.com/slatedocs/slate'>Documentation Powered by Slate</a>

includes:
  - errors

search: true

code_clipboard: true
---

# Introduction

Welcome to the Kittn API! You can use our API to access Kittn API endpoints, which can get information on various cats, kittens, and breeds in our database.

We have language bindings in Shell, Ruby, Python, and JavaScript! You can view code examples in the dark area to the right, and you can switch the programming language of the examples with the tabs in the top right.

This example API documentation page was created with [Slate](https://github.com/slatedocs/slate). Feel free to edit it and use it as a base for your own API's documentation.

<div style="width: 480px; height: 360px; margin: 10px; position: relative;"><iframe allowfullscreen frameborder="0" style="width:480px; height:360px" src="https://app.lucidchart.com/documents/embeddedchart/3bb76760-6e9b-4405-bd06-0f20594a0c6c" id="mOfa7samMO-B"></iframe></div>

# Initialization
  
```sh
# ../scripts/embedme.sh

# testing the new filter
npx embedme ./source/index.html.md
```


There are a couple things that run locally to help with development of this repo.

## Up to date scripts with embedme

## Quick, Small iterative issues with PDD

PDD is a style of development that breaks tasks down into small puzzles that can be created, at a high level then get the most basic lazy implementation added, leaving behind smaller todos called puzzles to finish the rest of the implementation.

Puzzles can be added using tags, and running pdd locally will help debug if your puzzle tags are not correct.

```sh
# ../scripts/install-pdd.sh

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
```

will install pdd locally which can then be run in terminal with

```sh
pdd
```