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
    ***Do I create a separate Handable module? Or do I keep the logic in the Player class?***
    
      
      
      
      
      
      
      
      
      
      
=end