class window.BankView extends Backbone.View
  className: 'bank'

  initialize: ->
    @model.on "change", @render, @

  template: _.template "Player has $<%- playerWallet %> in bank account"

  betTemplate: _.template '
    <button class="bet-button">Bet $5</button>
    <button class="bet-close-button">Play</button>
  '

  events:
    'click .bet-button': -> @model.addBet(5)
    'click .bet-close-button': -> @model.closeBets()

  render: ->
    @$el.html @template(@model.attributes)
    if @model.get("app").get("state") is "takeBets"
      @$el.append(@betTemplate())