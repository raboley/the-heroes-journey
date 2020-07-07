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

@todo #34:30mins Write a real introduction with getting started commands.

<div style="width: 480px; height: 360px; margin: 30px; position: relative;"><iframe allowfullscreen frameborder="0" style="width:480px; height:360px" src="https://app.lucidchart.com/documents/embeddedchart/3bb76760-6e9b-4405-bd06-0f20594a0c6c" id="mOfa7samMO-B"></iframe></div>

@todo #34:30mins Create section explaining githook as a general concept, and then reference the other githook sections here.

# Project Specific Concepts

There are some project specific implementations that help development processies that will be covered in this section. It will go over the generic things and how they are implemented in this project and link to the specifics.

## Makefile

> to install dependencies of this repo run

```shell
make init
```

> this requires ruby, and will setup a git pre-commit hook

Makefiles can be super complicated, but this project uses it to enable some simple commands to get things started quickly. They basically let you run commands starting with make in the terminal and then it will execute all commands defined by that target in the [makefile](../makefile)

`make init` will run commands to initialize a new repo and install some of the dependencies.

> To get a view of what the docs will look like locally run

```shell
make serve-docs
```

> then open [http://localhost:4567](http://localhost:4567) in your browser
> **Note** you will have to refresh the browser to see changes.

`make serve-docs` will run commands to serve the documentation in your local browser on [http://localhost:4567](http://localhost:4567)

> After adding script blocks, or updating scripts run

```shell
make embedme
```

> to update script blocks. (this will happen on commit regardless)

`make embedme` will run embedme on markdown documentation files to add script contents to script blocks.

## githooks

> To enable the githook(s) for this project run

```shell
make init
```

> The contents of the git hook are a set of scripts

```sh
# ../.pre-commit.sh

source ~/.bash_profile
# embedme pre-commit hook so that if some script or documentation 
# was updated to include more scripts the documentation pages get updated
. ./scripts/pre-commit-filter.sh ". scripts/embedme.sh; git add ./source/index.html.md"
# Pdd pre-commit hook so that if there is going to a pdd issue it is caught prior to commit.
. ./scripts/pdd-commit-hook.sh
```

Githooks allow for events to trigger commands based on git commands. This project uses githooks to run certain commands prior to doing a commit. This allows documentation to be up to date, puzzles to always be correctly formed, and in the future potentially code linters to run.

These are shared in source control by having scripts in the root of the repsitory and then using a symlink to link that file to the .git/hook folder where githooks need to be stored to be correct. The bad part is that those .git/hooks are not shared in version control, so a symlink is the best way to do it.

The githook is just a set of scripts/steps that will run whenever `git commit` command is run before it completes.

There are two githooks in this project, more info can be seen in those sections

* [embedme](#githook-embedme)
* [pdd](#githook-pdd)

# EmbedMe - Auto-Updating script block documentation

EmbedMe allows one to keep documentation in script blocks up to date.

## Problem It Solves

I create documentation with code samples from scripts that become out of date as I update scripts but forget to update the overall documentation.

## Solution

```sh
# ../scripts/embedme.sh

# Only run embedme on the index.html.md file for slate because
# currently that is the only file that has script references
# embedded into it.
npx embedme ./source/index.html.md
```

EmbedMe takes a script path from a script block and populates that script block with the content of the script. This will ensure that every time EmbedMe is run it will keep those script blocks up to date.

The next issue that arises is you have to remember to run EmbedMe prior to commiting code changes. That problem is solved with a git pre-commit hook. With a pre-commit hook, prior to commiting a file that impacts either the scripts directory, or the index.html.md file, embedme will run and update any urls then add the files and commit them.

## Example Usage

> inject this reference to a script in the md file (index.html.md for this example)

```shell
# ../.pre-commit.sh
```

> execute embedme on the file containing this reference (note yours should be sh above, not shell for it to work.)

```sh
npx embedme ./source/index.html.md
```

> Then the contents of the precommit script will automatically be updated in the script block like below.

```sh
# ../.pre-commit.sh

source ~/.bash_profile
# embedme pre-commit hook so that if some script or documentation 
# was updated to include more scripts the documentation pages get updated
. ./scripts/pre-commit-filter.sh ". scripts/embedme.sh; git add ./source/index.html.md"
# Pdd pre-commit hook so that if there is going to a pdd issue it is caught prior to commit.
. ./scripts/pdd-commit-hook.sh
```

Script blocks need to have specific extensions for embedme to work. There are a lot of scriptblock extensions documented in the [README.md for embedme](https://github.com/zakhenry/embedme#multi-language). Also the [EmbedMe README.md](https://github.com/zakhenry/embedme#embedme) does a great job explaining how it works with a simple gif example at the top.

> Note that the path to the script needs to be absolute, or relative to the path of the script being injected. 

That is why the paths below are ../ because this file is in the source/ directory, and not the root so we need the scripts to be referenced one directory above.

For this example I will purposely use shell, when it needs to be sh for embedme to work on shell scripts (so my example stays in tact). Below is a shell block with a reference to the file .pre-commit.sh and nothing else.

After running embedme on this example **note I would have to change shell to sh for this to work, which can be seen in the next example.**

This command is idempotent, so it can be run over and over again. This will allow us to update this script block automatically as the underlying scripts are updated. The next question is how do we make this happen automatically? Enter [githooks](https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks).

## Githook EmbedMe

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

# Only run embedme on the index.html.md file for slate because
# currently that is the only file that has script references
# embedded into it.
npx embedme ./source/index.html.md
```

which just runs the command to embed source code in the [./source/index.html.md](./source/index.html.md) file.

The git add is very important to do after that, otherwise it will update the file, but not commit it leaving the next change to be commited manually by the user.

The result of all that leaves us with an [./source/index.html.md](./source/index.html.md) file that is always up to date with any code files that are embedded within it.

# Slate - Dynamic Docs With Language Tabs

## Problem

Code is complicated, and sometimes you have differnet languages, operating systems or frameworks to deal with and normal markdown just isn't enough. There needs to be an easier to navigate documentation system that allows for langauge tabs and more dynamic documentation styles.

## Solution

[Slate](https://github.com/slatedocs/slate) is web based documentation system that has a description pane and a code pane so that it is easy to follow code examples on the right hand side of the window, and more prose like descriptions in the middle with an easy to navigate table of contents on the left. It even has search functionality. The best thing about slate is you can embed code examples and allow users to select from different tabs based on what is needed for them. It also lets you embed html into the document, so more advanced constructs can be added such as embedding a live lucidchart into the documentation. All this allows for documentation to be live realtime, more easy to understand and navigate while all being written in an [extended markdown](https://github.com/slatedocs/slate/wiki/Markdown-Syntax) syntax.

## Installation

```shell
make init
```

To add slate to your project the easist thing is to clone their repo, and start modifying it to fit your project as described in their [getting started guide](https://github.com/slatedocs/slate/wiki/Using-Slate-Natively). Once you have a slate project setup or you have just downloaded a repo with slate that you want to work on locally, you can install dependencies depending on your OS, such as these [macOS dependency install instructions](https://github.com/slatedocs/slate/wiki/Using-Slate-Natively#installing-dependencies-on-macos)

after you have the dependencies installed you can run `make init` to install all the ruby gems needed for slate to run successfully. Under the hood it is just a `bundle install` command.

## Running Slate locally

> Run slate locally

```shell
make serve-docs
```

> Open [http://192.168.0.49:4567](http://192.168.0.49:4567) in browsers

To run slate locally simply run `make serve-docs` to serve the documents on your localhost. then you can go to [http://192.168.0.49:4567](http://192.168.0.49:4567) to view your documents locally. The nice thing is as long as the process is running you can make updates to this document and then refresh the browser to see the effects.

@todo #22:30mins For slate figure out a good way to do local development with an auto refresh like situation.

This browser link happens using the [middleman](https://middlemanapp.com/basics/install/) web server application. It will host the website using ruby runtime.

## Deploying Your docs to Github Pages

> deploy to github pages use

```shell
. ../deploy.sh
```

> or just commit to master branch

Once you have your slate docs working locally you can [publish them to GitHub Pages](https://github.com/slatedocs/slate/wiki/Deploying-Slate).

This repo is setup with a GitHub action that will do this automatically on `master` branch.

> if you use the slate repo as a template it will also have the github action setup to do so on `main` branch.

The GitHub action is configured in the [.github/workflows/deploy.yml] file. It will run the steps to publish this documentation to GitHub pages.

The docs can be read from this github page

[https://raboley.github.io/the-heroes-journey](https://raboley.github.io/the-heroes-journey)

your own github pages site will be published with this pattern if you use the same template `https://<your-github-username>.github.io/<github-repository-name>`

> Note: The first time you publish your github pages you have to manually do it from your laptop as an admin account.

To publish your documentation to github pages run the deploy script

```shell
. deploy.sh
```

This will create a branch called gh-pages and publish the documentation static content to it. Then have github pages host that content.

> Note: Terminal exited 1 when I ran it first time, but it still worked anyways.

After it has been done the first time the github action should be able to successfully publish your docs to your url.

# LucidChart - Diagrams embedded into Documentation

## Problem

High leven design charts quickly become out of date if they are hard coded into documentation as an image. They are also much less valuable if they only exist as a url.

## Solution

Lucid chart allows you to embed charts as html objects, and slate allows you to publish raw html leading to documentation always being up to date with source design charts.

## Example

Simply by going to lucid chart and creating a new document, then select embed and copy the embed url.

> To make a gif like this you can screen cap your screen on mac using
>
> `cmd + shift + 5`
>
> Which will generate a mov file. You can then convert that mov file to a gif using any online converting service. Finally link the gif with a relative path adding a ! before the url style link like above.

![lucid_chart_embed_link_demo.gif](https://github.com/raboley/the-heroes-journey/blob/master/docs/videos/lucid_chart_embed_link_demo.gif?raw=true)

> The embed link in the video will look something like below:

```html
<div style="width: 480px; height: 360px; margin: 10px; position: relative;">
  <iframe
    allowfullscreen
    frameborder="0"
    style="width:480px; height:360px"
    src="https://app.lucidchart.com/documents/embeddedchart/e9f142be-ca5e-4177-8f14-36c544f655ca"
    id="phyaKTPhMxyz">
  </iframe>
</div>
```

> it can just be pasted anywhere outside of a code block to have it render the html and show the image.

<div style="width: 480px; height: 360px; margin: 10px; position: relative;"><iframe allowfullscreen frameborder="0" style="width:480px; height:360px" src="https://app.lucidchart.com/documents/embeddedchart/e9f142be-ca5e-4177-8f14-36c544f655ca" id="phyaKTPhMxyz"></iframe></div>

Now whenever that [source lucid chart](https://app.lucidchart.com/documents/edit/e9f142be-ca5e-4177-8f14-36c544f655ca/-gyaVl7tAo0L#?folder_id=home&browser=icon) is updated you will see it update here shortly after. No more repeat copy paste or stale diagrams

# Small Incremental changes with PDD

## Problem

Features and improvemnts are really hard to fit into small chunks. PDD enables really small incremental improvements that should last for a very short amount of time. This combats the feeling that something we think will be easy and take an hour ends up requiring 3 weeks to fully complete.

## Solution

With PDD you just spend the amount of time that the puzzle says to do, and do as much as possible then creating additional puzzles to fill in the gaps. Allowing things to be complete, even though it isn't 100% completed, but it is in a better state and closer to that 100% done. This allows people to get something done without spinning their wheels for days to get something added.

## Example

I can't do actual puzzle syntax in this, so I will use to-do and to make it a real puzzle you just have to remove the `-` from the to-do to make it real.

> an example would be something like this
>
> @to-do #[parent-issue]:[amount of time it should take]/[role that should complete this task] [description of the task]
>
> So for example the issue that created this documentation looked like this:
>
> @to-do #18:15mins Create the problem, solution and example for PDD.
>
> you can omit the role if you want, since I am doing all the work it is pointless for me.

The important thing is to have an issue to link it to. So if you want to do something manually create an issue in github and then you can start chaining puzzles based on that issue. The idea being that once all child issues are closed automatically as puzzles you can close the manual github issue manually. If you spend 30 mins and find it isn't done yet, you can create another puzzle to finish the rest of it.

> @to-do #30:15mins Create movie to show how pdd examples work

For this example it probably doesn't need a another issue, but if it did I could create a child issue from that to expand upon.
So in this instance hte issue that was created by the original puzzle was #30 so my next puzzle could be something like:

Then I would remove the original puzzle from source control because that was completed (the lines that describe #30 which would be `@to-do #18:15mins Create the problem, solution and example for PDD.`) and then move on and the next person can fix it as the next puzzle, but the original puzzle #30 would be closed by pdd.

## PDD in action

> Note: pdd does some string searching for the words to-do (remove the `-`) and if there is any instance of that word without proper tag formatting it will try to create a ticket based on it and break. Originally it wouldn't work because I had those words in code I didn't write so it was trying to create puzzles based on it and throwing an error and then just not doing anything. To fix that I did a find and replace for all instances of that word and ran pdd locally to confirm there were no errors.

The best way to see and understand pdd is to [watch the webinar](https://www.yegor256.com/2017/04/05/pdd-in-action.html) that explains it, and talks about 0pdd, the service that creates and closes issues in github based on puzzles left in documents.

## Install PDD locally

```shell
# ../scripts/install-pdd.sh
```

There are two versions of [pdd](https://github.com/yegor256/pdd), [0pdd](https://github.com/yegor256/0pdd) and [pdd](https://github.com/yegor256/pdd). [0pdd](https://github.com/yegor256/0pdd) is the hosted version of pdd that we send git commit into to so that it can automatically create puzzles. Meanwhile pdd is the command line tool that you can run locally to verify which puzzles would be created by [0pdd](https://github.com/yegor256/0pdd. Installing [pdd](https://github.com/yegor256/pdd) locally is pretty simple, it just consists of installing the gem and adding it to your path. This will happen automtaically using `make init`, but can be manually installed using install-pdd.sh script.

> Note: you need to add the ruby gems bin to your path to make it work. The script will install it to your .bash_profile so if you are using zsh you will need to add it to your path manually.

```shell
# Run pdd against everything
pdd

# Run it but exclude some files
pdd --exclude=src/**/*.java --exclude=target/**/*
```

Once it is installed and in your path you can run it from terminal. It will throw an error if you have incorrectly formatted puzzles, and show output of what would be created if you have all correctly formatted puzzles.

## Githook pdd

> The commit hook command is pretty simple for now, but in the future if there were rules that needed to be added, or files excluded they would be added here.

```shell
# ../scripts/pdd-commit-hook.sh
```

Much like the embedme githook, in this repo there is a pdd githook. It will run pdd prior to committing to ensure that no one is committing malformed puzzles. If there is a malformed puzzle the commit will not go through until the puzzles are corrected.

This githook is included in the .pre-commit.sh file that symlinked with the .git/hooks/pre-commit file so that this config can be stored in the repo. Once running `make init` it will set this symlink up for you.

@todo #18:30mins explain how to setup the pdd git action in GitHub

## GitHub Action

It isn't required, but I setup a GitHub action to run pdd on each commit so that we can tell when malformed puzzle commands come through and cause an issue that is clear in the repository. The action just runs the pdd command to ensure it exits successfully.

The action is located in [.github/workflows/pdd.yml](../.github/workflows/pdd.yml)

It basically just gets ruby setup to the correct version then runs the pdd commit hook.

If it finds a malformed puzzle it will error, otherwise it will succeed the build. It doesn't create the issues in github, that is done via the webhook on commit.

## Webhook

pdd is automated using a webhook which on every commit pushed to GitHub notifies 0pdd who then creates/closes issues based on puzzles left in the repository. It is a pretty simple implementation and works almost instantly. Just have follow the documentation posted on their [pdd in action page](https://www.yegor256.com/2017/04/05/pdd-in-action.html).

> Note: I had a lot of trouble getting it to work originally when following the instructions, but that is because there were all sorts of malformed puzzles in my code (that I didn't write). It should just work seemlessly as long as you don't have malformed puzzles. An issue is that in the webhook history it will return 200s whether the puzzles are all good, or malformed, so you won't have any idea that something is wrong until you run pdd locally.

# Generate Infrastructure Diagrams from Terraform With CloudCraft

CloudCraft allows you to design architecture as diagrams then generate TF files based on those designs. In addition it will also let you connect to your AWS subscription and generate diagrams based on live infrastructure which is interesting.

I don't really feel like doing much more about this at this time since it only works for AWS. Also it outputs terragrunt files that provide one way to make the way I don't like doing terraform code less terrible. That way is when you have a folder for every environment in your tf repo, and then manually update each tf file in each folder as things progress between environments. I would much rather have one instance in it, and then have a pipeline dictate the different values that should be done per each environment.

Seems like update to code via these diagrams would be a manual process, and be hard to maintain. It is a cool idea, but don't think it is worth exploring right now.

# Execute Code Examples in Documentation with DREDD

@todo #14:60mins Describe DREDD, install process, how to write a test in documentation, execute the tests and create a github action to run these tests.

# Initialization
  
```sh
# ../scripts/embedme.sh

# Only run embedme on the index.html.md file for slate because
# currently that is the only file that has script references
# embedded into it.
npx embedme ./source/index.html.md
```

# GoCli

@todo #41:60mins Create a go cli tool that generates golang documentation via godocs. To make goslate be more useful I think it is important to figure out how to create a cli tool with go that generates documentation so that I can see if it really is a game changer, or if it will just be a different way to do the same thing I already do.

# GoSlate

@todo #41:30mins Create goslate example code

## Installing locally

[install golang](https://ahmadawais.com/install-go-lang-on-macos-with-homebrew/) ensuring you add it to your path.

```shell
go get -u github.com/growler/go-slate
```

install goslate using `go get`

go-slate assumes the following source tree:

    src
    └── service
        ├── main.go
        └── apidoc

@todo #41:30mins document how to run goslate locally

@todo #41:30mins publish goslate docs to github pages

@todo #41:30mins Create github action to publish goslate docs to github pages

@todo #41:15mins update the pre-commit hook to use goslate commands instead of ruby slate.
