class window.Bank extends Backbone.Model

  initialize: ->
    @set 'playerWallet', 200
    @set 'currentBet', 5

  addBet: (amount) ->
    @set('playerWallet', (@get('playerWallet') - amount))
    @set('currentBet', (@get('currentBet') + amount))

  closeBets: ->
    @trigger('betsPlaced')