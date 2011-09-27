# 0.1.1 (unreleased)

* fixed bug - cardigan would crash when entering workflow shell if no workflow existed yet
* fixed bug - csv import didn't use correct 1.9 csv api
* fixed bug - import was ignoring id when a card with that id did not already exist
* fixed bug - cards were not saved after cd unless an attribute other than name was set
* added .cardigan file to store display and sort columns and filter
* added direct execution of commands (to bypass entering the shell)
* added zsh completion
* removed support for 1.9
* added heaps of testing
* documentation now published to relishapp/cardigan