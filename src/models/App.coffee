# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  initialize: ->
    @deal()
  
  deal: ->
    @set 'state', 'gamePlay'
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('dealerHand').on('finishedHitting', @judge.bind(@))
    

  stand: ->
    @get('dealerHand').reveal()
    @set 'state', 'dealerTurn'
    @get('dealerHand').autoHit()

  judge: ->
    if @get('playerHand').bestScore() > @get('dealerHand').bestScore()
      console.log('Player wins!')
    else if @get('playerHand').bestScore() < @get('dealerHand').bestScore()
      console.log('Dealer wins! :(')
    else
      console.log('Push');
    @set 'state', 'finished'

  reset: ->
    @deal()
