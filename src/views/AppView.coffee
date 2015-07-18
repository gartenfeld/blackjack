class window.AppView extends Backbone.View

  className: 'playArea'

  initialize: ->
    @render()
    @model.on('change', @render, @)
    #@model.on('refresh', @render, @)


  template: _.template '
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.stand()
    'click .play-again-button': -> @model.reset()

  render: ->
    # console.log "rendering app view, state is " + @model.get('state')
    if @model.get('state') isnt 'takeBets'
      @$el.children().detach()
      @$el.html @template()
      @$el.prepend new UserControlsView(model: @model).render()
      @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
      @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el
      new DeckView(model: @model.get("deck"), el: $('#deck')).render()
      new BankView(model: @model.get("bank"), el: $('#bank')).render()
    else
      new BankView(model: @model.get("bank"), el: $('#bank')).render()
