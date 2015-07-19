class window.UserControlsView extends Backbone.View

  initialize: ->
    @model.on('change:state', @render, @)

  playTemplate: _.template '
    <button class="hit-button">Hit</button>
    <button class="stand-button">Stand</button>
  '
  
  dealerTemplate: _.template ''

  endTemplate: _.template '
    <button class="play-again-button">Play Again</button>
  '

  blackjackTemplate: _.template '
    <button class="play-again-button">Play Again</button>
  '

  render: ->
    #if model.state is gameplay, show some buttons
    #if model.state is score, show replay button
    @$el.empty()
    if @model.get('state') is 'gamePlay'
      @$el.html @playTemplate()
    else if @model.get('state') is 'dealerTurn'
      @$el.html @dealerTemplate()
    else if @model.get('state') is 'blackjack'
      @$el.html @blackjackTemplate()
    else if @model.get('state') is 'finished'
      @$el.html @endTemplate()
  # flip: -> 

