require ('pg')

class Property

  attr_accessor :address, :value, :num_of_bedrooms, :year_built
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @address = options['address']
    @value = options['value'].to_i
    @num_of_bedrooms = options['num_of_bedrooms'].to_i
    @year_built = options['year_built'].to_i
  end

  def save()
    #Connect to db
    db = PG.connect({dbname: 'propertiesdb', host: 'localhost'})
    #Build SQL command to insert data into table
    sql = "INSERT INTO property_tracker
    (address, value, num_of_bedrooms,year_built)
    VALUES ($1, $2, $3, $4) RETURNING id;"
    #Create values to replace placeholders with inst. variables
    values = [@address, @value, @num_of_bedrooms,@year_built]
    #Prepare sql
    db.prepare("save",sql)
    #execute SQL and get id
    result = db.exec_prepared("save", values)
    #assign id to the instance
    @id = result[0]['id'].to_i()
    #close db connection
    db.close()
  end

  def delete
    #connect
    db = PG.connect({dbname: 'propertiesdb', host: 'localhost'})
    #Build SQL command
    sql = "DELETE FROM property_tracker WHERE id = $1;"
    #placeholder values
    values = [@id]
    #prepare,exec,close db
    db.prepare("delete", sql)
    db.exec_prepared("delete", values)
    db.close()
  end

  def Property.delete_all()
    #connect
    db = PG.connect({dbname: 'propertiesdb', host: 'localhost'})
    sql = "DELETE FROM property_tracker;"
    #prep,exec,close
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all",[])
    db.close()
  end

  def Property.all()
    #connect
    db = PG.connect({dbname: 'propertiesdb', host: 'localhost'})
    sql = "SELECT * FROM property_tracker;"
    #prep,exec,close
    db.prepare("all",sql)
    properties = db.exec_prepared("all",[])
    db.close()
    return properties.map {|prop| Property.new(prop)}
  end


  def update()
    #connect
    db = PG.connect({dbname: 'propertiesdb', host: 'localhost'})
    #build sql
    sql = "UPDATE property_tracker SET (address, value, num_of_bedrooms, year_built)
    = ($1, $2, $3, $4) WHERE id = $5"
    #create placeholder values
    values = [@address, @value, @num_of_bedrooms, @year_built, @id]
    #prepare sql and close connection
    db.prepare("update",sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Property.find(id)
    #connect
    db = PG.connect({dbname: 'propertiesdb', host: 'localhost'})
    #build sql
    sql = "SELECT * FROM property_tracker WHERE id = $1;"
    #placeholder value
    value = [id]
    #prep,exec,close
    db.prepare("find", sql)
    result = db.exec_prepared("find", value)
    db.close()
    return result.map{|result| Property.new(result)}
  end

  def Property.find_by_address(address)
    #connect
    db = PG.connect({dbname: 'propertiesdb', host: 'localhost'})
    #build sql
    sql = "SELECT * FROM property_tracker WHERE address = $1;"
    #placeholder value
    value = [address]
    #prep,exec,close
    db.prepare("find", sql)
    result = db.exec_prepared("find", value)
    db.close()
    if result.values.length > 0
      return result.map{|result| Property.new(result)}
    else
      return nil
    end
  end




#
end
