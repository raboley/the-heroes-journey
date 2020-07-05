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

# Script Examples in Documentation using Embedme

Problem: I create documentation with code samples from scripts that become out of date as I update scripts but forget to update the overall documentation.

Solution: embed script paths into script blocks and run embedme prior to commit so that it will populate script contents into the script blocks automatically keeping any script content up to date.
This is run as a git pre-commit hook so that prior to a commit that impacts either the scripts directory, or the index.html.md file, embedme will run and update any urls then add the files and commit them.

Example: script blocks need to have specific extensions for embedme to work. There are a lot of scriptblock extensions documented in the [README.md for embedme](https://github.com/zakhenry/embedme#multi-language). The [EmbedMe README.md](https://github.com/zakhenry/embedme#embedme) does a great job explaining how it works with a simple gif example at the top, but for an example used in this repo see below explaining how the pre-commit hook works.

> Note that the path to the script needs to be absolute, or relative to the path of the script being injected. That is why the paths below are ../ because this file is in the source/ directory, and not the root so we need the scripts to be referenced one directory above.

For this example I will purposely use shell, when it needs to be sh for embedme to work on shell scripts (so my example stays in tact). Below is a shell block with a reference to the file .pre-commit.sh and nothing else.

```shell
# ../.pre-commit.sh
```

After running embedme on this example **note I would have to change shell to sh for this to work, which can be seen in the next example.**

```sh
npx embedme ./source/index.html.md
```

Then the contents of the precommit script will automatically be updated in the script block like below.

```sh
# ../.pre-commit.sh

source ~/.bash_profile
# embedme pre-commit hook so that if some script or documentation 
# was updated to include more scripts the documentation pages get updated
. ./scripts/pre-commit-filter.sh ". scripts/embedme.sh; git add ./source/index.html.md"
# Pdd pre-commit hook so that if there is going to a pdd issue it is caught prior to commit.
. ./scripts/pdd-commit-hook.sh
```

This command is idempotent, so it can be run over and over again. This will allow us to update this script block automatically as the underlying scripts are updated. The next question is how do we make this happen automatically? Enter [githooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks).

## Githook

The embedme command gets right before commiting to ensure that the index.html.md file is always up to date. This is achieved through adding a git [pre-commit hook](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks). This is a script that is stored in the .git/hooks directory of your project and is not normally saved in source control. by naming the file `pre-commit` it tells git to run that script prior to commiting any code. In this repo we store the script in source control, and then create a [symlink](https://www.makeuseof.com/tag/what-is-a-symbolic-link-what-are-its-uses-makeuseof-explains/) during the `make init` command so that every person that uses this repo can have the same pre-commit hook without manual steps of creating it and putting it in the .git/hooks directory of their project.

that causes the [.pre-commit.sh](.pre-commit.sh) script to get run every time a user commits their code to this repo.

That script runs some more scripts in it, but we will focus on one.

```sh
# ../.pre-commit.sh

source ~/.bash_profile
# embedme pre-commit hook so that if some script or documentation 
# was updated to include more scripts the documentation pages get updated
. ./scripts/pre-commit-filter.sh ". scripts/embedme.sh; git add ./source/index.html.md"
# Pdd pre-commit hook so that if there is going to a pdd issue it is caught prior to commit.
. ./scripts/pdd-commit-hook.sh
```

The pre-commit-filter.sh script referenced above will run the commands passed to it only if it meets a given criteria. In this case it is if any of the staged files are in the /scripts directory, or are the [./source/index.html.md](./source/index.html.md) file.

This is because the pre-commit hook using npx takes time to run, and we only want to run it if a file that could potentially be used in that as a reference is updated.

Then the commands passed in are to run the embedme.sh script, and then add the new updated [./source/index.html.md](./source/index.html.md) that has been modified by the embedme command. 

The embedme.sh script is very simple

```sh
# ../scripts/embedme.sh

# testing the new filter
npx embedme ./source/index.html.md
```

which just runs the command to embed source code in the [./source/index.html.md](./source/index.html.md) file.

The git add is very important to do after that, otherwise it will update the file, but not commit it leaving the next change to be commited manually by the user.

The result of all that leaves us with an [./source/index.html.md](./source/index.html.md) file that is always up to date with any code files that are embedded within it.

# Multiple Language Tab Options with Slate

@todo #10:30mins Create documentation for what slate is, how to install it, run it locally, and view it published.

# Diagrams embedded into Documentation using Lucidchart

@todo #11:15mins Show process for embedding lucid charts into the slate document.

# Small Incremental changes with PDD

@todo #12:60mins Describe PDD with links to talks, explain how to create puzzles, setup githooks locally, install pdd, and close puzzles with examples.

# Generate Infrastructure Diagrams from Terraform With CloudCraft

@todo #13:60mins Describe cloudcraft, create terraform files as an example, link the cloudcraft diagram to this somehow.

# Execute Code Examples in Documentation with DREDD

@todo #14:60mins Describe DREDD, install process, how to write a test in documentation, execute the tests and create a github action to run these tests.

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