# The Heroes Journey


The hero will go through a journey to take drab README.mds into a new world allowing for flexibility and a new level of embedding for code. He will bring these learnings back to his home making all this documentation clear and executable.

this will include:

* Embedding the contents of code files into documentation ([embedme](https://github.com/zakhenry/embedme))
* Enabling tab controls to allow for multiple versions of code to be contained in one set of documentation ([slate](https://github.com/slatedocs/slate/wiki/Markdown-Syntax))
* Embed diagramming into documentation as a living diagram not an image ([lucidChart + Github](https://www.lucidchart.com/pages/integrations/github))
* Automatically create issues using puzzle development ([pdd](http://www.0pdd.com))
* ?generate diagrams for infrastructure from terraform code ([cloudCraft](https://medium.com/faun/modules-tf-convert-visual-aws-diagram-into-terraform-configurations-e61fb0574b10))
* Execute examples in documentation to test for accuracy ([dredd](https://rollout.io/blog/testing-code-examples-in-documentation/)) ([official](https://dredd.org/en/latest/))



## ACT 1

1. The Ordinary World

In the beginning there was only text. Documentation was akin to only what could be produced using notepad. The humble README lived to serve with his only tool of raw text.
He produced documentation in flat text form for developers around the world to read and everything was good.

2. The Call of Adventure

As time went on applications became more complex, and README began etching more and more text describing these systems. Soon developers around the world got tired of the flat documents README produced and wanted something more dynamic and easier to understand.

3. Refusal of the Call


4. Meeting the Mentor

One day a woman named Ruby entered README's office. Ruby had a red romper that seemed to move as wind brushed against her sides. She looked at the documents README produced and looked perplexed.
She brings him a stone slate.

5. Crossing the First Threshold

Looking at the slate he can see an entire world inside it.

// maybe he comes across the slate as he is doing documentation as an example?

On the stone slate there are words etched into it face.

```shell
bundle exec middleman server
```

README runs his fingers across the words and in the crevices light begins to erupt and cause the tablet to shift into the symbols:

[http://192.168.0.49:4567](http://192.168.0.49:4567)

## ACT 2

6. Tests, Allies, Enemies

Time and Help enter as enemies to README, time causing his documentation to become out of date due to Help adding features and not updating documentation.

Coming across embedme he found that the steps written as scripts could now be embedded into his documents automatically. simply by runing `npx embedme ./source/index.html.md` he was able to pull the contents from his scripts and embed them in the file automatically allowing for every step to be captured in a way that requires setup steps to work.

He later found make who helped him even further strengthen his resolve. By using `make docs` he was able to run all the steps required to generate the documentation in a way that was repeatable. Now if only this step could also be run automatically when Help added new features.

> enter git commit hooks

Now that we have a git hook to automatically update the index.html.md we found it slowed down the commit process, so we only wanted to run it if the scripts directory or index.html.md file were modified.

To do that we need to update the githook with some if logic.

By getting the diff and then grepping those files for the pattern we can run the commit hook only when files we expect to cause changes in the index.html.md to be impacted. Now it should hopefully go really fast when I commit these things.

> enter puzzle driven development

To install pdd which will allow you to see if your puzzles will be created prior to pushing to origin. If you have malformed puzzles it can break pdd and cause it to do nothing and not tell you what is happening in the webhooks.

/**
 * @todo #1:30min/DEV Run serverside pdd as a github action so that I can better troubleshoot issues with puzzles not being created.
 */

```shell
make init
```

This will install the pdd gem, and add it to bash profile so that you can run

```shell
pdd
```

to see what kind of puzzles will be created in github.

found more documentation in the [pdd source code](https://github.com/yegor256/pdd).

7. Approach to the Inmost Cave
8. The Ordeal
9. Reward (Seizing the Sword)

## ACT 3

10. The Road Back
11. Resurrection
12. Return with the Elixir
