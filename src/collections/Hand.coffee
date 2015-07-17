class window.Hand extends Backbone.Collection
  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: ->
    @add(@deck.pop())

  autoHit: ->
    if @bestScore() < 17 and @bestScore() isnt 0
      setTimeout => 
        @hit()
        @autoHit()
      , 500
    else
      @trigger "finishedHitting"

  reveal: ->
    @each (card) ->
      card.setFaceUp()

  hasAce: -> @reduce (memo, card) ->
    memo or card.get('value') is 1
  , 0

  minScore: -> @reduce (score, card) ->
    score + if card.get 'revealed' then card.get 'value' else 0
  , 0

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    [@minScore(), @minScore() + 10 * @hasAce()]

  bestScore: ->
    adjustedScore = (for score in @scores()
      if score > 21 then 0 else score)
    Math.max adjustedScore...



