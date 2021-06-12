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
        - this is an example of exposing only the necessary attributes/state to a 
          particular interface
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
  - recap doesn't display if points are zero; this is a little odd since you can 
    tie multiple times in a row but still have no recap display
        - should I implement round tracking?
  - writing code you 'wished existed' helped a lot!
- importance of using a plan/PEDAC to keep your focus narrow at each stage
    - I bounced around and didn't realize I had missed key functionality in methods
    (i.e. reset method wasn't generating a new deck) until I reviewed someone else's
    code
- how much abstraction is too much abstraction
    - trying to keep helper methods at same level of abstraction, but
      I feel like I'm making unnecessary methods at times when the 
      method body itself is a single line just to keep things at the
      same level of abstraction - is this a problem?
  
  
- features
    - name; added late, not used much
    - tracking rounds for an ultimate win and resetting gamestate accordingly
    - "stories" during dealer turn; didn't take it as far as setting a personality,
       did not include an option to skip it...sorry
    - adjusting points to win game, minimum dealer hand total threshold, max hand total
    
- other notes
    - style consistency; used setters whenever possible
=end
