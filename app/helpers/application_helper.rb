# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def province_options
    [
      ["Alberta", "AB"], 
      ["British Columbia", "BC"], 
      ["Manitoba", "MB"], 
      ["New Brunswick", "NB"], 
      ["Newfoundland and Labrador", "NL"], 
      ["Northwest Territories", "NT"], 
      ["Nova Scotia", "NS"], 
      ["Nunavut", "NU"], 
      ["Ontario", "ON"], 
      ["Prince Edward Island", "PE"], 
      ["Quebec", "QC"], 
      ["Saskatchewan", "SK"], 
      ["Yukon", "YT"]
    ]
  end
  
  def volunteer_contract_text
    # todo: get the contract text from a textfile?
    "THIS IS THE VOLUNTEER CONTRACT
    
    Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam vel mattis mauris. Ut pharetra nisl sit amet justo gravida imperdiet. Maecenas et nisl congue massa vulputate imperdiet in ac neque. Proin eget posuere lorem. Duis ullamcorper pharetra arcu, ut viverra enim tristique sit amet. Integer id fringilla lorem. Vestibulum congue enim quis elit scelerisque non tincidunt risus rhoncus. Nulla vestibulum posuere mi, ac sagittis ligula tincidunt nec. Mauris pretium, est eu iaculis dapibus, turpis sem lobortis turpis, nec varius nibh augue eu massa. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed placerat sodales pellentesque. Aliquam eget tincidunt eros. Pellentesque dolor turpis, volutpat in aliquam et, sagittis et quam. Curabitur fringilla mollis arcu, pellentesque sodales ligula tempus at. In at tellus in massa elementum feugiat. Suspendisse nisl nulla, condimentum et ultrices non, commodo id justo. Vestibulum felis diam, rutrum ac tincidunt nec, vehicula eu nibh. Maecenas sollicitudin condimentum imperdiet.

    Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Etiam posuere scelerisque velit, in eleifend velit pulvinar ut. Aenean ligula felis, bibendum nec elementum ac, eleifend quis urna. Fusce rutrum aliquam tortor vel blandit. Nam lacinia interdum varius. Aenean pellentesque tincidunt cursus. Suspendisse sit amet leo a sem fermentum eleifend eget et purus. Maecenas fringilla blandit convallis. Donec congue feugiat orci in dapibus. Nulla eget odio diam. Cras sollicitudin pharetra leo, et iaculis nibh blandit ac.

    Sed ut mi odio, eget hendrerit tellus. Quisque malesuada libero ut quam lacinia egestas. Mauris ullamcorper, dolor eu laoreet placerat, tellus tortor ultrices eros, ac pharetra mi erat id lorem. Pellentesque pharetra sagittis ante vitae malesuada. Duis vitae turpis eget erat vulputate iaculis sit amet in purus. Praesent mattis massa commodo dui molestie sed adipiscing enim elementum. Aliquam erat volutpat. Curabitur dui turpis, lacinia fermentum vestibulum quis, ultricies ut libero. Nunc velit mauris, pharetra tempus lobortis at, facilisis id eros. Maecenas facilisis molestie lacinia.

    Nam facilisis tellus mi, vitae elementum tellus. Cras sed luctus lectus. Nulla eu egestas lectus. Donec metus magna, sodales sit amet ultricies ac, blandit nec justo. Pellentesque arcu orci, facilisis malesuada varius quis, cursus consectetur lorem. Vestibulum interdum metus at lorem viverra fringilla. Cras in leo ac lacus facilisis placerat et ac quam. Integer aliquet, mauris sed commodo commodo, nisl tortor pellentesque odio, at sodales mi quam id odio. Phasellus venenatis orci ut odio hendrerit vulputate. Cras ut lacus tortor."
  end
end
