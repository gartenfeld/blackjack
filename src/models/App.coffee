# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model
  initialize: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()

  stand: ->
    @get('dealerHand').reveal()
    @get('dealerHand').autoHit()
    @judge()

  judge: ->
    console.log @get('playerHand').bestScore()
    if @get('playerHand').bestScore() > @get('dealerHand').bestScore()
      console.log('Player wins!')
    else if @get('playerHand').bestScore() < @get('dealerHand').bestScore()
      console.log('Dealer wins! :(')
    else
      console.log('Push');