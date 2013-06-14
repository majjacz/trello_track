class DatePickerWithTimeInput < SimpleForm::Inputs::Base


  def initialize(*args)
    super(*args)
    @value = object.send(attribute_name)
    @model_name = object.class.name.underscore
  end

  def input
    "
    <span class='input-append date form-datepicker'>
      #{@builder.text_field(attribute_name, input_html_options_date)} <span class='add-on'><i class='icon-th'></i></span>
    </span>
    #{@builder.text_field(attribute_name, input_html_options_time)}
    ".html_safe
  end

  def input_html_options_date
    options = {
      value: @value.nil?? nil : @value.strftime('%d.%m.%Y'),
      style: "width: 90px;",
      id: "#{@model_name}_start_date",
      name: "#{@model_name}[start_date]"
    }
    input_html_options.merge options
  end

  def input_html_options_time
    options = {
      value: @value.nil?? nil : @value.strftime('%H:%M:%S'),
      data: { inputmask: "'mask': 'h:s[:s]'" },
      class: "time",
      style: "width: 70px;",
      id: "#{@model_name}_start_time",
      name: "#{@model_name}[start_time]"
    }
    input_html_options.merge options
  end

end
