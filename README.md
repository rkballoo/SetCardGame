# SetCardGame

This is an application implementing the Set Card Game (https://en.wikipedia.org/wiki/Set_(card_game)) in Swift.

This implementation follows the requirements outlined in the third and fourth Programming Assignment of the publicly available:
2021 version of the 'CS193p - Developing Apps for iOS' course from Stanford University: https://cs193p.sites.stanford.edu/

Listed below are the required tasks and the extra credit tasks, lifted from https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/assignment_3_0.pdf
and
https://cs193p.sites.stanford.edu/sites/g/files/sbiybj16636/files/media/file/assignment_4_0.pdf

# Functionality Implementation 
  # Required Tasks

  1. Implement a game of solo (i.e. one player) Set.
   
  2. As the game play progresses, try to keep all the cards visible and as large as possible.
  In other words, cards should get smaller (or larger) as more (or fewer) appear on-
  screen at the same time. It’s okay if you want to enforce a minimum size for your
  cards and then revert to scrolling when there are a very large number of cards.
  Whatever way you deal with “lots of cards” on screen, it must always still be possible
  to play the game (i.e. cards must always be recognizable, even when all 81 are in play
  at the same time).
  
  3. Cards can have any aspect ratio you like, but they must all have the same aspect ratio at
  all times (no matter their size and no matter how many are on screen at the same
  time). In other words, cards can be appearing to the user to get larger and smaller as
  the game goes on, but the cards cannot be “stretching” into different aspect ratios as
  the game is played.
  
  4. The symbols on cards should be proportional to the size of the card (i.e. large cards
  should have large symbols and smaller cards should have smaller symbols).
  
  5. Users must be able to select up to 3 cards by touching on them in an attempt to make
  a Set (i.e. 3 cards which match, per the rules of Set). It must be clearly visible to the
  user which cards have been selected so far.
  
  6. After 3 cards have been selected, you must indicate whether those 3 cards are a match
  or mismatch. You can show this any way you want (colors, borders, backgrounds,
  whatever). Anytime there are 3 cards currently selected, it must be clear to the user
  whether they are a match or not (and the cards involved in a non-matching trio must
  look different than the cards look when there are only 1 or 2 cards in the selection).
  
  7. Support “deselection” by touching already-selected cards (but only if there are 1 or 2
  cards (not 3) currently selected).
  
  8. When any card is touched on and there are already 3 matching Set cards selected,
  then ...
      a. as per the rules of Set, replace those 3 matching Set cards with new ones from the
      deck
      b. if the deck is empty then the space vacated by the matched cards (which cannot be
      replaced since there are no more cards) should be made available to the remaining
      cards (i.e. which may well then get bigger)
      c. if the touched card was not part of the matching Set, then select that card
      d. if the touched card was part of a matching Set, then select no card

  9. When any card is touched and there are already 3 non-matching Set cards selected,
  deselect those 3 non-matching cards and select the touched-on card (whether or not it
  was part of the non-matching trio of cards).

  10. You will need to have a “Deal 3 More Cards” button (per the rules of Set).
      a. when it is touched, replace the selected cards if the selected cards make a Set
      b. or, if the selected cards do not make a Set (or if there are fewer than 3 cards
      selected, including none), add 3 new cards to join the ones already on screen (and
      do not affect the selection)
      c. disable this button if the deck is empty

  11. You also must have a “New Game” button that starts a new game (i.e. back to 12
  randomly chosen cards).

  12. To make your life a bit easier, you can replace the “squiggle” appearance in the Set
  game with a rectangle.

  13. You must author your own Shape struct to do the diamond.

  14. Another life-easing change is that you can use a semi-transparent color to represent
  the “striped” shading. Be sure to pick a transparency level that is clearly
  distinguishable from “solid”.

  15. You can use any 3 colors as long as they are clearly distinguishable from each other.

  16. You must use an enum as a meaningful part of your solution.

  17. You must use a closure (i.e. a function as an argument) as a meaningful part of your
  solution.

  18. Your UI should work in portrait or landscape on any iOS device. This probably will
  not require any work on your part (that’s part of the power of SwiftUI), but be sure to
  experiment with running on different simulators/Previews in Xcode to be sure.

  # Extra Credit

  1. Draw the actual squiggle instead of using a rectangle.
  
  2. Draw the actual striped “shading” instead of using a semi-transparent color.
  
  3. Keep score somehow in your Set game. You can decide what sort of scoring would
  make the most sense.
  
  4. Give higher scores to players who choose matching Sets faster (i.e. incorporate a time
  component into your scoring system).
  
  5. Figure out how to penalize players who chose Deal 3 More Cards when a Set was
  actually available to be chosen.
  
  6. Add a “cheat” button to your UI.
  
  7. Support two players. No need to go overboard here. Maybe just a button for each
  user (one upside-down at the top of the screen maybe?) to claim that they see a Set on
  the board. Then that player gets a (fairly short) amount of time to actually choose the
  Set or the other person gets as much time as they want to try to find a Set (or maybe
  they get a longer, but not unlimited amount of time?). Maybe hitting “Deal 3 More
  Cards” by one user gives the other some medium amount of time to choose a Set
  without penalty? You will need to figure out how to use Timer to do these time-
  limited things.
  
    Has not been implemented yet.
  
  8. Can you think of a way to make your application work for color-blind people? If you
  tackle this Extra Credit, make it so that “color-blind mode” is on only if some Bool
  somewhere is set to true (and submit your application with it in the false state). In
  other words, you must still satisfy the Required Tasks and they specifically ask you to
  use 3 distinct colors. Some UI to change the value of this Bool is not required, but
  you can include it if you want.
  
# Animations Implementation
  # Required Tasks
  
  1. Your assignment this week must still play a solo game of Set.

  2. In this version, though, when there is a match showing and the user chooses another
  card, do not replace the matched cards; instead, discard them (leaving fewer cards in
  the game).
  
  3. Add a “deck” and a “discard pile” to your UI. They can be any size you want and
  you can put them anywhere you want on screen, but they should not be part of your
  main grid of cards and they should each look like a stack of cards (for example, they
  should have the same aspect ratio as the cards that are in play).
  
  4. The deck should contain all the not-yet-dealt cards in the game. They should be “face
  down” (i.e. you should not be able to see the symbols on them).
  
  5. The discard pile should contain all the cards that have been discarded from the game
  (i.e. the cards that were discarded because they matched). These cards should be face
  up (i.e. you should be able to see the symbols on the last discarded card). Obviously the
  discard pile is empty when your game starts.
  
  6. Any time matched cards are discarded, they should be animated to “fly” to the discard
  pile.
  
  7. You don’t need your “Deal 3 More Cards” button any more. Instead, tapping on the deck
  should deal 3 more cards.
  
  8. Whenever more cards are dealt into the game for any reason (including to start the
  game), their appearance should be animated by “flying them” from the deck into
  place.
  
  9. Note that dealing 3 more cards when a match is showing on the board still should
  replace those cards and that those matched cards would be flying to the discard pile at
  the same time as the 3 new cards are flying from the deck (see Extra Credit too).
  
  10.All the card repositioning and resizing that was required by Required Task 2 in last
  week’s assignment must now be animated. If your cards from last week never changed
  their size or position as cards were dealt or discarded, then fix that this week so that
  they do.
  
  11.When a match occurs, use some animation (your choice) to draw attention to the
  match.
  
  12.When a mismatch occurs, use some animation (your choice) to draw attention to the
  mismatch. This animation must be very noticeably different from the animation used
  to show a match (obviously).
  
  # Extra Credit

  1. Have your deck and/or discard pile be either “sloppy” (i.e. not a perfectly neat stack)
  or show the first few cards slightly offset (so that it looks more like a stack).
  
  2. When you deal 3 more cards and there is a match showing, start animating the
  matched cards flying to the discard pile before the animation of the 3 new cards flying
  in from the deck starts. In other words, give the user a better impression of “I just
  replaced these 3 cards for you” by delaying the dealing animation a short bit in this
  scenario. The animations can still overlap, but delaying the dealing one just a little bit
  can result in a pleasing effect.
  
  3. Make the cards that you deal out flip from face down (as they are in the deck) to face
  up (as they are once they are in play). You can use/modify the .cardify
  ViewModifier from lecture if you want.
  
  4. Add any other animation you can think of that would make sense.
