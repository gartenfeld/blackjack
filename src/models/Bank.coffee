class window.Bank extends Backbone.Model

  initialize: ->
    @set 'playerWallet', 200
    @set 'currentBet', 0

  startBetting: ->
    @set 'currentBet', 0
    @addBet 5

  addBet: (amount) ->
    @set('playerWallet', (@get('playerWallet') - amount))
    @set('currentBet', (@get('currentBet') + amount))

  closeBets: ->
    @trigger('betsPlaced')

  payout: (t) ->
    if t is "win" then c = 2
    if t is "push" then c = 1
    if t is "blackjack" then c = 3
    win = c * @get 'currentBet'
    console.log 'You got $' + win + '!'
    @set 'playerWallet', (@get 'playerWallet') + win