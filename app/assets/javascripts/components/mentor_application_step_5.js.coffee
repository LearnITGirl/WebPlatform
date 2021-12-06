@MentorApplicationStep5 = React.createClass
  infomation_channels: ->
    [
      {name: 'Facebook', value: 'facebook'},
      {name: 'Twitter', value: 'twitter'},
      {name: 'LinkedIn', value: 'linkedin'},
      {name: 'Alumni (Former mentor or mentee)', value: 'alumni'},
      {name: 'Word of mouth', value: 'word_of_mount'},
      {name: 'Other', value: 'other'},
    ]

  render: ->
    React.DOM.div
      className: 'fields'
      React.createElement(ApplicationRadioGroup, key: 'timeAvailability', field: 'time_availability', options: @props.time_availabilities, placeholder: "How much time can you dedicate to learning through the program?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationCheckboxGroup, key: 'engagements', field: 'engagements', options: @props.engagements, placeholder: "Do you have any other engagements during the 3-month program period? Check all that apply", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationCheckboxGroup, key: 'perceivedMethods', field: 'perceived_methods', groupId: 'perceive', options: @infomation_channels(), placeholder: "Where did you hear about Learn IT, Girl!?", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application.perceived_methods && @props.application.perceived_methods.includes('other')
        React.createElement(ApplicationTextArea, key: 'perceivedOther', field: 'perceived_other', label: "How did you hear about us?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationAgreeCheckbox, key: 'gdprConsent', field: 'gdpr_consent', name: 'I read and agree to the Privacy Policy', checked: false, placeholder: "Please read our GDPR compliant", link: {text: "Privacy Policy", href: "/privacy_policy"}, application: @props.application, setApplicationField: @props.setApplicationField)
