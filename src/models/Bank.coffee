class window.Bank extends Backbone.Model

  initialize: ->
    @set 'playerWallet', 1005
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
    if t is "win"
      c = 2
      m1 = 'You won $'
      m2 = '!'
    if t is "push"
      c = 1
      m1 = 'Push! You get $'
      m2 = 'back!'
    if t is "blackjack"
      c = 3
      m1 = 'You hit the blackjack! \nHere\'s $'
      m2 = '!'
    win = c * @get 'currentBet'
    $('#message').css('opacity': 1)
    $('#message').text(m1 + win + m2)
    @set 'playerWallet', (@get 'playerWallet') + win
