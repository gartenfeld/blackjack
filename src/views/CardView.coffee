class window.CardView extends Backbone.View
  className: 'card'

  template: _.template '<div></div>'

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    imgURL = @model.get('rankName') + '-' + @model.get('suitName') + '.png'
    @$el.html @template @model.attributes
    @$el.css 'background-image', 'url("img/cards/' + imgURL + '")'
    @$el.css 'background-image', 'url("img/card-back.png")' unless @model.get 'revealed'

