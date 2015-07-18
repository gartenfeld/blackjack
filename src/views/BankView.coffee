class window.BankView extends Backbone.View
  className: 'bank'

  initialize: ->
    @model.on "change", @render, @

  template: _.template "Bankroll: $<%- playerWallet %>"

  betTemplate: _.template '
    <button class="bet-button">Bet $5</button>
    <button class="bet-close-button">Play</button>
  '

  potTemplate: _.template '
    Pot:
      <div id="pot-amount"><%- currentBet %></div>
  '

  events:
    # 'click .bet-button': -> @model.addBet(5)
    'click .bet-button': _.debounce( (-> @model.addBet(5)), 60, true)
    'click .bet-close-button': _.debounce( (-> @model.closeBets()), 100, true)

  render: ->
    @$el.find('#pot').html(@potTemplate(@model.attributes));
    @$el.find('#bank-controls').html @template(@model.attributes)
    if @model.get("app").get("state") is "takeBets"
      @$el.find('#bank-controls').append @betTemplate() 