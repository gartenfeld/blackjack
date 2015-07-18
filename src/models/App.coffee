# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  initialize: ->
    @set 'bank', new Bank(app: @)
    @get('bank').on('betsPlaced', @closeBets, @)    
    @takeBets()
  
  takeBets: ->
    @get('bank').startBetting()
    @set 'state', 'takeBets'
  
  closeBets: ->
    @deal()
    
  deal: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @set 'state', 'gamePlay'
    @get('dealerHand').on('finishedHitting', @judge.bind(@))
    @get('playerHand').on('bust', @judge.bind(@))
    @get('playerHand').on('reachedTwentyOne', @stand.bind(@))
    if @get('playerHand').bestScore() is 21
      @set 'state', 'blackjack'
      console.log "Blackjack!"
      @get('bank').payout('blackjack')
    @trigger('refresh')

  stand: ->
    @get('dealerHand').reveal()
    @set 'state', 'dealerTurn'
    @get('dealerHand').autoHit()

  judge: ->
    if @get('playerHand').bestScore() > @get('dealerHand').bestScore()
      console.log('Player wins!')
      @get('bank').payout('win')
    else if @get('playerHand').bestScore() < @get('dealerHand').bestScore()
      console.log('Dealer wins! :(')
    else
      console.log('Push')
      @get('bank').payout('push')
    @set 'state', 'finished'

  reset: ->
    @takeBets()
