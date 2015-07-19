# TODO: Refactor this model to use an internal Game Model instead
# of containing the game logic directly.
class window.App extends Backbone.Model

  initialize: ->
    @set 'bank', new Bank(app: @)
    @get('bank').on('betsPlaced', @closeBets, @)    
    @takeBets()
  
  takeBets: ->
    $('#message').css('opacity': 0)
    @get('bank').startBetting()
    @set 'state', 'takeBets'
  
  closeBets: ->
    @deal()
    
  deal: ->
    @set 'deck', deck = new Deck()
    @set 'playerHand', deck.dealPlayer()
    @set 'dealerHand', deck.dealDealer()
    @get('playerHand').on('bust', @judge.bind(@))
    @get('dealerHand').on('bust', @judge.bind(@))
    @get('playerHand').on('reachedTwentyOne', @stand.bind(@))
    @get('dealerHand').on('finishedHitting', @judge.bind(@))
    @set 'state', 'gamePlay'
    @trigger('refresh')
    if @get('playerHand').bestScore() is 21
      @set 'state', 'blackjack'
      @get('bank').payout('blackjack')

  stand: ->
    @get('dealerHand').reveal()
    @set 'state', 'dealerTurn'
    @get('dealerHand').autoHit()

  judge: ->
    @set 'state', 'dealerTurn'
    if @get('playerHand').bestScore() > @get('dealerHand').bestScore()
      @get('bank').payout('win')
    else if @get('playerHand').bestScore() < @get('dealerHand').bestScore()
      $('#message').css('opacity': 1)
      $('#message').text('You lost $' + @get('bank').get('currentBet'))
    else
      @get('bank').payout('push')
    @set 'state', 'finished'

  reset: ->
    @takeBets()
