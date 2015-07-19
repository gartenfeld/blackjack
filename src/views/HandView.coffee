class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<% if(isDealer){ %>
  <h2>Dealer
  <% } else { %>
  <h2>You
  <% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    deck = @$el
    @collection.map (card) ->
      spot = new CardView(model: card).$el.css('opacity': 0)
      deck.append(spot.animate('opacity': 1))
    @$('.score').text if @collection.bestScore() is 0 then "BUST" else @collection.bestScore()

