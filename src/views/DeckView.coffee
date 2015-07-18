class window.DeckView extends Backbone.View

  initialize: ->

  render: ->
    @$el.empty()
    @model.each (card, index) =>
      card.flip()
      @$el.append(new CardView(model: card).$el.css('position': 'absolute', 'top': 40+2*index, 'left': '40px', 'box-shadow': 'none'))