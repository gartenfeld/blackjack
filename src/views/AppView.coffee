class window.AppView extends Backbone.View

  className: 'playArea'

  initialize: ->
    @render()
    @model.on('change', @render, @)


  template: _.template '
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': -> @model.stand()
    'click .play-again-button': -> @model.reset()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$el.prepend new UserControlsView(model: @model).render()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el