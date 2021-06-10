=begin
P
  - create a game of 21
  - inputs and outputs, various
E
  - n/a
D
  - what will we use for the deck?
    - a hash worked well at one point and can make
      data retrieval clearer vs. a massive array...
      - don't be hesitant to use a hash; let's use it
A
  High level:
  Greeting
  Deal cards
    - generate a deck
    - track dealt cards
  Player turn
  Dealer turn
  Show result
  
  Considerations:
    - play again loop
    - setting name
    - tracking points
       - these are bonus features; let's get a basic
         game going first with a play again feature
  
  Implementations:
  Greeting
    > greet the player
      - prompt method + yaml,
  
  Deal Cards
    > generate a deck
      - create a constant for suits
        - store in card class
      - create a constant for cards themselves
        - stock in card class
      * a card knows its suit; a card knows its value
      * initially discussed hash, but array seems to fit better...
    > deal hands
      - done
    > display deal results
      - show both cards in player hand
      - show one card from dealer hand
      *Do I create a separate Handable module? Or do I keep the 
       logic in the Player class?*
      - moved to Handable module; module will handle card processing
  
  Player Turn
    > ask for decision
      - the deck was dealing originally, but hitting is an action
        performed by a player...and they involve the same
        logic - a card moves from the deck to the player hand
          - the issue is who's doing the dealing
            - what is hitting? hitting is the player asking for 
              another card
            - what is dealing? dealing is the dealer dealing a card
              - in both of these scenarios, a dealer is involved
                - should the dealer subclass from Player? or
                  should there be a single player class and a Dealer
                  class that handles dealing?
    > I am stuck
      - how do we handle the hit loop now?
      - how do we get the player and the deck to interact
        without creating spaghetti?
      - 
                  
      
      
      
      
      
      
      
      
      
      
=end