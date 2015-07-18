class window.DeckView extends Backbone.View

  initialize: ->

  render: ->
    @$el.empty()
    @model.each (card, index) =>
      card.flip()
      styles = 
        'position': 'absolute', 
        'top': 20+2*index, 
        'left': 10, 
        'box-shadow': 'none'
      @$el.append(new CardView(model: card).$el.css(styles))