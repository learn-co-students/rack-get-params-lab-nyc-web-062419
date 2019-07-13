class Application

  @@items = ["Apples","Carrots","Pears"]
  @@cart = []

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    #if the path requested matches items
    if req.path.match(/items/)
      #iterate through the @@items array
      @@items.each do |item|
        #write each element in that array
        resp.write "#{item}\n"
      end
      #implemement a search route 
    elsif req.path.match(/search/)
      #create variable set equal to req.params with 'q'for query passed in.
      search_term = req.params["q"]
      resp.write handle_search(search_term)



      #otherwise the path being searched matches cart.
      #new route to show items in cart.
    elsif req.path.match(/cart/)
      #If @@cart is empty
      if @@cart.empty?
        #return with following message
      resp.write "Your cart is empty."
      else
        #loop through and print each element that is in the @@ cart array
      @@cart.each do |item|
        resp.write "#{item}\n"
      end
    end
    #new route needs to be created to add items into cart
    elsif req.path.match(/add/)
      #created variable equals rack required parameters with item passed in
      item_add = req.params["item"]
      #if @@items includes variable set to the item that was passed into the req.param
      if @@items.include?(item_add)
        #shovel item_add into the @@cart array
        @@cart << item_add
        #print below with interpolated variable
        resp.write  "added #{item_add}."
      else
        #otherwise respond withg below
        resp.write "We don't have that item."
    end
  

    else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
