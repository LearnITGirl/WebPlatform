@MenteeApplicationStep3 = React.createClass
  yesNoOptions: ->
    [
      {name: 'Yes', value: 'true'},
      {name: 'No', value: 'false'},
    ]

  operating_systems: ->
    [
      {name: 'Windows', value: 'windows'},
      {name: 'Mac OS', value: 'mac_os'},
      {name: 'Linux', value: 'linux'},
    ]

  participation_type: ->
    [
      {name: 'As mentor', value: 'mentor'},
      {name: 'As mentee', value: 'mentee'},
    ]

  infomation_channels: ->
    [
      {name: 'Facebook', value: 'facebook'},
      {name: 'Twitter', value: 'twitter'},
      {name: 'LinkedIn', value: 'linkedin'},
      {name: 'Alumni (Former mentor or mentee)', value: 'alumni'},
      {name: 'Word of mouth', value: 'word_of_mount'},
      {name: 'Other', value: 'other'},
    ]

  systemWarning: ->
    info = "We recomend to select Pyhton/Django as you programming language rather than Ruby/Rails, if you are going to use Windows OS"
    React.DOM.div
      className: 'hint-message'
      info

  render: ->
    React.DOM.div
      className: 'fields'
      React.createElement(ApplicationRadioGroup, key: 'programmingLanguage', field: 'programming_language', groupId: 'other', options: @props.programming_languages, placeholder: "Which programming language or framework would you like to learn during the mentorship program?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationCheckboxGroup, key: 'otherProgrammingLanguages', field: 'other_programming_languages', groupId: 'opl', options: @props.programming_languages, placeholder: "To increase your chances of being matched to a suitable mentor, please consider specifying additional choices. (upto 4 choices)", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationRadioGroup, key: 'previousProgrammingExperience', field: 'previous_programming_experience', options: @yesNoOptions(), placeholder: "Do you have previous experience in any other programming language?", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application.previous_programming_experience == 'true'
        React.createElement(ApplicationTextArea, key: 'experience', field: 'experience', label: "Please name the language(s), your level of expertise (beginner, intermediate, professional) and tell us about the projects you have worked on.", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application.programming_language == 'ruby' && @props.application.operating_system == 'windows'
        @systemWarning()
      React.createElement(ApplicationTextArea, key: 'projectProposal', field: 'project_proposal', label: "What project would you like to develop during the learning period? Please come up with your own idea", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationTextArea, key: 'roadmap', field: 'roadmap', label: "Imagine you have been accepted to the program. Please describe how a typical week as a mentee at Learn IT, Girl! looks like for you.", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationRadioGroup, key: 'timeAvailability', field: 'time_availability', options: @props.time_availabilities, placeholder: "How much time can you dedicate to learning through the program?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationCheckboxGroup, key: 'engagements', field: 'engagements', options: @props.engagements, placeholder: "Do you have any other engagements during the 3-month program period? Check all that apply", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationRadioGroup, key: 'previousParticipation', field: 'previous_participation', groupId: 'prev_part', options: @yesNoOptions(), placeholder: "Have you participated in a previous edition of Learn IT, Girl!?", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application.previous_participation == 'true'
        React.createElement(ApplicationCheckboxGroup, key: 'previousParticipationTypes', field: 'previous_participation_types', groupId: 'prev_part_type', options: @participation_type(), placeholder: "As who did you participate in the previous edition(s)?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationCheckboxGroup, key: 'perceivedMethods', field: 'perceived_methods', groupId: 'perceive', options: @infomation_channels(), placeholder: "Where did you hear about Learn IT, Girl?", application: @props.application, setApplicationField: @props.setApplicationField)
      if @props.application.perceived_methods && @props.application.perceived_methods.includes('other')
        React.createElement(ApplicationTextArea, key: 'perceivedOther', field: 'perceived_other', label: "How did you hear us?", application: @props.application, setApplicationField: @props.setApplicationField)
      React.createElement(ApplicationAgreeCheckbox, key: 'gdprConsent', field: 'gdpr_consent', name: 'I read and agree to the Privacy Policy', checked: false, placeholder: "Please read our GDPR compliant", link: {text: "Privacy Policy", href: "/privacy_policy"}, application: @props.application, setApplicationField: @props.setApplicationField)
