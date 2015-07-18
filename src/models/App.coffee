# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  initialize: ->
    @set 'bank', new Bank(app: @)
    @get('bank').on('betsPlaced', @closeBets, @)    
    @takeBets()
  
  takeBets: ->
    @set 'state', 'takeBets'
  
  closeBets: ->
    console.log("closing bets")
    @set 'state', 'gamePlay'
    @deal()

  deal: ->
    @set 'state', 'takeBets'
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('dealerHand').on('finishedHitting', @judge.bind(@))
    @get('playerHand').on('bust', @judge.bind(@))
    @get('playerHand').on('yay', @stand.bind(@))
    if @get('playerHand').bestScore() is 21 then @set 'state', 'blackjack'
    @trigger('refresh')

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
