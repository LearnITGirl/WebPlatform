@ApplicationStepButtons = React.createClass
  render: ->
    React.DOM.div
      className: "form-group buttons text-center"
      if @props.step > 1
        React.DOM.a
          className: 'btn btn-pink'
          onClick: @props.previousStep
          "Back"

      if @props.step < 4
        React.DOM.button
          type: 'submit'
          className: "btn btn-pink"
          onClick: @props.nextStep
          "Next step"

      if @props.step == 4
        React.DOM.button
          type: 'submit'
          className: "btn btn-pink"
          onClick: @props.nextStep
          "Finish"

      React.DOM.p null
        "Step #{@props.step}/4"
