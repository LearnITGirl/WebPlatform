@MentorApplicationStep5 = React.createClass
  render: ->
    React.DOM.div
      className: 'fields'
      React.createElement(ApplicationRadioGroup, key: 'timeAvailability', field: 'time_availability', options: @props.time_availabilities, placeholder: "How much time can you dedicate to learning through the program?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationCheckboxGroup, key: 'engagements', field: 'engagements', options: @props.engagements, placeholder: "Do you have any other engagements during the 3-month program period? Check all that apply", application: @props.application, setApplicationField: @props.setApplicationField)
