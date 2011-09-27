# Cardigan

A simple command line project task tracking tool.

## Rationale

* command line tools are faster and cooler than any gui or web interface
* it makes sense to store work items in your source repository 
* tab completion is awesome

## Installation

    gem install cardigan

## Usage

    cardigan

This will prompt for your name and email address (and store them in ~/.cardigan), create a folder called .cards in the current directory and enter a shell.  The idea is that you will run this at the root of a git/hg/svn/whatever repository and manage the cards in the same way you manage your source code.

    cardigan >

So what now?

## Documentation

Comprehensive documentation can be found on [relish](https://www.relishapp.com/cardigan) but for a brief intro, read on.

## Listing mode

You start in listing mode.

To get the list of available commands:

    ?

To get help for a specific command:

    ? filter

Here are a few of the commands:

    touch write some documentation

... will create a new card called 'write some documentation'

    cd write some documentation

... enters edit mode for the 'write some documentation' card (note that tab completion is provided for the card name)

    ls

... will present a list of the current set of cards

    columns name estimate
    
... will change the display columns to 'name' and 'estimate'

    filter card['owner'] == me

... will filter the list of cards to show only the ones owned by you

    claim 2 4 5

... assigns cards 2, 4 and 5 to you (by setting the 'owner'). Note that these numbers are the indexes presented by the 'ls' command

    unclaim 4 5
  
... unsets the owner of cards 4 and 5

    destroy 4

... destroys card 4

    set priority 4 6 7

... prompts for a new value for the priority field on cards 4, 6 and 7

    workflow

... enters the workflow editing mode

    count priority complexity

... counts the number of cards with each value of the available combinations of priority and complexity

    count estimate priority

... presents the total of estimate for cards group in each value of priority

    export foo

... exports all cards (according to the current filter) to a csv file called foo.csv    

    import foo

... imports the contents of foo.csv - cards will be updated with a matching id, otherwise new cards will be created.

## Editing mode

Once you're in edit mode (by executing the 'cd' command in listing mode), you can edit the individual fields of a card.

    ls

... will list the current values for all fields

    set priority

... prompts for a new value for the priority field

    edit description

... launches your default editor (determined by the EDITOR environment variable) to allow you
to edit a multi line value for 'description'

    now closed

... will set the 'status' field to 'closed'

Tab completion for 'now' is determined by what the current value for 'status' and what has
been set up in workflow mode (see below).

Note that you have entered a nested shell so need to `exit` or ctrl-d to get back to listing
mode.

## Workflow mode

Workflow is pretty simple - it is just for convenience in tab completion for the 'now' command in edit mode for a card.

   ls

... dumps the current workflow (statuses with their valid subsequent statuses)

    add started completed blocked

... adds 'completed' and 'blocked' as valid transitions from 'started'

    rm started blocked

.... remove 'blocked' as a valid transitions from 'started'

Again, this is a nested shell, so you need to `exit` or ctrl-d to get back to listing mode.

## Other tools

All cardigan commands can be executed directly without entering a shell:

    cardigan touch create the first card
    cardigan touch create the second card
    cardigan ls

zsh command line completion for this can be configured by creating a symlink to the gem tools/zsh/_cardigan from one of the directories in $fpath.

## Future plans

Refer to the .cards for detailed story breakdown but automatic vcs interaction and generating pretty html reports/charts seem to be the most important missing features.