class window.UserControlsView extends Backbone.View

  initialize: ->
    @model.on('change:state', @render, @)

  playTemplate: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
  '
  
  dealerTemplate: _.template '
    Dealer playing
  '

  endTemplate: _.template '
    <button class="play-again-button">Play Again</button>
  '

  render: ->
    #if model.state is gameplay, show some buttons
    #if model.state is score, show replay button
    if @model.get('state') is 'gamePlay'
      @$el.html @playTemplate()
    else if @model.get('state') is 'dealerTurn'
      @$el.html @dealerTemplate()
    else
      @$el.html @endTemplate()
  # flip: -> 

