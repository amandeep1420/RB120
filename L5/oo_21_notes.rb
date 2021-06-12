=begin

Things I struggled with/notes:

- mapping out my classes and allocating methods.
  - the dealer vs. deck issue: who deals? should the dealer be its own standalone class?
  - should I make a single player class? is this too messy/too much of a web?
  - I settled on the deck dealing itself always as it was consistent with the initial deal
    method I created, but is this ideal? did I run with this to avoid grappling with it?
  - how do we contextualize things properly after consdering real-world implementation? 
    a deck doesn't deal itself, but does that make sense in a programmatic approach? 
    cards constitute a deck, so how do you properly model that with coupling of methods, etc.?
  - I decided to more closely link the Human and Deck classes; I don't like this at all.
  - after sleeping on it, I decided to have the Deck class only interact with the 
    @hand attribute of each player; I'm unsure if I allocated responsibilities correctly
    in terms of developing a interaction/hierarchy map, but I feel better about this. 
    Deck can now only see a player's hand vs. seeing the entirety of the player object
    itself. I'm running with this for the time being
- understanding the responsibility of each class. 
  - Game orchestrates the others.
  - Card shouldn't be aware of players.
  - so on
  - *unrelated classes use collaborator objects to interact*
- what should be a module. 
  - Handable...is it necessary? I like sequestering hand processing methods, but does it 
    increase complication?
  - the Interactable module was borne of laziness, hehe
- minor things
  - always close off methods and classes immediately to avoid hunting later
  - alphabetical order
  - class organization order
  - hardcoded dealer hand minimum and max points into YAML because blah
  - implemented name functionality later, only used to say goodbye and announce grand
    winner
  
  
=end
