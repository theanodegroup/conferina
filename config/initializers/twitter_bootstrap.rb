# error_span fix
if defined?(SimpleForm::FormBuilder)
  SimpleForm::FormBuilder.send(:include, FormErrorsHelper)
end